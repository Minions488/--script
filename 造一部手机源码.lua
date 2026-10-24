--[[
  巫 · 造一部手机源码（独立合并版）
  - 内嵌：自动研究 + 自动重生/搬家
  - UI：ka 同款简洁深色面板（无背景图、无音效）
  - 目标服 PlaceId: 101914705206759（Build a Phone Empire）
]]
print("[造一部手机] 加载中...")

if getgenv().WuPhoneTycoonLoaded then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "造一部手机",
            Text = "已经加载 请勿重复点击",
            Duration = 3,
        })
    end)
    return
end

-- 允许名单（PlaceId）+ 界面兜底
local PHONE_PLACE = {
    [101914705206759] = true,
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
            Text = "该服务器不支持（请进入造手机游戏）",
            Duration = 5,
        })
    end)
    warn("[造一部手机] 非目标服 PlaceId=", game.PlaceId)
    return
end

local okGui, guiOrErr = pcall(function()
    return game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("PhoneTycoonGui", 10)
end)
if not okGui or not guiOrErr then
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

-- ========== 模块 1：自动研究 ==========
runModule([===[
--== Auto Research v6 (event/clock driven, no metamethod hooks) ==--
-- 依赖：Tick 远程事件（只订阅，不改写调用）
-- 行为：只在“实验室空闲”时打开一次研究面板，启动后立刻关闭；其余时间靠 day 计数等待

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local gui = Players.LocalPlayer.PlayerGui:WaitForChild("PhoneTycoonGui")
local CW = gui.Root.Hud.GameWindow
local tab = CW.Tabs.WinTab_Research

local prev = getgenv().__autoResearch
if prev and prev.running then pcall(function() prev.stop() end) end

local S = {
	running = false, starts = 0, failTicks = 0,
	lastCard = "", lastEvent = "", lab = "idle",
	rp = 0, day = 0, targetDay = 0, daysLeft = 0,
	startedAt = 0, maxStarts = 500,
}
getgenv().__autoResearch = S

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
		S.rp = t.rp or S.rp
		S.day = t.day or S.day
	end
end

local function fire(b)
	if b and firesignal then pcall(firesignal, b.Activated) end
end

local function closeWindow()
	local cb = CW:FindFirstChild("CloseButton")
	if cb and CW.Visible then fire(cb) end
end

local function startBtnIn(pane)
	for _, d in ipairs(pane:GetDescendants()) do
		if d:IsA("GuiButton") and string.find(string.lower(d.Text or ""), "start research", 1, true) then
			return d
		end
	end
end

-- 打开面板并一次性读取：是否空闲 / 剩余天数 / 可研究卡片及花费
local function readPane()
	fire(tab)
	task.wait(0.9)
	local pane = CW.PanelContent
	local info = { idle = false, days = nil, card = nil, cost = nil, name = nil }
	for _, d in ipairs(pane:GetDescendants()) do
		if d:IsA("TextLabel") then
			local t = d.Text
			if string.find(t, "lab is idle", 1, true) then info.idle = true end
			local n = string.match(t, "^(%d+) days? left$")
			if n then info.days = tonumber(n) end
		end
	end
	for _, d in ipairs(pane:GetDescendants()) do
		if d:IsA("GuiButton") and not info.card then
			local costLabel, nameLabel
			for _, x in ipairs(d:GetDescendants()) do
				if x:IsA("TextLabel") then
					if string.match(x.Text, "^(%d+) RP$") then
						costLabel = x
					elseif x.Text ~= "" and not string.find(x.Text, "READY TO RESEARCH", 1, true) then
						nameLabel = nameLabel or x
					end
				end
			end
			if costLabel then
				info.card = d
				info.cost = tonumber(string.match(costLabel.Text, "^(%d+)"))
				info.name = nameLabel and nameLabel.Text or d.Name
			end
		end
	end
	return info
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

local function tryStartLocked()
	syncTick()
	local info = readPane()
	S.lab = info.days and ("researching (" .. info.days .. "d)") or (info.idle and "idle" or "unknown")

	if not info.idle and not info.days then
		closeWindow()
		S.lastEvent = "pane state unknown"
		return false
	end

	-- 已有一项在跑（例如上一轮判断失败），直接记录目标
	if info.days then
		S.daysLeft = info.days
		S.targetDay = S.day + info.days + 1
		S.startedAt = os.clock()
		closeWindow()
		S.lastEvent = "already researching"
		return true
	end

	if not info.card then
		closeWindow()
		S.lastEvent = "no ready card"
		return false
	end

	if info.cost and S.rp > 0 and info.cost > S.rp then
		closeWindow()
		S.lastEvent = string.format("too expensive %d > %d", info.cost, math.floor(S.rp))
		return false
	end

	-- 点卡片 -> 详情页
	fire(info.card)
	task.wait(0.8)
	local sb = startBtnIn(CW.PanelContent)
	if not sb then
		closeWindow()
		S.lastEvent = "no start button after card"
		return false
	end

	fire(sb)
	task.wait(0.9)

	-- 验证：重开面板读剩余天数
	local ver = readPane()
	if ver.days then
		S.starts = S.starts + 1
		S.lastCard = info.name or "?"
		S.daysLeft = ver.days
		S.targetDay = S.day + ver.days + 1
		S.startedAt = os.clock()
		S.failTicks = 0
		S.lastEvent = string.format("started %s (%dd)", S.lastCard, ver.days)
		closeWindow()
		return true
	end
	closeWindow()
	S.lastEvent = "start had no effect"
	return false
end

local function tryStart()
	if not acquireUI(6) then
		S.lastEvent = "ui busy"
		return false
	end
	local ok, res = pcall(tryStartLocked)
	releaseUI()
	if not ok then
		S.lastEvent = "error: " .. tostring(res)
		return false
	end
	return res
end

local function loop()
	while S.running do
		syncTick()
		local done = S.targetDay > 0 and S.day >= S.targetDay
		local timedOut = S.targetDay > 0 and (os.clock() - S.startedAt) > 180
		if S.targetDay == 0 or done or timedOut then
			if S.targetDay > 0 then
				S.targetDay = 0
				S.lastEvent = "lab free, picking next"
			end
			if not tryStart() then
				S.failTicks = S.failTicks + 1
				if S.failTicks >= 20 or S.starts >= S.maxStarts then
					S.running = false
					S.lastEvent = "stopped: " .. S.lastEvent
				else
					task.wait(2)
				end
			end
		else
			task.wait(0.5)
		end
	end
end

function S.start()
	if S.running then return "already running" end
	S.running = true
	S.failTicks = 0
	S.targetDay = 0
	task.spawn(loop)
	return "started"
end

function S.stop()
	S.running = false
	return "stopped"
end

function S.state()
	syncTick()
	return {
		running = S.running, starts = S.starts,
		rp = math.floor(S.rp), day = S.day,
		lab = S.lab, lastCard = S.lastCard, daysLeft = S.daysLeft,
		targetDay = S.targetDay, lastEvent = S.lastEvent,
	}
end

return "autoResearch v6 loaded"

]===], "研究")

-- ========== 模块 2：自动重生/搬家 ==========
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

getgenv().WuPhoneTycoonLoaded = true

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local host = (gethui and gethui()) or game:GetService("CoreGui")
pcall(function()
    local old = host:FindFirstChild("WuPhoneBuildUI")
    if old then old:Destroy() end
end)

local sg = Instance.new("ScreenGui")
sg.Name = "WuPhoneBuildUI"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.DisplayOrder = 120
sg.Parent = host

local panel = Instance.new("Frame")
panel.Name = "Main"
panel.AnchorPoint = Vector2.new(0, 0.5)
panel.Position = UDim2.new(0, 16, 0.5, 0)
panel.Size = UDim2.fromOffset(280, 330)
panel.BackgroundColor3 = Color3.fromRGB(18, 20, 26)
panel.BackgroundTransparency = 0.15
panel.BorderSizePixel = 0
panel.ClipsDescendants = true
panel.Parent = sg
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)

-- 背景图
local bg = Instance.new("ImageLabel")
bg.Name = "Background"
bg.BackgroundTransparency = 1
bg.Size = UDim2.fromScale(1, 1)
bg.Position = UDim2.fromScale(0, 0)
bg.Image = "https://raw.githubusercontent.com/Minions488/--script/refs/heads/main/%E6%9D%80%E7%8C%AA%E5%8C%A0.jpg"
bg.ScaleType = Enum.ScaleType.Crop
bg.ZIndex = 0
bg.Parent = panel
local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 12)
bgCorner.Parent = bg
-- 半透明遮罩，保证文字可读
local dim = Instance.new("Frame")
dim.Name = "Dim"
dim.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
dim.BackgroundTransparency = 0.35
dim.BorderSizePixel = 0
dim.Size = UDim2.fromScale(1, 1)
dim.ZIndex = 1
dim.Parent = panel
Instance.new("UICorner", dim).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80, 140, 220)
stroke.Thickness = 1.2
stroke.Transparency = 0.35
stroke.Parent = panel

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(28, 32, 42)
header.BackgroundTransparency = 0.25
header.BorderSizePixel = 0
header.ZIndex = 2
header.Parent = panel
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(12, 0)
title.Size = UDim2.new(1, -52, 1, 0)
title.Font = Enum.Font.GothamBold
title.Text = "巫 · 造一部手机"
title.TextSize = 15
title.TextColor3 = Color3.fromRGB(235, 240, 250)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local btnClose = Instance.new("TextButton")
btnClose.AnchorPoint = Vector2.new(1, 0.5)
btnClose.Position = UDim2.new(1, -8, 0.5, 0)
btnClose.Size = UDim2.fromOffset(28, 28)
btnClose.BackgroundColor3 = Color3.fromRGB(50, 40, 45)
btnClose.Text = "×"
btnClose.TextColor3 = Color3.fromRGB(255, 200, 200)
btnClose.Font = Enum.Font.GothamBold
btnClose.TextSize = 16
btnClose.Parent = header
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(0, 8)

local body = Instance.new("ScrollingFrame")
body.Position = UDim2.fromOffset(0, 44)
body.Size = UDim2.new(1, 0, 1, -48)
body.BackgroundTransparency = 1
body.BorderSizePixel = 0
body.ScrollBarThickness = 4
body.CanvasSize = UDim2.new(0, 0, 0, 0)
body.AutomaticCanvasSize = Enum.AutomaticSize.Y
body.ZIndex = 2
body.Parent = panel

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 8)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = body
local pad = Instance.new("UIPadding")
pad.PaddingLeft = UDim.new(0, 12)
pad.PaddingRight = UDim.new(0, 12)
pad.PaddingTop = UDim.new(0, 8)
pad.PaddingBottom = UDim.new(0, 12)
pad.Parent = body

local function sectionLabel(text, order)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Size = UDim2.new(1, 0, 0, 20)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextColor3 = Color3.fromRGB(140, 180, 255)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Text = text
    l.LayoutOrder = order
    l.Parent = body
end

local function makeToggle(name, order, getOn, onToggle)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 40)
    row.BackgroundColor3 = Color3.fromRGB(28, 32, 40)
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.Parent = body
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)
    local lbl = Instance.new("TextLabel")
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.fromOffset(10, 0)
    lbl.Size = UDim2.new(1, -70, 1, 0)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(230, 235, 245)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Text = name
    lbl.Parent = row
    local btn = Instance.new("TextButton")
    btn.AnchorPoint = Vector2.new(1, 0.5)
    btn.Position = UDim2.new(1, -8, 0.5, 0)
    btn.Size = UDim2.fromOffset(52, 26)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BorderSizePixel = 0
    btn.Parent = row
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local function paint()
        local on = getOn()
        btn.Text = on and "ON" or "OFF"
        btn.BackgroundColor3 = on and Color3.fromRGB(40, 160, 90) or Color3.fromRGB(70, 75, 90)
    end
    paint()
    btn.MouseButton1Click:Connect(function()
        onToggle(not getOn())
        task.wait(0.05)
        paint()
    end)
    return paint
end

local status = Instance.new("TextLabel")
status.BackgroundTransparency = 1
status.Size = UDim2.new(1, 0, 0, 80)
status.Font = Enum.Font.Gotham
status.TextSize = 12
status.TextColor3 = Color3.fromRGB(160, 170, 185)
status.TextXAlignment = Enum.TextXAlignment.Left
status.TextYAlignment = Enum.TextYAlignment.Top
status.TextWrapped = true
status.Text = "状态：待命"
status.LayoutOrder = 90
status.Parent = body

sectionLabel("1. 自动研究", 1)
local paintResearch = makeToggle("自动研究", 2, function()
    local s = getgenv().__autoResearch
    return s and s.running
end, function(want)
    local s = getgenv().__autoResearch
    if not s then return end
    if want then if s.start then s.start() end else if s.stop then s.stop() end end
end)

sectionLabel("2. 重生 / 搬家", 3)
local paintExtra = makeToggle("自动重生搬家（正式）", 4, function()
    local s = getgenv().__autoExtra
    return s and s.running and not s.dry
end, function(want)
    local s = getgenv().__autoExtra
    if not s then return end
    if want then
        if s.setDry then s.setDry(false) end
        if s.start then s.start() end
    else
        if s.stop then s.stop() end
    end
end)

makeToggle("仅检测模式 dry", 5, function()
    local s = getgenv().__autoExtra
    return not s or s.dry
end, function(want)
    local s = getgenv().__autoExtra
    if s and s.setDry then s.setDry(want and true or false) end
end)

sectionLabel("总控", 6)
makeToggle("一键全开/全停", 7, function()
    local a = getgenv().__autoResearch
    local b = getgenv().__autoExtra
    return (a and a.running) or (b and b.running)
end, function(want)
    local a = getgenv().__autoResearch
    local b = getgenv().__autoExtra
    if want then
        if b and b.setDry then b.setDry(false) end
        if b and b.start then b.start() end
        if a and a.start then a.start() end
    else
        if a and a.stop then a.stop() end
        if b and b.stop then b.stop() end
    end
end)

task.spawn(function()
    while sg.Parent do
        pcall(function()
            local a = getgenv().__autoResearch or {}
            local b = getgenv().__autoExtra or {}
            local t = getgenv().__tick or {}
            status.Text = string.format(
                "研究: %s | lab=%s\n日=%s RP=%s 次数=%s\n搬家: %s dry=%s\n%s",
                a.running and "运行中" or "关闭",
                tostring(a.lab or "-"),
                tostring(t.day or a.day or "-"),
                tostring(t.rp or a.rp or "-"),
                tostring(a.starts or 0),
                b.running and "运行中" or "关闭",
                tostring(b.dry),
                tostring(a.lastEvent or b.lastEvent or "")
            )
            pcall(paintResearch)
            pcall(paintExtra)
        end)
        task.wait(0.6)
    end
end)

do
    local dragging, start, origin
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            start = input.Position
            origin = panel.Position
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - start
            panel.Position = UDim2.new(origin.X.Scale, origin.X.Offset + d.X, origin.Y.Scale, origin.Y.Offset + d.Y)
        end
    end)
end

btnClose.MouseButton1Click:Connect(function()
    sg.Enabled = false
end)

getgenv().WuPhoneTycoonLoaded = true
getgenv().WuPhoneBuildUI = sg
print("[造一部手机] UI 已加载")
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "造一部手机",
        Text = "已加载",
        Duration = 3,
    })
end)
