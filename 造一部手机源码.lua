--[[
  巫 · 造一部手机源码（Obsidian UI · 与 ka 同款库）
  UI: https://github.com/deividcomsono/Obsidian
  无启动音效；背景图见 BG_URL
]]
print("[造一部手机] 加载中...")

if getgenv and getgenv().WuPhoneTycoonLoaded then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "造一部手机",
            Text = "已经加载 请勿重复点击",
            Duration = 3,
        })
    end)
    pcall(function()
        local ui = getgenv().WuPhoneBuildUI or getgenv().WuPhoneTycoonUI
        if ui then ui.Enabled = true end
    end)
    return
end

local PHONE_PLACE = {
    [101914705206759] = true, -- Build a Phone Empire
}
local function isPhoneServer()
    if PHONE_PLACE[game.PlaceId] then return true end
    local ok, g = pcall(function()
        local lp = game:GetService("Players").LocalPlayer
        return lp and lp:FindFirstChild("PlayerGui") and lp.PlayerGui:FindFirstChild("PhoneTycoonGui")
    end)
    return ok and g ~= nil
end

if not isPhoneServer() then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "造一部手机",
            Text = "该服务器不支持",
            Duration = 5,
        })
    end)
    warn("[造一部手机] 非目标服 PlaceId=", game.PlaceId)
    return
end

local okGui, phoneGui = pcall(function()
    return game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("PhoneTycoonGui", 12)
end)
if not okGui or not phoneGui then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "造一部手机",
            Text = "未检测到 PhoneTycoonGui",
            Duration = 5,
        })
    end)
    warn("[造一部手机] 无 PhoneTycoonGui")
    return
end

local function runModule(src, tag)
    local fn, err = loadstring(src)
    if not fn then
        warn("[造一部手机]", tag, "编译失败:", err)
        return false
    end
    local ok, e = pcall(fn)
    if not ok then
        warn("[造一部手机]", tag, "执行失败:", e)
        return false
    end
    return true
end

-- ========== 模块：自动研究 ==========
runModule([===[
--== Auto Research v11：优先 Remote 直发，失败再离屏 UI ==--
-- 游戏机制限制（实测）：
--   · 关窗会清空研究网格，仅 CW.Visible=true 才会重建
--   · 开窗会冻结游戏日，所以 UI 路径仍须尽快关窗
-- v11 策略：
--   1) 若已缓存到 StartResearch 相关 Remote → 不打开面板，直接 Fire/Invoke
--   2) 否则走离屏开窗（v10），并在点击 Start 时用 namecall 钩子记录 Remote
--   3) 记录成功后下一轮自动走 Remote

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local gui = Players.LocalPlayer.PlayerGui:WaitForChild("PhoneTycoonGui")
local CW = gui.Root.Hud.GameWindow
local pane = CW.PanelContent

local prev = getgenv().__autoResearch
if prev and prev.running then pcall(function() prev.stop() end) end

local CACHE_FILE = "WuPhone_ResearchRemote.json"
local S = {
	running = false, starts = 0, fails = 0,
	lastEvent = "idle", lastCard = "", lastNode = "", lastCost = 0, lastStartText = "",
	rp = 0, day = 0, targetDay = 0, daysLeft = 0,
	progress = 0, -- 0~100 研究进度
	busy = false, lab = "idle", panelOpen = false,
	busyPoll = 5,
	retryWait = 10,       -- 空闲轮询
	failRetryWait = 45,   -- 点了但没成功：拉长间隔
	rpWait = 120,         -- RP 不够时：长时间不打开研究页
	rpWaitUntil = 0,      -- os.clock 时间戳
	needRp = 0,           -- 下一档最便宜所需 RP
	remoteMode = false,
}
getgenv().__autoResearch = S

-- ---------- Remote 缓存 ----------
local function loadCache()
	local c = getgenv().__researchRemoteCache
	if type(c) == "table" and c.remoteName then return c end
	pcall(function()
		if isfile and isfile(CACHE_FILE) and readfile then
			local raw = readfile(CACHE_FILE)
			-- 极简解析：name|pathHint|arg1
			local name, hint, a1 = tostring(raw):match("^([^|]+)|([^|]*)|(.*)$")
			if name and name ~= "" then
				getgenv().__researchRemoteCache = {
					remoteName = name,
					pathHint = hint or "",
					sampleArg = a1,
				}
			end
		end
	end)
	return getgenv().__researchRemoteCache
end

local function saveCache(c)
	getgenv().__researchRemoteCache = c
	pcall(function()
		if writefile then
			writefile(CACHE_FILE, string.format("%s|%s|%s",
				tostring(c.remoteName or ""),
				tostring(c.pathHint or ""),
				tostring(c.sampleArg or "")))
		end
	end)
end

local function findRemoteByName(name)
	if not name or name == "" then return nil end
	local lname = string.lower(name)
	local best
	for _, d in ipairs(RS:GetDescendants()) do
		if (d:IsA("RemoteEvent") or d:IsA("RemoteFunction")) and string.lower(d.Name) == lname then
			return d
		end
	end
	-- 模糊
	for _, d in ipairs(RS:GetDescendants()) do
		if d:IsA("RemoteEvent") or d:IsA("RemoteFunction") then
			local n = string.lower(d.Name)
			if n:find("research", 1, true) and (n:find("start", 1, true) or n:find("begin", 1, true)) then
				best = best or d
			end
		end
	end
	return best
end

-- 临时钩住 namecall，捕获一次 FireServer/InvokeServer
local capture = { active = false, list = {} }
local function beginCapture(sec)
	capture.active = true
	capture.list = {}
	pcall(function()
		if getgenv().__researchNamecallHooked then return end
		local mt = getrawmetatable(game)
		local old = mt.__namecall
		setreadonly(mt, false)
		mt.__namecall = newcclosure(function(self, ...)
			local method = getnamecallmethod()
			if capture.active and (method == "FireServer" or method == "InvokeServer") then
				local sn = tostring(self and self.Name)
				local low = string.lower(sn)
				if low:find("research") or low:find("lab") or low:find("tech") or low:find("node") then
					local args = {...}
					table.insert(capture.list, {
						name = sn,
						method = method,
						class = self.ClassName,
						arg1 = args[1],
						argCount = #args,
					})
				end
			end
			return old(self, ...)
		end)
		setreadonly(mt, true)
		getgenv().__researchNamecallHooked = true
	end)
	task.delay(sec or 3, function() capture.active = false end)
end

local function finishCaptureAndSave(preferNodeName)
	capture.active = false
	if #capture.list == 0 then return false end
	-- 优先名字最像 start research 的
	local pick = capture.list[1]
	for _, e in ipairs(capture.list) do
		local n = string.lower(e.name)
		if n:find("start") or n:find("begin") then pick = e break end
	end
	local arg1 = pick.arg1
	if preferNodeName and (arg1 == nil or arg1 == "") then
		arg1 = preferNodeName
	end
	saveCache({
		remoteName = pick.name,
		pathHint = pick.class,
		sampleArg = arg1,
		method = pick.method,
	})
	S.lastEvent = "cached remote: " .. tostring(pick.name)
	print("[研究] 已缓存 Remote:", pick.name, "arg1=", tostring(arg1))
	return true
end

local function tryRemoteStart(nodeName, cost)
	local c = loadCache()
	if not c or not c.remoteName then return false, "no cache" end
	local remote = findRemoteByName(c.remoteName)
	if not remote then return false, "remote missing: " .. tostring(c.remoteName) end

	local arg = nodeName or c.sampleArg
	-- 常见形态：节点名 / 纯数字 id / 表
	local candidates = {}
	if arg ~= nil then candidates[#candidates + 1] = arg end
	if nodeName and nodeName ~= arg then candidates[#candidates + 1] = nodeName end
	if type(arg) == "string" then
		local num = tonumber(arg:match("(%d+)"))
		if num then candidates[#candidates + 1] = num end
	end
	candidates[#candidates + 1] = nil -- 无参也试一次

	local dayBefore = (getgenv().__tick and getgenv().__tick.day) or S.day or 0
	for _, a in ipairs(candidates) do
		local ok = false
		if remote:IsA("RemoteEvent") then
			if a == nil then ok = pcall(function() remote:FireServer() end)
			else ok = pcall(function() remote:FireServer(a) end) end
		else
			if a == nil then ok = pcall(function() remote:InvokeServer() end)
			else ok = pcall(function() remote:InvokeServer(a) end) end
		end
		if ok then
			-- 等 Tick / 状态变化不够直接时，短等后认为可能成功，交由 UI 校验轮确认
			task.wait(0.6)
			S.remoteMode = true
			S.lastNode = tostring(nodeName or a or c.remoteName)
			S.lastCost = tonumber(cost) or S.lastCost
			S.lastEvent = "remote fired: " .. c.remoteName .. " arg=" .. tostring(a)
			-- 无面板时无法读 days left；用保守 busy：等一天或 retry 后再确认
			S.busy = true
			S.lab = "researching (remote)"
			local base = tonumber(S.day) or 0
			if base > 0 and (S.daysLeft or 0) > 0 then
				S.targetDay = base + S.daysLeft + 1
			elseif base > 0 then
				S.targetDay = base + 2 -- 未知天数时先挡一小段，下一轮 UI 校准
			end
			S.starts = S.starts + 1
			return true
		end
	end
	return false, "fire failed"
end

-- 游戏一开窗就会把 UIBlur 调到 12；离屏开窗期间压回 0
task.spawn(function()
	while true do
		if S.panelOpen then
			local b = Lighting:FindFirstChild("UIBlur")
			if b and b.Size ~= 0 then b.Size = 0 end
		end
		task.wait(0.08)
	end
end)

if not getgenv().__tickInstalled then
	getgenv().__tickInstalled = true
	getgenv().__tick = { money = 0, rp = 0, day = 0 }
	for _, d in ipairs(RS:GetDescendants()) do
		if d:IsA("RemoteEvent") and d.Name == "Tick" then
			d.OnClientEvent:Connect(function(t)
				if type(t) == "table" then
					local cur = getgenv().__tick
					cur.money = tonumber(t.money) or cur.money
					cur.rp = tonumber(t.rp) or cur.rp
					cur.day = tonumber(t.day) or cur.day
				end
			end)
		end
	end
end

local function syncTick()
	local t = getgenv().__tick
	if t then
		S.rp = tonumber(t.rp) or S.rp
		S.day = tonumber(t.day) or S.day
	end
end

local function fire(b)
	if b and firesignal then pcall(firesignal, b.Activated) end
end

local function mouseClick(b)
	if not b then return end
	pcall(firesignal, b.MouseButton1Down)
	task.wait(0.06)
	pcall(firesignal, b.MouseButton1Up)
end

local function pressAction(b)
	if not b then return false end
	if getconnections then
		local ok, conns = pcall(getconnections, b.Activated)
		if ok and type(conns) == "table" then
			local called = false
			for _, c in ipairs(conns) do
				if c.Enabled ~= false and c.Function then
					if pcall(c.Function) then called = true end
				end
			end
			if called then return true end
		end
	end
	fire(b)
	return true
end

local function acquireUI(timeout)
	local t0 = os.clock()
	while true do
		local held = getgenv().__uiLock
		if not held or (os.clock() - held) > 8 then
			getgenv().__uiLock = os.clock()
			return true
		end
		if os.clock() - t0 > timeout then return false end
		task.wait(0.1)
	end
end

local function releaseUI()
	getgenv().__uiLock = nil
end

local OFFSCREEN = UDim2.new(0, -4000, 0, -4000)
local DEFAULT_HOME = UDim2.new(0, 647, 0, 32)
local homePos = nil

function S.grid()
	local best, n = nil, 0
	for _, f in ipairs(pane:GetChildren()) do
		local c = #f:GetChildren()
		if c > n then best, n = f, c end
	end
	if best and n >= 50 then return best end
	return nil
end

local function openHidden()
	local p = CW.Position
	if p.X.Offset ~= -4000 and p.Y.Offset ~= -4000 then homePos = p end
	CW.Position = OFFSCREEN
	if not CW.Visible then CW.Visible = true end
	task.wait(0.18)
	S.panelOpen = true
	if not S.grid() then
		fire(CW.Tabs.WinTab_Research)
		task.wait(0.7)
		task.wait(0.3)
	end
	if not S.grid() then
		for _, d in ipairs(pane:GetDescendants()) do
			if d:IsA("GuiButton") and string.find(string.lower(d.Text or ""), "all research", 1, true) then
				fire(d); task.wait(0.6); break
			end
		end
	end
	for _, d in ipairs(pane:GetDescendants()) do
		if d:IsA("GuiButton") and d.Name == "ResearchStart" then
			for _, e in ipairs(pane:GetDescendants()) do
				if e:IsA("GuiButton") and string.find(string.lower(e.Text or ""), "all research", 1, true) then
					fire(e); task.wait(0.6); break
				end
			end
			break
		end
	end
	return S.grid() ~= nil
end

local function closePanel()
	S.panelOpen = false
	pcall(function() CW.Position = homePos or DEFAULT_HOME end)
	if CW.Visible then
		local cb = CW:FindFirstChild("CloseButton")
		if cb then fire(cb) end
		task.wait(0.22)
	end
end

local function readTop()
	local rp, days, lab, prevText = nil, nil, "", ""
	local progress = nil
	for _, d in ipairs(pane:GetDescendants()) do
		if d:IsA("TextLabel") then
			local tx = (d.Text or ""):gsub("%s+", " ")
			if prevText == "RESEARCH POINTS" then rp = tonumber(tx) or rp end
			if string.find(tx, "The lab is", 1, true) then lab = tx end
			local n = tx:match("^(%d+) days? left$")
			if n then days = tonumber(n) end
			-- 进度：100% / 100 % / Progress 100% 等
			local p = tx:match("(%d+)%s*%%")
			if p then
				local pv = tonumber(p)
				if pv and pv >= 0 and pv <= 100 then
					progress = math.max(progress or 0, pv)
				end
			end
			prevText = tx
		elseif d:IsA("GuiObject") then
			-- 部分进度条用 UI 属性或 NumberValue
			pcall(function()
				if d:IsA("NumberValue") and string.find(string.lower(d.Name), "progress", 1, true) then
					local v = tonumber(d.Value)
					if v then
						if v <= 1 then v = v * 100 end
						progress = math.max(progress or 0, math.clamp(v, 0, 100))
					end
				end
			end)
		end
	end
	-- 实验室空闲文案视为 100% 完成
	if lab and string.find(string.lower(lab), "idle", 1, true) then
		progress = 100
	end
	return rp, days, lab, progress
end

local function scanNodes()
	local g = S.grid()
	local ready, invented = {}, {}
	local researched, locked = 0, 0
	if not g then return ready, invented, 0, 0 end
	for _, d in ipairs(g:GetDescendants()) do
		if d:IsA("GuiButton") and d.Name:sub(1, 5) == "Node_" then
			local labels = {}
			for _, t in ipairs(d:GetDescendants()) do
				if t:IsA("TextLabel") and #(t.Text or "") > 0 then
					labels[#labels + 1] = (t.Text or ""):gsub("%s+", " ")
				end
			end
			local status = labels[#labels] or ""
			local title = labels[1] or d.Name
			local low = string.lower(status)
			if string.find(low, "researched", 1, true) then
				researched = researched + 1
			elseif string.find(low, "locked", 1, true) then
				locked = locked + 1
			else
				local cost = tonumber(status:match("^(%d+) RP$"))
				if cost then
					ready[#ready + 1] = { btn = d, name = d.Name, title = title, cost = cost }
				elseif string.find(low, "invented", 1, true) then
					invented[#invented + 1] = { btn = d, name = d.Name, title = title, cost = nil }
				end
			end
		end
	end
	table.sort(ready, function(a, b) return a.cost < b.cost end)
	return ready, invented, researched, locked
end

local function startBtn()
	for _, d in ipairs(pane:GetDescendants()) do
		if d:IsA("GuiButton") and d.Name == "ResearchStart" then return d end
	end
end

local function markStarted(node, c, days, tag)
	S.starts = S.starts + 1
	S.daysLeft = days
	local base = ((S.day or 0) > 0) and (S.day or 0) or 0
	S.targetDay = (base > 0) and (base + days + 1) or 0
	S.busy = true
	S.lab = ("researching (%dd)"):format(days)
	S.lastCard = node.title or node.name
	S.lastEvent = ("started %s (%d RP, %dd%s)"):format(S.lastCard, c, days, tag or "")
end

local function waitStarted(maxT)
	local t = 0
	while t < maxT do
		task.wait(0.35)
		t = t + 0.35
		local _, days, _, prog = readTop()
		if days and days > 0 then return days end
		if prog and prog > 0 and prog < 100 then return days or 1 end
	end
	return nil
end

local function tryNode(node, cost)
	fire(node.btn)
	task.wait(0.7)
	local b = startBtn()
	if not b then
		local g = S.grid()
		local again = nil
		if g then
			for _, d in ipairs(g:GetDescendants()) do
				if d:IsA("GuiButton") and d.Name == node.name then again = d break end
			end
		end
		if again then
			node.btn = again
			fire(again)
			task.wait(0.7)
			b = startBtn()
		end
	end
	if not b then
		S.lastStartText = "no ResearchStart"
		S.lastEvent = "detail page not opened"
		return false
	end
	local txt = (b.Text or ""):gsub("%s+", " ")
	S.lastStartText = txt
	if not string.find(string.lower(txt), "start research", 1, true) then
		S.lastEvent = "not startable: " .. txt
		return false
	end
	local c = tonumber(txt:match("%(%s*(%d+) RP")) or tonumber(txt:match("·%s*(%d+) RP")) or cost or 0
	if c > (S.rp or 0) then
		S.lastEvent = ("need %d RP, have %d"):format(c, S.rp or 0)
		return false
	end
	S.lastNode = node.name
	S.lastCost = c

	-- 点击前开始捕获 Remote
	beginCapture(3.5)
	for attempt = 1, 2 do
		pressAction(b)
		local days = waitStarted(1.4)
		if days then
			finishCaptureAndSave(node.name)
			markStarted(node, c, days, ", capture")
			return true
		end
		b = startBtn()
		if not b then break end
		mouseClick(b)
		days = waitStarted(1.4)
		if days then
			finishCaptureAndSave(node.name)
			markStarted(node, c, days, ", mouse+capture")
			return true
		end
		b = startBtn()
		if not b then break end
	end
	capture.active = false
	S.lastEvent = "click not registered: " .. txt
	return false
end

local function backToList()
	for _, d in ipairs(pane:GetDescendants()) do
		if d:IsA("GuiButton") and string.find(string.lower(d.Text or ""), "all research", 1, true) then
			fire(d); task.wait(0.5); return
		end
	end
end

-- 仅 UI：离屏一轮
local function stepUI()
	syncTick()
	-- RP 不足等待期：绝不打开研究页
	if (S.rpWaitUntil or 0) > os.clock() then
		local left = math.ceil(S.rpWaitUntil - os.clock())
		S.lastEvent = ("RP 不足，%ds 后再检查（需≈%d，现有%d）")
			:format(left, S.needRp or 0, S.rp or 0)
		return false
	end

	if not openHidden() then
		S.lastEvent = "panel not rebuilt"
		return false
	end
	local rp, days, lab, prog = readTop()
	if rp then S.rp = rp end
	if prog then S.progress = prog end

	-- 仍在研究中：记录进度后立刻关窗，等 100% 再来
	if (days and days > 0) or (prog and prog > 0 and prog < 100) then
		S.busy = true
		S.daysLeft = days or S.daysLeft or 0
		S.progress = prog or S.progress or 0
		S.lab = ("researching %d%%"):format(S.progress or 0)
		S.lastEvent = ("研究中 %d%%（剩余约 %s 天）"):format(
			S.progress or 0, tostring(days or "?"))
		closePanel()
		return true
	end

	-- 进度 100% 或 idle
	if prog and prog >= 100 then
		S.progress = 100
		S.busy = false
	end

	S.busy = false
	S.lab = (lab ~= "" and lab) or "idle"
	local ready, invented, researched, locked = scanNodes()
	S.lastEvent = ("idle · ready=%d invented=%d done=%d locked=%d rp=%d")
		:format(#ready, #invented, researched, locked, S.rp or 0)

	-- 最便宜一档都买不起：记下 needRp，长时间不再打开页面
	if #ready > 0 then
		local cheapest = ready[1]
		S.needRp = cheapest.cost
		if cheapest.cost > (S.rp or 0) then
			S.rpWaitUntil = os.clock() + (S.rpWait or 120)
			S.lastEvent = ("RP 不足：需 %d，现有 %d → %ds 内不打开研究页")
				:format(cheapest.cost, S.rp or 0, S.rpWait or 120)
			closePanel()
			return false
		end
	end

	for i = 1, math.min(#ready, 3) do
		local n = ready[i]
		if n.cost <= (S.rp or 0) then
			if tryNode(n, n.cost) then
				S.rpWaitUntil = 0
				closePanel()
				return true
			end
			backToList()
		end
	end

	for i = 1, math.min(#invented, 2) do
		if tryNode(invented[i], nil) then
			closePanel()
			return true
		end
		backToList()
	end

	closePanel()
	return false
end

-- 有缓存时：先 Remote；失败再 UI，并校准状态
local function stepLocked()
	syncTick()
	-- RP 等待期：连 Remote 也别狂发（避免乱点贵科技）
	if (S.rpWaitUntil or 0) > os.clock() and not S.busy then
		local left = math.ceil(S.rpWaitUntil - os.clock())
		S.lastEvent = ("RP 不足冷却中 %ds"):format(left)
		return false
	end
	local cache = loadCache()
	if cache and cache.remoteName and not S.busy then
		local okR = tryRemoteStart(S.lastNode ~= "" and S.lastNode or nil, S.lastCost)
		if okR then
			S.lastEvent = (S.lastEvent or "") .. " [no panel]"
			return true
		end
		S.lastEvent = "remote fail → UI"
	end
	return stepUI()
end

local function step()
	if not acquireUI(6) then
		-- Remote 路径不需要锁面板时仍可试
		local cache = loadCache()
		if cache and cache.remoteName and not S.busy then
			syncTick()
			local okR = tryRemoteStart(S.lastNode ~= "" and S.lastNode or nil, S.lastCost)
			if okR then return true end
		end
		S.lastEvent = "ui busy"
		return false
	end
	local ok, res = pcall(stepLocked)
	releaseUI()
	if not ok then
		S.fails = S.fails + 1
		S.lastEvent = "error: " .. tostring(res)
		return false
	end
	return res
end

local function peekProgressOnly()
	-- 轻量校准：仅当 busy 且需要确认 100% 时偶发离屏读进度
	if not acquireUI(3) then return nil end
	local prog
	local ok = pcall(function()
		if openHidden() then
			local rp, days, lab, p = readTop()
			if rp then S.rp = rp end
			prog = p
			if days then S.daysLeft = days end
			if lab and string.find(string.lower(lab), "idle", 1, true) then
				prog = 100
			end
			if (not days or days == 0) and (not p or p >= 100) then
				prog = prog or 100
			end
			closePanel()
		end
	end)
	releaseUI()
	if ok and prog then S.progress = prog end
	return prog
end

local function loop()
	local guard = 0
	while S.running and (getgenv().__tick.day or 0) == 0 and guard < 24 do
		task.wait(0.25); guard = guard + 1; syncTick()
	end
	loadCache()
	local lastPeek = 0
	while S.running do
		local ok = step()
		if ok then
			S.fails = 0
		else
			S.fails = S.fails + 1
		end
		if not S.running then break end
		syncTick()
		if S.busy then
			-- 等待进度到 100% 再进入下一轮（不再只靠天数）
			while S.running and S.busy do
				task.wait(S.busyPoll)
				syncTick()
				-- 每 ~25s 离屏读一次进度（避免天天开页）
				if os.clock() - lastPeek > 25 then
					lastPeek = os.clock()
					local prog = peekProgressOnly()
					if prog and prog >= 100 then
						S.busy = false
						S.progress = 100
						S.lastEvent = "研究进度 100%，准备下一轮"
						break
					elseif prog then
						S.progress = prog
						S.lastEvent = ("研究中 %d%%"):format(prog)
					end
				end
				-- 兼容：天数耗尽也视为完成
				if (S.day or 0) > 0 and (S.targetDay or 0) > 0 and S.day >= S.targetDay then
					S.busy = false
					S.progress = 100
					S.lastEvent = "研究天数结束，视为完成"
					break
				end
			end
		else
			-- 失败（点了没成功）拉长间隔；RP 不足已在 stepUI 里用 rpWaitUntil
			local waitSec = S.retryWait or 10
			if (S.fails or 0) > 0 and not ((S.rpWaitUntil or 0) > os.clock()) then
				waitSec = S.failRetryWait or 45
				S.lastEvent = (S.lastEvent or "fail") .. (" · %ds 后再试"):format(waitSec)
			end
			if (S.rpWaitUntil or 0) > os.clock() then
				waitSec = math.min(waitSec, math.max(5, S.rpWaitUntil - os.clock()))
			end
			task.wait(waitSec)
		end
	end
end

function S.start()
	if S.running then return "already running" end
	S.running = true
	S.fails = 0
	S.lastEvent = "starting"
	task.spawn(loop)
	return "started"
end

function S.stop()
	S.running = false
	S.lastEvent = "stopped"
	pcall(closePanel)
	releaseUI()
	return "stopped"
end

function S.state()
	syncTick()
	local c = loadCache()
	return {
		running = S.running, starts = S.starts, fails = S.fails,
		rp = math.floor(S.rp or 0), day = S.day,
		lab = S.lab, lastCard = S.lastCard, daysLeft = S.daysLeft,
		targetDay = S.targetDay, busy = S.busy, lastEvent = S.lastEvent,
		progress = S.progress or 0,
		needRp = S.needRp or 0,
		rpWaitLeft = math.max(0, math.ceil((S.rpWaitUntil or 0) - os.clock())),
		remote = c and c.remoteName or "",
	}
end

function S.clearRemoteCache()
	getgenv().__researchRemoteCache = nil
	pcall(function()
		if isfile and isfile(CACHE_FILE) and delfile then delfile(CACHE_FILE) end
	end)
	return "cleared"
end

return "autoResearch v11 loaded"

]===], "研究")

-- ========== 模块：自动重生/搬家 ==========
runModule([===[
--== Auto Extra v3: 传承(出售公司) / 办公室(搬迁) ==--
-- dry=false 时执行不可逆操作；dry=true 只判定并记录状态

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local gui = Players.LocalPlayer.PlayerGui:WaitForChild("PhoneTycoonGui")
local CW = gui.Root.Hud.GameWindow
local pane = CW.PanelContent

local prev = getgenv().__autoExtra
if prev and prev.running then pcall(prev.stop) end

local S = {
	running = false, dry = true,
	money = 0, rp = 0, day = 0,
	officeCost = nil, officeEligible = false, officeToGo = "",
	legacyRevenue = 0, legacyEligible = false, legacyHQ = false,
	checkEvery = 90, lastCheck = 0,
	lastEvent = "idle",
}
getgenv().__autoExtra = S

------------------------------------------------------------------------
-- 基础工具
------------------------------------------------------------------------

-- 导航按钮：firesignal 已证有效
local function pressNav(b)
	if b and firesignal then pcall(firesignal, b.Activated) end
end

-- 动作按钮：优先直接调用已注册的处理函数
-- （部分按钮的 Activated 对 firesignal 无响应，但 handler 可直调）
local function pressAction(b)
	if not b then return false end
	if getconnections then
		local ok, conns = pcall(getconnections, b.Activated)
		if ok and type(conns) == "table" then
			local called = false
			for _, c in ipairs(conns) do
				if c.Enabled ~= false and c.Function then
					local ok2 = pcall(c.Function)
					if ok2 then called = true end
				end
			end
			if called then return true end
		end
	end
	if firesignal then return pcall(firesignal, b.Activated) end
	return false
end

local function closeWindow()
	local cb = CW:FindFirstChild("CloseButton")
	if cb and CW.Visible then pressNav(cb) end
end

local function findTab(name)
	return CW.Tabs:FindFirstChild(name)
end

local function findBtn(root, prefix)
	for _, d in ipairs(root:GetDescendants()) do
		if d:IsA("GuiButton") and string.sub(d.Text or "", 1, #prefix) == prefix then
			return d
		end
	end
end

local function digits(s)
	return tonumber(string.match((string.gsub(s or "", "[%$,%s]", "")), "(%d+)"))
end

------------------------------------------------------------------------
-- Tick：货币 / 天数（共享单一订阅）
------------------------------------------------------------------------
if not getgenv().__tickInstalled then
	getgenv().__tickInstalled = true
	getgenv().__tick = { money = 0, rp = 0, day = 0 }
	for _, d in ipairs(RS:GetDescendants()) do
		if d:IsA("RemoteEvent") and d.Name == "Tick" then
			d.OnClientEvent:Connect(function(t)
				if type(t) == "table" then
					local cur = getgenv().__tick
					cur.money = tonumber(t.money) or cur.money
					cur.rp = tonumber(t.rp) or cur.rp
					cur.day = tonumber(t.day) or cur.day
				end
			end)
		end
	end
end

local function syncTick()
	local t = getgenv().__tick
	if t then
		S.money = t.money or S.money
		S.rp = t.rp or S.rp
		S.day = t.day or S.day
	end
end

------------------------------------------------------------------------
-- UI 互斥锁（与 auto-research 共用）
------------------------------------------------------------------------
local function acquireUI(timeout)
	local t0 = os.clock()
	while true do
		local held = getgenv().__uiLock
		if not held or (os.clock() - held) > 8 then
			getgenv().__uiLock = os.clock()
			return true
		end
		if os.clock() - t0 > timeout then return false end
		task.wait(0.1)
	end
end

local function releaseUI()
	getgenv().__uiLock = nil
end

------------------------------------------------------------------------
-- 办公室：条件全部满足才点 Move in
------------------------------------------------------------------------
local function checkOffice()
	pressNav(findTab("WinTab_Company"))
	task.wait(0.9)
	local nav = findBtn(pane, "Office")
	if nav then pressNav(nav) task.wait(0.9) end

	local mv
	for _, d in ipairs(pane:GetDescendants()) do
		if d:IsA("GuiButton") and d.Name == "MoveButton" then mv = d break end
	end
	if not mv then
		S.officeEligible = false
		S.officeToGo = "no button"
		return
	end

	S.officeCost = digits(mv.Text)
	local blocked, togo = false, ""
	local scope = mv.Parent or pane
	for _, d in ipairs(scope:GetDescendants()) do
		if d:IsA("TextLabel") then
			local t = d.Text or ""
			if string.sub(t, 1, 7) == "To go: " then
				blocked = true
				togo = t
			elseif string.sub(t, 1, 3) == "\u{2022}" then
				blocked = true
			end
		end
	end
	S.officeToGo = togo
	S.officeEligible = (not blocked) and S.officeCost ~= nil and S.money >= S.officeCost

	if S.officeEligible then
		if S.dry then
			S.lastEvent = string.format("office ready ($%d)", S.officeCost)
		else
			pressAction(mv)
			S.lastEvent = "clicked move-in"
			task.wait(1.5)
		end
	elseif togo ~= "" then
		S.lastEvent = "office blocked: " .. togo
	end
end

------------------------------------------------------------------------
-- 传承：总部已搬 + 总收入≥2.5亿 才出售
------------------------------------------------------------------------
local function checkLegacy()
	pressNav(findTab("WinTab_Company"))
	task.wait(0.9)
	local nav = findBtn(pane, "Legacy")
	if nav then pressNav(nav) task.wait(0.9) end

	S.legacyRevenue = 0
	S.legacyHQ = false
	for _, d in ipairs(pane:GetDescendants()) do
		if d:IsA("TextLabel") then
			local t = d.Text or ""
			local n = string.match(t, "^%$(%d[%d,]*) so far$")
			if n then S.legacyRevenue = tonumber((string.gsub(n, ",", ""))) end
			if string.find(t, "Move into Headquarters", 1, true) then
				S.legacyHQ = (string.sub(t, 1, 3) == "\u{2713}")
			end
		end
	end
	S.legacyEligible = S.legacyHQ and S.legacyRevenue >= 250000000

	if S.legacyEligible then
		if S.dry then
			S.lastEvent = "legacy ready"
		else
			local sell = findBtn(pane, "Sell company")
			if sell then
				pressAction(sell)
				task.wait(1.2)
				-- 可能弹出二次确认
				local confirm
				for _, d in ipairs(pane:GetDescendants()) do
					if d:IsA("GuiButton") then
						local t = string.lower(d.Text or "")
						if d.Visible and (string.sub(t, 1, 3) == "yes" or string.find(t, "confirm", 1, true)) then
							confirm = d
						end
					end
				end
				if confirm then
					pressAction(confirm)
					S.lastEvent = "sold company (confirmed)"
				else
					S.lastEvent = "sell clicked (no confirm dialog)"
				end
				task.wait(1.5)
			else
				S.lastEvent = "sell button not found"
			end
		end
	end
end

------------------------------------------------------------------------
-- 面板巡检
------------------------------------------------------------------------
local function checkPanelsLocked()
	syncTick()
	checkOffice()
	checkLegacy()
	closeWindow()
end

local function checkPanels()
	if not acquireUI(6) then
		S.lastEvent = "ui busy"
		return false
	end
	local ok, res = pcall(checkPanelsLocked)
	releaseUI()
	if not ok then
		S.lastEvent = "error: " .. tostring(res)
		return false
	end
	return true
end

------------------------------------------------------------------------
-- 生命周期
------------------------------------------------------------------------
function S.start()
	if S.running then return "already running" end
	S.running = true
	S.lastCheck = os.clock() - (S.checkEvery - 5)
	task.spawn(function()
		while S.running do
			if os.clock() - S.lastCheck > S.checkEvery and not CW.Visible then
				if checkPanels() then
					S.lastCheck = os.clock()
				else
					S.lastCheck = os.clock() - (S.checkEvery - 10)
				end
			end
			task.wait(1)
		end
	end)
	return "started"
end

function S.stop()
	S.running = false
	return "stopped"
end

function S.setDry(v)
	S.dry = v and true or false
	return "dry=" .. tostring(S.dry)
end

function S.state()
	syncTick()
	return {
		running = S.running, dry = S.dry,
		money = math.floor(S.money), day = S.day,
		officeCost = S.officeCost, officeEligible = S.officeEligible, officeToGo = S.officeToGo,
		legacyRevenue = S.legacyRevenue, legacyEligible = S.legacyEligible, legacyHQ = S.legacyHQ,
		lastEvent = S.lastEvent,
	}
end

return "autoExtra v3 loaded"

]===], "重生搬家")

-- ========== 模块：自动设计 ==========
runModule([===[
--== Auto Design v3 (步进条驱动 · 可配置策略) ==--
-- 用法：
--   getgenv().__autoDesign.runOnce()   立即设计一台，返回 ok, 日志
--   getgenv().__autoDesign.start()     循环：没有在研项目时自动设计
--   getgenv().__autoDesign.stop()
--   getgenv().__autoDesign.state()
-- 配置：
--   mode  = "best" | "worst" | "order"
--   order = "asc" | "desc"        （mode=="order" 时生效）
--   onNoTech = true/false         研究无可用卡片时也触发设计
--   interval = 秒
--   dry = true/false              走到最终页但不点 Begin development

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local okGui, pg = pcall(function()
	return player.PlayerGui:WaitForChild("PhoneTycoonGui", 12)
end)
if not okGui or not pg then
	return "DesignStudio 加载失败: 无 PhoneTycoonGui"
end

local root = pg:WaitForChild("Root", 10)
local hud = root and root:FindFirstChild("Hud")
local CW = hud and hud:FindFirstChild("GameWindow")
if not root or not CW then
	return "DesignStudio 加载失败: 界面未就绪"
end

local prev = getgenv().__autoDesign
if prev and prev.running then pcall(prev.stop) end

local STEPS = {
	"Step_device", "Step_chassis", "Step_size", "Step_screen", "Step_selfie",
	"Step_backcam", "Step_bevel", "Step_buttons", "Step_port", "Step_specs",
	"Step_features", "Step_finish", "Step_complete",
}

local S = {
	running = false,
	dry = false,
	mode = "best",     -- best / worst / order
	order = "asc",     -- asc / desc
	onNoTech = true,
	interval = 15,
	cooldown = 240,
	lastSubmit = 0,
	cycles = 0,
	noTechCount = 0,
	maxCycles = 9999,
	lastEvent = "idle",
	lastLog = "",
	name = "script by wu",
	state = nil,
}
getgenv().__autoDesign = S

------------------------------------------------------------------------
-- 基础
------------------------------------------------------------------------
local function clean(s)
	return (tostring(s or ""):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function press(b)
	if not b then return false end
	if getconnections then
		local ok, conns = pcall(getconnections, b.Activated)
		if ok and type(conns) == "table" then
			local called = false
			for _, c in ipairs(conns) do
				if c.Enabled ~= false and c.Function then
					if pcall(c.Function) then called = true end
				end
			end
			if called then return true end
		end
	end
	if firesignal then return pcall(firesignal, b.Activated) end
	return false
end

local function labelText(b)
	local t = b.Text or ""
	for _, l in ipairs(b:GetDescendants()) do
		if l:IsA("TextLabel") and (l.Text or "") ~= "" then
			t = t .. " " .. l.Text
		end
	end
	return clean(t)
end

local function studio()
	return root:FindFirstChild("DesignStudioShell")
end

------------------------------------------------------------------------
-- 打开 / 关闭
------------------------------------------------------------------------
local function openStudio()
	local ds = studio()
	if ds then return ds end
	local tabs = CW:FindFirstChild("Tabs")
	local tab = tabs and (tabs:FindFirstChild("WinTab_Design") or tabs:FindFirstChild("Tab_Design"))
	if not tab then return nil end
	press(tab)
	for _ = 1, 25 do
		task.wait(0.1)
		ds = studio()
		if ds then return ds end
	end
	return nil
end

local function closeStudio()
	local ds = studio()
	if not ds then return true end
	for _, d in ipairs(ds:GetDescendants()) do
		if d:IsA("GuiButton") and string.find(string.lower(d.Text or ""), "back to office", 1, true) then
			press(d)
			break
		end
	end
	for _ = 1, 10 do
		task.wait(0.1)
		if not studio() then return true end
	end
	local cb = CW:FindFirstChild("CloseButton")
	if cb then press(cb) end
	task.wait(0.3)
	return studio() == nil
end

------------------------------------------------------------------------
-- 步骤与选项
------------------------------------------------------------------------
local function gotoStep(name)
	local ds = studio()
	if not ds then return false end
	local st = ds:FindFirstChild("Stepper")
	local b = st and st:FindFirstChild(name)
	if not b then return false end
	press(b)
	task.wait(0.75)
	return true
end

local function currentStep()
	local ds = studio()
	if not ds then return nil end
	local insp = ds:FindFirstChild("Inspector")
	if not insp then return nil end
	for _, d in ipairs(insp:GetDescendants()) do
		if d:IsA("TextLabel") then
			local n = string.match(clean(d.Text), "^STEP (%d+) OF (%d+)$")
			if n then return tonumber(n) end
		end
	end
	return nil
end

local function bodyFrame()
	local ds = studio()
	if not ds then return nil end
	local insp = ds:FindFirstChild("Inspector")
	local body = insp and insp:FindFirstChild("Body")
	if not body then return nil end
	return body:FindFirstChild("ScrollingFrame") or body
end

-- 不可用项：未到年份 / 未发明 / 需研究 / 季节限定
local function available(txt)
	local l = string.lower(txt)
	if l:find("arrives", 1, true) then return false end
	if l:find("not invented", 1, true) then return false end
	if l:find("needs", 1, true) then return false end
	if l:find("research", 1, true) then return false end
	if l:find("halloween", 1, true) then return false end
	if l:find("tap to design", 1, true) then return false end
	if l:find("unavailable", 1, true) then return false end
	-- 动作按钮：只负责翻页/提交，不能当成选项点
	local a = l:gsub("^[%s←→]+", ""):gsub("[%s←→]+$", "")
	local actions = {
		["continue"] = true, ["next"] = true, ["back"] = true, ["finish"] = true,
		["begin development"] = true, ["back to office"] = true,
		["undo"] = true, ["redo"] = true, ["concept shelf"] = true,
		["spin"] = true, ["spin: on"] = true, ["auto"] = true,
		["show parts list"] = true, ["budget line"] = true, ["main line"] = true,
	}
	if actions[a] then return false end
	return true
end

-- 价格：支持 "−$5"（负价）与 "$9"
local function parsePrice(txt)
	local sign, num = txt:match("([%-−]?)%$(%d[%d,]*)")
	if not num then return nil end
	local v = tonumber((num:gsub(",", "")))
	if not v then return nil end
	if sign == "-" or sign == "−" then v = -v end
	return v
end

-- 按父节点分组：同组内通常是互斥选项，组与组之间是独立维度
local function cards()
	local sf = bodyFrame()
	if not sf then return {} end
	local out, groups, order = {}, {}, {}
	for _, d in ipairs(sf:GetDescendants()) do
		if d:IsA("GuiButton") then
			local txt = labelText(d)
			if txt ~= "" and available(txt) then
				local parent = d.Parent
				if not groups[parent] then
					groups[parent] = {}
					order[#order + 1] = parent
				end
				local item = { btn = d, text = txt, price = parsePrice(txt) }
				groups[parent][#groups[parent] + 1] = item
				out[#out + 1] = item
			end
		end
	end
	local grouped = {}
	for _, p in ipairs(order) do
		local g = groups[p]
		table.sort(g, function(a, b)
			return (a.price or 0) < (b.price or 0)
		end)
		grouped[#grouped + 1] = g
	end
	return grouped, out
end

local function chooseInGroup(g)
	if #g == 0 then return 0 end
	if S.mode == "best" then
		-- 全部点一遍，互斥组最后落在最贵的一项，可叠加组则全部开启
		for _, x in ipairs(g) do
			press(x.btn)
			task.wait(0.05)
		end
		return #g
	elseif S.mode == "worst" then
		press(g[1].btn)
		task.wait(0.05)
		return 1
	else
		local x = (S.order == "desc") and g[#g] or g[1]
		press(x.btn)
		task.wait(0.05)
		return 1
	end
end

local function selectStep()
	local grouped = cards()
	local n = 0
	for _, g in ipairs(grouped) do
		n = n + chooseInGroup(g)
	end
	task.wait(0.2)
	return n, #grouped
end

------------------------------------------------------------------------
-- 最终页
------------------------------------------------------------------------
local function findStartButton()
	local ds = studio()
	if not ds then return nil end
	for _, d in ipairs(ds:GetDescendants()) do
		if d:IsA("GuiButton") and string.find(string.lower(labelText(d)), "begin development", 1, true) then
			return d
		end
	end
end

local function pressSuggested()
	local ds = studio()
	if not ds then return false end
	local sug
	for _, d in ipairs(ds:GetDescendants()) do
		if d:IsA("GuiButton") and string.find(string.lower(labelText(d)), "suggested", 1, true) then
			sug = d
			break
		end
	end
	if sug then
		press(sug)
		task.wait(0.25)
		return true
	end
	return false
end

-- 命名弹窗：优先找名字里带 name 的输入框，且绝不碰 RetailPrice
local function isPriceBox(x)
	return x:IsA("TextBox") and string.find(string.lower(x.Name), "price", 1, true) ~= nil
end

local function findNamedBox(r)
	for _, d in ipairs(r:GetDescendants()) do
		if d:IsA("TextBox") and d.Visible and string.find(string.lower(d.Name), "name", 1, true) then
			return d
		end
	end
	return nil
end

local function pressGoIn(container)
	if not container then return false end
	for _, x in ipairs(container:GetDescendants()) do
		if x:IsA("GuiButton") and x.Visible then
			local t = string.lower(clean(labelText(x)))
			if t == "go" or t == "confirm" or t == "create" or t == "ok"
				or t:find("^go") or t:find("^confirm") or t:find("^create") then
				press(x)
				return true
			end
		end
	end
	local cand
	for _, x in ipairs(container:GetDescendants()) do
		if x:IsA("GuiButton") and x.Visible and not isPriceBox(x) then
			cand = x
			break
		end
	end
	if cand then
		press(cand)
		return true
	end
	return false
end

local function confirmPopup(name)
	local box = findNamedBox(studio() or root) or findNamedBox(root)
	if box then
		box.Text = string.sub(name, 1, 24)
		task.wait(0.15)
		local holder = box.Parent
		for _ = 1, 4 do
			if not holder or holder == root then break end
			if pressGoIn(holder) then return true end
			holder = holder.Parent
		end
		return pressGoIn(box.Parent)
	end

	-- 没找到命名框：找含非价格输入框的可见弹窗
	local target
	for _, d in ipairs(root:GetDescendants()) do
		if d:IsA("Frame") and d.Visible and d ~= studio() then
			for _, x in ipairs(d:GetDescendants()) do
				if x:IsA("TextBox") and x.Visible and not isPriceBox(x) then
					target = d
					break
				end
			end
			if target then break end
		end
	end
	if target then
		for _, x in ipairs(target:GetDescendants()) do
			if x:IsA("TextBox") and x.Visible and not isPriceBox(x) then
				x.Text = string.sub(name, 1, 24)
			end
		end
		task.wait(0.15)
		return pressGoIn(target)
	end
	return false
end

------------------------------------------------------------------------
-- 走一次完整流程
------------------------------------------------------------------------
function S.runOnce()
	if S.running then return false, "already running" end
	local log = {}

	if not openStudio() then return false, "打不开设计面板" end
	task.wait(0.4)

	-- 步骤 1~12：只点选项，不碰 Continue
	for i = 1, #STEPS - 1 do
		if not studio() then
			log[#log + 1] = "面板中途关闭"
			break
		end
		if not gotoStep(STEPS[i]) then
			log[#log + 1] = "跳转失败 " .. STEPS[i]
			break
		end
		local n, g = selectStep()
		log[#log + 1] = string.format("S%d:%d/%d", i, n, g)
	end

	-- 第 12 步结束：按 Continue 进入 Final review
	local ds2 = studio()
	if ds2 then
		for _, d in ipairs(ds2:GetDescendants()) do
			if d:IsA("GuiButton") and clean(labelText(d)) == "Continue" then
				press(d)
				log[#log + 1] = "Continue -> 第13步"
				break
			end
		end
		task.wait(0.9)
	end

	-- Continue 后若面板被收起，重新打开；再确保落在 Final review
	if not studio() then
		openStudio()
		task.wait(0.5)
	end
	if not studio() then
		S.lastLog = table.concat(log, " | ")
		return false, S.lastLog
	end

	if not findStartButton() then
		gotoStep("Step_complete")
		task.wait(0.6)
		log[#log + 1] = "已跳到 Final review"
	end

	pressSuggested()
	local startBtn = findStartButton()
	if not startBtn then
		log[#log + 1] = "找不到 Begin development"
		S.lastLog = table.concat(log, " | ")
		closeStudio()
		return false, S.lastLog
	end

	if S.dry then
		log[#log + 1] = "dry: 停在最终页"
		S.lastLog = table.concat(log, " | ")
		closeStudio()
		return true, S.lastLog
	end

	press(startBtn)
	task.wait(1.0)

	S.cycles = S.cycles + 1
	S.lastSubmit = os.clock()
	local named = confirmPopup(S.name)
	log[#log + 1] = named and "已确认命名" or "无命名弹窗"

	task.wait(1.0)
	local still = studio()
	if still then
		log[#log + 1] = "提交后面板仍开着"
	else
		log[#log + 1] = "已提交研发"
	end
	S.lastLog = table.concat(log, " | ")
	S.lastEvent = still and "submit blocked" or ("designed " .. S.name)
	closeStudio()
	return (not still), S.lastLog
end

------------------------------------------------------------------------
-- 循环
------------------------------------------------------------------------
local thread

function S.start()
	if S.running then return "already running" end
	S.running = true
	S.lastEvent = "running"
	thread = task.spawn(function()
		while S.running and S.cycles < S.maxCycles do
			-- 提交后等冷却，避免同一台还没造完就再开一台
			local elapsed = S.lastSubmit and (os.clock() - S.lastSubmit) or math.huge
			local need = elapsed >= (S.cooldown or 240)

			if S.onNoTech and not need then
				local R = getgenv().__autoResearch
				if R and type(R.lastEvent) == "string" and R.lastEvent:find("no ready card", 1, true) then
					S.noTechCount = S.noTechCount + 1
				else
					S.noTechCount = 0
				end
				if S.noTechCount >= 3 then
					need = true
					S.noTechCount = 0
				end
			end

			if need then
				local ok, msg = S.runOnce()
				if not ok then S.lastEvent = "error: " .. tostring(msg) end
			else
				S.lastEvent = "waiting dev"
			end

			local t0 = os.clock()
			while S.running and (os.clock() - t0) < S.interval do
				task.wait(0.5)
			end
		end
		S.running = false
		S.lastEvent = "stopped"
	end)
	return "started"
end

function S.stop()
	S.running = false
	if thread then pcall(task.cancel, thread) end
	thread = nil
	closeStudio()
	S.lastEvent = "stopped"
	return "stopped"
end

function S.state()
	local left = 0
	if S.lastSubmit and S.lastSubmit > 0 then
		left = math.max(0, math.floor((S.cooldown or 240) - (os.clock() - S.lastSubmit)))
	end
	return {
		running = S.running,
		cycles = S.cycles,
		mode = S.mode,
		order = S.order,
		onNoTech = S.onNoTech,
		interval = S.interval,
		dev = string.format("cooldown %ds", left),
		lastEvent = S.lastEvent,
		lastLog = S.lastLog,
	}
end

return "AutoDesign v3 loaded"

]===], "自动设计")

-- ===================== Obsidian UI（与 ka 同款） =====================
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local localPlayer = Players.LocalPlayer

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local okLib, Library = pcall(function()
    return loadstring(game:HttpGet(repo .. "Library.lua"))()
end)
if not okLib or not Library then
    warn("[造一部手机] Obsidian 加载失败:", Library)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "造一部手机",
            Text = "Obsidian UI 加载失败",
            Duration = 5,
        })
    end)
    return
end

local Toggles = Library.Toggles
local Options = Library.Options

local BG_URL = "https://raw.githubusercontent.com/Minions488/--script/refs/heads/main/%E6%9D%80%E7%8C%AA%E5%8C%A0.jpg"

local Window = Library:CreateWindow({
    Title = "巫 · 造一部手机",
    Footer = "巫 · 造一部手机 · Obsidian",
    Center = true,
    AutoShow = true,
    Resizable = true,
    NotifySide = "Right",
    ShowCustomCursor = false,
    BackgroundImage = BG_URL,
})

pcall(function()
    if Window.SetBackgroundImage then
        Window:SetBackgroundImage(BG_URL)
    elseif Library.SetBackgroundImage then
        Library:SetBackgroundImage(BG_URL)
    end
end)

local Tabs = {
    Main = Window:AddTab("主页", "box"),
    Extra = Window:AddTab("其他", "settings"),
}

local MainLeft = Tabs.Main:AddLeftGroupbox("自动研究")
local MainRight = Tabs.Main:AddRightGroupbox("重生 / 搬家")
local ExtraLeft = Tabs.Extra:AddLeftGroupbox("状态")

local function getResearch()
    return getgenv().__autoResearch
end
local function getExtra()
    return getgenv().__autoExtra
end
local function getDesign()
    return getgenv().__autoDesign
end

MainLeft:AddToggle("AutoResearch", {
    Text = "自动研究",
    Default = false,
    Callback = function(v)
        local S = getResearch()
        if not S then
            pcall(function() Library:Notify("研究模块未就绪", 2) end)
            return
        end
        if v then
            if type(S.start) == "function" then
                pcall(S.start)
            else
                S.running = true
            end
        else
            if type(S.stop) == "function" then
                pcall(S.stop)
            else
                S.running = false
            end
        end
        print("[造一部手机] 自动研究:", v)
    end,
})

MainLeft:AddLabel("优先 Remote 直发（首次会离屏学一次）；依赖 Tick", true)

MainRight:AddToggle("AutoRelocate", {
    Text = "自动重生/搬家",
    Default = false,
    Callback = function(v)
        local S = getExtra()
        if not S then
            pcall(function() Library:Notify("重生模块未就绪", 2) end)
            return
        end
        if v then
            if type(S.start) == "function" then
                pcall(S.start)
            else
                S.running = true
            end
        else
            if type(S.stop) == "function" then
                pcall(S.stop)
            else
                S.running = false
            end
        end
        print("[造一部手机] 重生/搬家:", v)
    end,
})

MainRight:AddToggle("DryRun", {
    Text = "试跑模式（不真正操作）",
    Default = true,
    Tooltip = "开启时只检测状态，不执行不可逆操作",
    Callback = function(v)
        local S = getExtra()
        if S then
            S.dry = v and true or false
        end
        print("[造一部手机] dry=", v)
    end,
})

MainRight:AddLabel("dry=开：只记录；dry=关：会真正传承/搬迁", true)

-- ===================== 设计页 =====================
local DesignTab = Window:AddTab("设计", "cpu")
local DesignLeft = DesignTab:AddLeftGroupbox("自动设计（造手机）")
local DesignRight = DesignTab:AddRightGroupbox("状态 / 操作")

DesignLeft:AddToggle("AutoDesign", {
    Text = "自动设计",
    Default = false,
    Tooltip = "没有在研项目时自动走完设计流程并开始研发",
    Callback = function(v)
        local D = getDesign()
        if not D then
            pcall(function() Library:Notify("设计模块未就绪", 2) end)
            return
        end
        if v then
            if type(D.start) == "function" then pcall(D.start) else D.running = true end
        else
            if type(D.stop) == "function" then pcall(D.stop) else D.running = false end
        end
        print("[造一部手机] 自动设计:", v)
    end,
})

DesignLeft:AddDropdown("DesignMode", {
    Text = "设计策略",
    Values = { "最挣钱（全部可用项）", "最差（只选最便宜）", "按顺序" },
    Default = "最挣钱（全部可用项）",
    Callback = function(v)
        local D = getDesign()
        if not D then return end
        if string.find(v, "最挣钱", 1, true) then
            D.mode = "best"
        elseif string.find(v, "最差", 1, true) then
            D.mode = "worst"
        else
            D.mode = "order"
        end
    end,
})

DesignLeft:AddDropdown("DesignOrder", {
    Text = "顺序方向（按顺序时生效）",
    Values = { "正序", "倒序" },
    Default = "正序",
    Callback = function(v)
        local D = getDesign()
        if D then D.order = (v == "倒序") and "desc" or "asc" end
    end,
})

DesignLeft:AddToggle("DesignOnNoTech", {
    Text = "没有可研究科技时自动设计",
    Default = true,
    Callback = function(v)
        local D = getDesign()
        if D then D.onNoTech = v end
    end,
})

DesignLeft:AddSlider("DesignInterval", {
    Text = "循环间隔（秒）",
    Default = 15,
    Min = 5,
    Max = 120,
    Rounding = 0,
    Callback = function(v)
        local D = getDesign()
        if D then D.interval = v end
    end,
})

DesignLeft:AddToggle("DesignDry", {
    Text = "试跑（走到最终页但不开始研发）",
    Default = false,
    Callback = function(v)
        local D = getDesign()
        if D then D.dry = v end
    end,
})

DesignRight:AddButton({
    Text = "立即设计一台",
    Func = function()
        local D = getDesign()
        if not D then return end
        local ok, msg = D.runOnce()
        pcall(function()
            Library:Notify(ok and ("设计完成：" .. tostring(msg)) or ("设计失败：" .. tostring(msg)), 5)
        end)
    end,
})

local designStatus = DesignRight:AddLabel("设计: 等待中…", true)

task.spawn(function()
    while task.wait(1) do
        local D = getDesign()
        if D then
            pcall(function()
                local st = D.state()
                local run = st.running and "运行中" or "关闭"
                local mode = (st.mode == "best" and "最挣钱") or (st.mode == "worst" and "最差") or ("顺序/" .. tostring(st.order))
                local line = string.format("[%s] %s · 已设计%d台 · dev=%s · %s", run, mode, tonumber(st.cycles) or 0, tostring(st.dev), tostring(st.lastEvent))
                if designStatus and designStatus.SetText then
                    designStatus:SetText(line)
                end
            end)
        end
    end
end)


ExtraLeft:AddLabel("研究状态", true)
local researchStatus = ExtraLeft:AddLabel("研究: 等待中…", true)
ExtraLeft:AddLabel("重生状态", true)
local extraStatus = ExtraLeft:AddLabel("重生: 等待中…", true)

task.spawn(function()
    while task.wait(0.5) do
        local R = getResearch()
        local E = getExtra()
        pcall(function()
            if R then
                local lab = tostring(R.lab or "?")
                local day = tostring(R.day or "?")
                local rp = tostring(R.rp or "?")
                local run = R.running and "运行中" or "关闭"
                local st = R.state and R.state() or {}
                local prog = st.progress or R.progress or 0
                local ev = tostring(st.lastEvent or R.lastEvent or "")
                local line = string.format("[%s] %s%% rp=%s · %s", run, tostring(prog), rp, ev:sub(1, 40))
                if researchStatus and researchStatus.SetText then
                    researchStatus:SetText(line)
                end
            end
            if E then
                local run = E.running and "运行中" or "关闭"
                local dry = E.dry and "试跑" or "实操"
                local ev = tostring(E.lastEvent or "idle")
                if extraStatus and extraStatus.SetText then
                    extraStatus:SetText(string.format("[%s/%s] %s", run, dry, ev))
                end
            end
        end)
    end
end)

ExtraLeft:AddButton({
    Text = "关闭全部功能",
    Func = function()
        local R, E, D = getResearch(), getExtra(), getDesign()
        if R then
            if type(R.stop) == "function" then pcall(R.stop) else R.running = false end
        end
        if E then
            if type(E.stop) == "function" then pcall(E.stop) else E.running = false end
        end
        if D then
            if type(D.stop) == "function" then pcall(D.stop) else D.running = false end
        end
        pcall(function()
            if Toggles.AutoResearch then Toggles.AutoResearch:SetValue(false) end
            if Toggles.AutoRelocate then Toggles.AutoRelocate:SetValue(false) end
            if Toggles.AutoDesign then Toggles.AutoDesign:SetValue(false) end
        end)
        pcall(function() Library:Notify("已关闭全部", 2) end)
    end,
})

ExtraLeft:AddLabel("Obsidian UI · 无音效", true)

-- 标记已加载（兼容巫源码调用）
getgenv().WuPhoneTycoonLoaded = true
getgenv().WuPhoneTycoonUI = Library.ScreenGui or Library.GUI
getgenv().WuPhoneBuildUI = getgenv().WuPhoneTycoonUI

print("[造一部手机] Obsidian UI 加载完成")
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "造一部手机",
        Text = "Obsidian UI 已加载",
        Duration = 3,
    })
end)
