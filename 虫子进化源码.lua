-- 虫子进化 · 合集（自动攻击 + 经验球拾取）· Obsidian UI
-- 一个窗口三个标签：自动攻击 / 经验球 / 设置。右 Ctrl 显示或隐藏。
-- 停止并卸载：getgenv().__bugEvo.destroy()

local RS = game:GetService("ReplicatedStorage")
local LP = game:GetService("Players").LocalPlayer

-- 重复执行：先彻底停掉上一份（合集、单独版、旧版都会处理），避免多个循环同时瞬移
for _, key in ipairs({ "__bugEvo", "__autoAttackLow", "__orbPicker" }) do
	local prev = getgenv()[key]
	if prev then
		if type(prev.destroy) == "function" then pcall(prev.destroy)
		elseif type(prev.stop) == "function" then pcall(prev.stop) end
	end
end

local S = (function()
local S = {
	running = false, alive = true, kills = 0, hits = 0, curName = "", curHp = 0, lastError = "",
	maxDist = 2000, teleport = true, attackGap = 0.15, folderName = "Bugs",
	tiers = { small = 150, medium = 700 },   -- 小 <150，中 150~700，大 >700
	allow = { small = true, medium = true, large = true },
	absorb = true, absorbRadius = 2.5, absorbMax = 1.5, corpseScan = 60,
	corpseMaxTries = 2,                      -- 同一具尸体最多回头吸几次，防止卡死在吸不动的尸体上
}
getgenv().__autoAttackLow = S

local tries = setmetatable({}, { __mode = "k" })

local function sizeOf(maxHp)
	if maxHp < S.tiers.small then return "small" end
	if maxHp < S.tiers.medium then return "medium" end
	return "large"
end

local function bugs()
	local f = workspace:FindFirstChild(S.folderName)
	if not f then return {} end
	local list = {}
	for _, m in ipairs(f:GetChildren()) do
		local h = m:FindFirstChildWhichIsA("Humanoid")
		if h and h.Health > 0 and m:GetAttribute("Corpse") ~= true then
			local t = sizeOf(h.MaxHealth)
			if S.allow[t] then
				list[#list + 1] = { model = m, hum = h, size = t }
			end
		end
	end
	return list
end

local function hrp()
	local ch = LP.Character
	return ch and ch:FindFirstChild("HumanoidRootPart")
end

local function reach() return (LP:GetAttribute("Reach") or 16) - 1 end

local function cooldown()
	local a = (LP:GetAttribute("AttackSpeed") or 1) * (LP:GetAttribute("AttackSpeedMult") or 1)
	if a <= 0 then a = 1 end
	return 1 / a + S.attackGap
end

-- 吸收：站到尸体上方，XP 吸干 / 超时 / 脚本停止就退出
local function absorb(model)
	if not model or not model.Parent then return end
	tries[model] = (tries[model] or 0) + 1
	local t0 = os.clock()
	while S.running and model.Parent and model:GetAttribute("Corpse") == true do
		local xp = model:GetAttribute("XPLeft") or 0
		if xp <= 0 then break end
		if os.clock() - t0 > S.absorbMax then break end
		local h = hrp()
		if not h then break end
		local p = model:GetPivot().Position
		if (p - h.Position).Magnitude > S.absorbRadius then
			h.CFrame = CFrame.new(p + Vector3.new(0, 1.5, 0))
		end
		task.wait(0.1)
	end
end

local function corpseNear(h)
	local f = workspace:FindFirstChild(S.folderName)
	if not f then return nil end
	local best, bd = nil, math.huge
	for _, m in ipairs(f:GetChildren()) do
		if m:GetAttribute("Corpse") == true and (tries[m] or 0) < S.corpseMaxTries then
			local xp = m:GetAttribute("XPLeft") or 0
			if xp > 0 then
				local d = (m:GetPivot().Position - h.Position).Magnitude
				if d <= S.corpseScan and d < bd then best, bd = m, d end
			end
		end
	end
	return best
end

local function step()
	local h = hrp()
	if not h then return 0.3 end
	if S.absorb then
		local c = corpseNear(h)
		if c then
			absorb(c)
			return 0.05
		end
	end
	local best, bestHp, bd = nil, math.huge, math.huge
	for _, b in ipairs(bugs()) do
		local p = b.model:GetPivot().Position
		local d = (p - h.Position).Magnitude
		if d <= S.maxDist then
			if b.hum.Health < bestHp or (b.hum.Health == bestHp and d < bd) then
				best, bestHp, bd = b, b.hum.Health, d
			end
		end
	end
	if not best then return 0.5 end
	S.curName, S.curHp = best.model.Name, bestHp
	local d = (best.model:GetPivot().Position - h.Position).Magnitude
	if d > reach() then
		if not S.teleport then return 0.3 end
		h.CFrame = CFrame.new(best.model:GetPivot().Position + Vector3.new(0, 2, 0))
		task.wait(0.15)
	end
	local remotes = RS:FindFirstChild("Remotes")
	local attack = remotes and remotes:FindFirstChild("Attack")
	if not attack then error("找不到 ReplicatedStorage.Remotes.Attack（游戏更新了？）") end
	attack:FireServer(best.model)
	S.hits = S.hits + 1
	task.wait(cooldown())
	if best.hum.Health <= 0 or best.model:GetAttribute("Corpse") == true then
		S.kills = S.kills + 1
		if S.absorb and S.running then absorb(best.model) end
	elseif best.model.Parent == nil then
		S.kills = S.kills + 1
	end
	return 0.05
end

function S.start()
	if S.running or not S.alive then return end
	S.running = true
	task.spawn(function()
		while S.running and S.alive do
			local ok, wait = pcall(step)
			if not ok then
				S.lastError = tostring(wait)
				warn("[自动攻击] " .. S.lastError)
				task.wait(1)
			elseif wait and wait > 0 then
				task.wait(wait)
			end
		end
	end)
end

function S.stop()
	S.running = false
	return S.kills
end

function S.state()
	return ("run=%s hits=%d kills=%d xp=%s target=%s hp=%d err=%s"):format(
		tostring(S.running), S.hits, S.kills, tostring(LP:GetAttribute("TotalXP")),
		S.curName, S.curHp, S.lastError)
end


return S
end)()

local O = (function()
local S = {
	running = false, alive = true, picked = 0, failed = 0,
	radius = math.huge,
	delay = 0.12,      -- 每个球停留时间，太低可能漏捡
	maxTries = 3,      -- 同一个球试几次还没消失就先放弃
	retryAfter = 20,   -- 放弃的球多少秒后再试
}
getgenv().__orbPicker = S

local tries = setmetatable({}, { __mode = "k" })

local function orbFolder() return workspace:FindFirstChild("Orbs") end

local function hrp()
	local ch = LP.Character
	return ch and ch:FindFirstChild("HumanoidRootPart")
end

local function nextOrb(h)
	local f = orbFolder()
	if not f then return nil end
	local best, bd
	local now = os.clock()
	for _, o in ipairs(f:GetChildren()) do
		if o:IsA("BasePart") then
			local t = tries[o]
			if not (t and t.n >= S.maxTries and now - t.t < S.retryAfter) then
				local d = (o.Position - h.Position).Magnitude
				if d <= S.radius and (not bd or d < bd) then bd, best = d, o end
			end
		end
	end
	return best
end

function S.start()
	if S.running or not S.alive then return end
	S.running = true
	task.spawn(function()
		while S.running and S.alive do
			local h = hrp()
			if not h then
				task.wait(0.2)
			else
				local ok, err = pcall(function()
					local best = nextOrb(h)
					if not best then task.wait(0.4) return end
					local pos = best.Position
					local t = tries[best]
					if t and t.n > 0 then
						-- 上次没捡到：先离开再回来，让服务器重新触发 Touched
						h.CFrame = CFrame.new(pos + Vector3.new(0, 8, 0))
						task.wait(0.05)
					end
					h.CFrame = CFrame.new(pos)
					task.wait(S.delay)
					if best.Parent then
						t = t or { n = 0, t = 0 }
						t.n += 1
						t.t = os.clock()
						tries[best] = t
						S.failed += 1
					else
						S.picked += 1
					end
				end)
				if not ok then
					warn("[经验球] " .. tostring(err))
					task.wait(0.5)
				end
			end
		end
	end)
end

function S.stop()
	S.running = false
	return S.picked
end

function S.state()
	local f = orbFolder()
	return ("run=%s picked=%d failed=%d left=%d"):format(
		tostring(S.running), S.picked, S.failed, f and #f:GetChildren() or 0)
end


return S
end)()

-- ===== Obsidian UI =====
local Library
do
	local ok, lib = pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
	end)
	if ok and type(lib) == "table" then Library = lib
	else warn("[虫子进化] Obsidian 加载失败：" .. tostring(lib) .. "；可用 getgenv().__autoAttackLow / __orbPicker 的 start()/stop()") end
end

local ALL = { attack = S, orb = O }
getgenv().__bugEvo = ALL

function ALL.destroy()
	S.running, S.alive = false, false
	O.running, O.alive = false, false
	if Library and not Library.Unloaded then pcall(function() Library:Unload() end) end
	if getgenv().__autoAttackLow == S then getgenv().__autoAttackLow = nil end
	if getgenv().__orbPicker == O then getgenv().__orbPicker = nil end
	if getgenv().__bugEvo == ALL then getgenv().__bugEvo = nil end
end
S.destroy, O.destroy = ALL.destroy, ALL.destroy

if Library then
	pcall(function() Library:SetFont(Enum.Font.SourceSans) end)
	Library:OnUnload(function()
		S.running, S.alive = false, false
		O.running, O.alive = false, false
	end)

	local Window = Library:CreateWindow({
		Title = "虫子进化", Footer = "自动攻击 + 经验球", NotifySide = "Right", ShowCustomCursor = false,
	})
	local Tabs = {
		Attack = Window:AddTab("自动攻击", "swords"),
		Orb = Window:AddTab("经验球", "boxes"),
		Misc = Window:AddTab("设置", "settings"),
	}
	local Toggles = Library.Toggles

	-- 两个功能都会瞬移角色，互斥：开一个自动关另一个
	local function turnOff(idx)
		local t = Toggles[idx]
		if t and t.Value then t:SetValue(false) end
	end

	-- 自动攻击
	local Ctl = Tabs.Attack:AddGroupbox({ Side = "Left", Name = "控制", IconName = "play" })
	Ctl:AddToggle("AA_Run", {
		Text = "自动攻击", Default = false, Tooltip = "会瞬移角色；和经验球拾取互斥",
		Callback = function(v)
			if v then
				turnOff("Orb_Run")
				if not S.running then S.hits, S.kills = 0, 0 end
				S.start()
			else
				S.stop()
			end
		end,
	})
	Ctl:AddToggle("AA_Teleport", { Text = "允许瞬移到目标", Default = true, Callback = function(v) S.teleport = v end })
	Ctl:AddToggle("AA_Absorb", { Text = "击杀后吸收经验", Default = true, Callback = function(v) S.absorb = v end })

	local Flt = Tabs.Attack:AddGroupbox({ Side = "Right", Name = "体型筛选", IconName = "filter" })
	Flt:AddToggle("AA_Small", { Text = "小型（HP < 150）", Default = true, Callback = function(v) S.allow.small = v end })
	Flt:AddToggle("AA_Medium", { Text = "中型（150 ~ 700）", Default = true, Callback = function(v) S.allow.medium = v end })
	Flt:AddToggle("AA_Large", { Text = "大型（> 700）", Default = true, Callback = function(v) S.allow.large = v end })

	local AInfo = Tabs.Attack:AddGroupbox({ Side = "Right", Name = "状态", IconName = "activity" })
	local aStatus = AInfo:AddLabel("已停止", true)
	local aErr = AInfo:AddLabel("", true)

	-- 经验球
	local OCtl = Tabs.Orb:AddGroupbox({ Side = "Left", Name = "控制", IconName = "play" })
	OCtl:AddToggle("Orb_Run", {
		Text = "自动拾取经验球", Default = false, Tooltip = "会瞬移角色；和自动攻击互斥",
		Callback = function(v)
			if v then
				turnOff("AA_Run")
				O.picked, O.failed = 0, 0
				O.start()
			else
				O.stop()
			end
		end,
	})
	OCtl:AddSlider("Orb_Radius", {
		Text = "拾取范围", Default = 2000, Min = 100, Max = 2000, Rounding = 0, Suffix = " 格", Tooltip = "拉满 = 全图",
		Callback = function(v) O.radius = (v >= 2000) and math.huge or v end,
	})
	local OInfo = Tabs.Orb:AddGroupbox({ Side = "Right", Name = "状态", IconName = "activity" })
	local oStatus = OInfo:AddLabel("已停止", true)

	-- 设置
	local M = Tabs.Misc:AddGroupbox({ Side = "Left", Name = "菜单", IconName = "settings" })
	M:AddLabel("菜单快捷键"):AddKeyPicker("MenuKeybind", { Default = "RightControl", NoUI = true, Text = "菜单快捷键" })
	Library.ToggleKeybind = Library.Options.MenuKeybind
	M:AddButton({ Text = "停止并卸载", Func = function() ALL.destroy() end, DoubleClick = true })

	task.spawn(function()
		while S.alive and not Library.Unloaded do
			pcall(function()
				aStatus:SetText(("%s  击杀 %d  XP %s\n目标 %s"):format(
					S.running and "运行中" or "已停止", S.kills,
					tostring(LP:GetAttribute("TotalXP")), S.curName ~= "" and S.curName or "-"))
				aErr:SetText(S.lastError ~= "" and ("最近错误：" .. S.lastError) or "")
				local f = workspace:FindFirstChild("Orbs")
				oStatus:SetText(("%s\n已拾取 %d  未拾取到 %d  剩余 %d"):format(
					O.running and "运行中" or "已停止", O.picked, O.failed, f and #f:GetChildren() or 0))
			end)
			task.wait(0.5)
		end
	end)
end
