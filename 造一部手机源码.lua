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

MainLeft:AddLabel("空闲时自动开研究面板；依赖 Tick", true)

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
                if researchStatus and researchStatus.SetText then
                    researchStatus:SetText(string.format("[%s] day=%s rp=%s lab=%s", run, day, rp, lab))
                elseif researchStatus then
                    -- Obsidian Label 可能用不同 API
                    pcall(function() researchStatus:SetText(string.format("[%s] day=%s rp=%s lab=%s", run, day, rp, lab)) end)
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
        local R, E = getResearch(), getExtra()
        if R then
            if type(R.stop) == "function" then pcall(R.stop) else R.running = false end
        end
        if E then
            if type(E.stop) == "function" then pcall(E.stop) else E.running = false end
        end
        pcall(function()
            if Toggles.AutoResearch then Toggles.AutoResearch:SetValue(false) end
            if Toggles.AutoRelocate then Toggles.AutoRelocate:SetValue(false) end
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
