--[[
  力量随机生成 · 辅助面板 v2
  ─────────────────────────────
  ① 兑换码    需加官方群组（客户端硬性校验）
  ② 自动重抽  Roll（重抽力量）+ 自动领每日/在线奖励
  ③ 技能点    扫描 → 确认 → 购买（失败不扣钱）
  ④ 悬浮挂机  脚底生成本地透明平台，抬到高空，只有自己能看见
  ⑤ 图鉴/徽章  自动领取 INDEX 与 BADGES 奖励
  ⑥ 药水商店  POTIONS 全列表 + 勾选购买 + 自动补货 / 自动喝
  ⑦ 自动刷    刷金币（自动选最快手套）/ 刷钻石（+亿万富翁）+ 精简挂机 HUD
  ⑧ 战斗      贴近自动攻击 + 判定框放大 + 防布娃娃 + 无惯性加速
]]

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local plr = Players.LocalPlayer

if getgenv().__PF_FPS_CONN_MAIN then pcall(function() getgenv().__PF_FPS_CONN_MAIN:Disconnect() end) end
getgenv().__PF_FRAMES = 0
getgenv().__PF_FPS_CONN_MAIN = RunService.RenderStepped:Connect(function()
	getgenv().__PF_FRAMES = (getgenv().__PF_FRAMES or 0) + 1
end)

if getgenv().__PF_LIB then pcall(function() getgenv().__PF_LIB:Unload() end) end
if getgenv().__PF_LOOP then pcall(function() task.cancel(getgenv().__PF_LOOP) end) end
if getgenv().__PF_ROLL then pcall(function() task.cancel(getgenv().__PF_ROLL) end) end
if getgenv().__PF_FARM_HUD then pcall(function() getgenv().__PF_FARM_HUD:Destroy() end) end
getgenv().__PF_FARM = nil

local SH = RS:WaitForChild("Shared")
local E  = RS:WaitForChild("Events")
local RE = E:WaitForChild("RemoteEvents")
local RF = E:WaitForChild("RemoteFunctions")

local okDS, DSmod = pcall(require, SH:WaitForChild("DataService"))
local DS = okDS and DSmod.client or nil
local okTree, TreeCfg = pcall(require, SH:WaitForChild("UpgradeTreeConfig"))
local okCodes, CodesCfg = pcall(require, SH:WaitForChild("CodesConfig"))

local M = {}
local CFG = getgenv().__PF_CFG or { autoAllow = false, autoAfk = false, autoClaim = true, autoRewards = true, antiAfk = true }
CFG.autoRewards = CFG.autoRewards ~= false
if CFG.antiAfk == nil then CFG.antiAfk = true end
CFG.potionSel = CFG.potionSel or {}
CFG.autoPotions = CFG.autoPotions == true
CFG.autoDrink = CFG.autoDrink == true
CFG.qty = CFG.qty or {}
CFG.nextAt = CFG.nextAt or {}
CFG.ivH = tonumber(CFG.ivH) or 0
CFG.ivM = tonumber(CFG.ivM) or 0
CFG.ivS = tonumber(CFG.ivS) or 30
CFG.timed = CFG.timed == true
CFG.confirmed = CFG.confirmed == true
CFG.espScale = tonumber(CFG.espScale) or 100
CFG.espAlpha = tonumber(CFG.espAlpha) or 0.15
getgenv().__PF_CFG = CFG

local function char()
	local c = plr.Character
	if not c then return nil end
	return c, c:FindFirstChildOfClass("Humanoid"), c:FindFirstChild("HumanoidRootPart")
end

local function data(key)
	if not DS then return nil end
	local ok, v = pcall(function() return DS:get(key) end)
	if ok then return v end
	return nil
end

local function fmt(n)
	n = tonumber(n) or 0
	if n >= 1e9 then return string.format("%.2fB", n / 1e9) end
	if n >= 1e6 then return string.format("%.2fM", n / 1e6) end
	if n >= 1e4 then return string.format("%.1fK", n / 1e4) end
	return tostring(math.floor(n))
end

local lastMsg = ""
local function hookMsg(rem)
	if not rem then return end
	rem.OnClientEvent:Connect(function(a, b)
		local s = tostring(a)
		if type(b) == "string" then s = s .. " " .. b end
		lastMsg = s
	end)
end
pcall(function() hookMsg(RE:FindFirstChild("CustomErrorMessage")) end)
pcall(function() hookMsg(RE:FindFirstChild("CustomPlayerMessage")) end)
pcall(function() hookMsg(RE:FindFirstChild("CustomAboveMessage")) end)

-- ══════════ ① 兑换码 ══════════
local GROUP_ID = okCodes and tonumber(CodesCfg.GROUP_ID) or 1096936253

function M.inGroup()
	local ok, v = pcall(function() return plr:IsInGroup(GROUP_ID) end)
	return ok and v == true
end

function M.joinGroup()
	local rem = RE:FindFirstChild("PromptGroupJoin")
	if not rem then return false, "无加群接口" end
	pcall(function() rem:FireServer() end)
	return true, "已弹出加群窗口"
end

function M.redeemCodes()
	if not M.inGroup() then return 0, "未加群，先点「加入群组」" end
	local list = {}
	if okCodes and type(CodesCfg.CODES) == "table" then
		local used = data("Codes") or {}
		for k in pairs(CodesCfg.CODES) do
			if not used[tostring(k)] then list[#list + 1] = tostring(k) end
		end
	end
	if #list == 0 then return 0, "没有可兑换的码" end
	for _, c in ipairs(list) do
		pcall(function() RE.CodeRewardEvent:FireServer(c) end)
		task.wait(1.2)
	end
	task.wait(1.2)
	local used2 = data("Codes") or {}
	local got = 0
	for _, c in ipairs(list) do if used2[c] then got = got + 1 end end
	return got, string.format("兑换 %d/%d", got, #list)
end

-- ══════════ ② 自动抽卡 ══════════
local rollStats = { n = 0, last = "Nothing" }

local function guardFlag(name)
	local c = char()
	if not c then return nil end
	local v = c:FindFirstChild(name)
	if v and v:IsA("BoolValue") then return v.Value end
	return nil
end

function M.clearGuards()
	local c = char()
	if not c then return end
	local im = c:FindFirstChild("InMenu")
	if im and im.Value then im.Value = false end
	local fr = c:FindFirstChild("FirstRoll")
	if fr and fr.Value then fr.Value = false end
end

-- 抽到好东西会播过场动画（BlackScreen / 电影界面），把 roll 卡住
function M.clearAnim()
	local hit = false
	local mp = plr.PlayerGui:FindFirstChild("MainPlayerGuis")
	local rng = mp and mp:FindFirstChild("RNGScreens")
	if rng then
		for _, d in ipairs(rng:GetChildren()) do
			if d:IsA("Frame") and string.find(d.Name, "BlackScreen") and d.Visible then
				d.Visible = false
				hit = true
			end
		end
	end
	for _, name in ipairs({ "ExetiorCinematic", "DarklordCinematic", "HourglassCinematic", "EmeraldCinematic" }) do
		local g = plr.PlayerGui:FindFirstChild(name)
		if g then
			for _, d in ipairs(g:GetDescendants()) do
				if d:IsA("Frame") and d.Visible and (d.Name == "BlackFrame" or string.find(d.Name, "Cinematic")) then
					d.Visible = false
					hit = true
				end
			end
		end
	end
	return hit
end

-- FPS 优化：关掉粒子/光束/拖尾/烟火/后期特效，可一键恢复
local FX_CLASSES = { ParticleEmitter = true, Beam = true, Trail = true, Smoke = true, Fire = true, Sparkles = true }
local fxStore = {}

local function disableIn(inst)
	local n = 0
	for _, d in ipairs(inst:GetDescendants()) do
		if FX_CLASSES[d.ClassName] and d.Enabled then
			d.Enabled = false
			fxStore[#fxStore + 1] = d
			n = n + 1
		end
	end
	return n
end

function M.fxToggle()
	local on = not getgenv().__PF_FPS
	getgenv().__PF_FPS = on
	if on then
		if getgenv().__PF_SHADOWS == nil then getgenv().__PF_SHADOWS = Lighting.GlobalShadows end
		local n = disableIn(workspace)
		for _, g in ipairs(plr.PlayerGui:GetChildren()) do
			n = n + disableIn(g)
		end
		for _, d in ipairs(Lighting:GetChildren()) do
			if d:IsA("PostEffect") and d.Enabled then
				d.Enabled = false
				fxStore[#fxStore + 1] = d
			end
		end
		Lighting.GlobalShadows = false
		if not getgenv().__PF_FX_CONN then
			getgenv().__PF_FX_CONN = workspace.DescendantAdded:Connect(function(d)
				if getgenv().__PF_FPS and FX_CLASSES[d.ClassName] then
					task.defer(function()
						if d.Parent and d.Enabled then
							d.Enabled = false
							fxStore[#fxStore + 1] = d
						end
					end)
				end
			end)
		end
		getgenv().__PF_FX_N = n
		return true, "已关 " .. n .. " 个特效 · 新特效自动关闭"
	end
	if getgenv().__PF_FX_CONN then
		pcall(function() getgenv().__PF_FX_CONN:Disconnect() end)
		getgenv().__PF_FX_CONN = nil
	end
	for _, d in ipairs(fxStore) do
		pcall(function()
			if d.Parent then d.Enabled = true end
		end)
	end
	fxStore = {}
	if getgenv().__PF_SHADOWS ~= nil then
		Lighting.GlobalShadows = getgenv().__PF_SHADOWS
		getgenv().__PF_SHADOWS = nil
	end
	getgenv().__PF_FX_N = 0
	return false, "特效已恢复"
end

function M.rollOnce()
	local cd = 0
	local ok, v = pcall(function() return RF:FindFirstChild("RollCooldownQuery"):InvokeServer() end)
	if ok and type(v) == "number" then cd = v end
	if cd > 0 then return false, cd end
	M.clearGuards()
	M.clearAnim()
	if guardFlag("Invincible") or guardFlag("AbilityIFrames") then
		return false, 1
	end
	pcall(function() RE:FindFirstChild("RollRequest"):FireServer() end)
	rollStats.n = rollStats.n + 1
	local c = char()
	if c then
		local cp = c:FindFirstChild("CurrentPower")
		if cp then rollStats.last = tostring(cp.Value) end
	end
	return true, 0
end

function M.startRoll()
	if getgenv().__PF_ROLL_ON then return false, "已在运行" end
	getgenv().__PF_ROLL_ON = true
	getgenv().__PF_ROLL = task.spawn(function()
		while getgenv().__PF_ROLL_ON do
			local ok, cd = M.rollOnce()
			if not ok then
				task.wait(math.clamp(cd or 1, 0.35, 2))
			else
				task.wait(0.45)
			end
		end
		getgenv().__PF_ROLL = nil
	end)
	return true, "开始抽卡"
end

function M.stopRoll()
	getgenv().__PF_ROLL_ON = nil
	getgenv().__PF_ROLL = nil
	return true, "已停止"
end

function M.claimAll()
	pcall(function() RE:FindFirstChild("ClaimDailyReward"):FireServer() end)
	task.wait(0.3)
	for i = 1, 7 do
		pcall(function() RE:FindFirstChild("RewardGiftPlayedEvent"):FireServer(i) end)
		task.wait(0.22)
	end
	return true, "已领取每日 + 在线奖励"
end

-- ══════════ ③ 技能点 ══════════
local function purchasedCount()
	local st = data("SkillTree")
	local arr = st and st.PurchasedNodes
	if type(arr) ~= "table" then return 0 end
	return #arr
end

local function coinBalance()
	local cur = data("Currency")
	if type(cur) ~= "table" then return 0 end
	return tonumber(cur.Coins) or 0
end

local parentMap = {}
if okTree and type(TreeCfg.SPECIAL_UNLOCKS) == "table" then
	for parent, kids in pairs(TreeCfg.SPECIAL_UNLOCKS) do
		if type(kids) == "table" then
			for _, kid in pairs(kids) do parentMap[tostring(kid)] = tostring(parent) end
		end
	end
end
if okTree and type(TreeCfg.CHAINS) == "table" then
	for _, nodes in pairs(TreeCfg.CHAINS) do
		if type(nodes) == "table" and nodes[1] then
			for i = 2, #nodes do parentMap[tostring(nodes[i])] = tostring(nodes[i - 1]) end
		end
	end
end

local function candidates()
	if not okTree then return {}, 0 end
	local prices = TreeCfg.NODE_PRICES or {}
	local coins = coinBalance()
	local list = {}
	for name, price in pairs(prices) do
		name = tostring(name)
		local p = tonumber(price) or math.huge
		local isCenter = TreeCfg.CENTER_NODE and tostring(TreeCfg.CENTER_NODE) == name
		if p > 0 and not isCenter and p <= coins then
			list[#list + 1] = { name = name, price = p, parent = parentMap[name] }
		end
	end
	table.sort(list, function(a, b) return a.price < b.price end)
	return list, coins
end

function M.scanSkills()
	local list, coins = candidates()
	local out = {}
	for i = 1, math.min(#list, 8) do
		out[i] = string.format("%s(%s)", list[i].name, fmt(list[i].price))
	end
	return out, #list, coins
end

function M.tryBuy(nodeName)
	local before = purchasedCount()
	pcall(function() RE:FindFirstChild("PurchaseSkillNode"):FireServer(nodeName) end)
	task.wait(0.85)
	if purchasedCount() > before then return true end
	pcall(function() RE:FindFirstChild("SkillNodeConfirm"):FireServer(nodeName) end)
	task.wait(0.85)
	if purchasedCount() > before then return true end
	return false
end

function M.buyBatch(limit)
	limit = limit or 6
	local list = candidates()
	local bought, fail = 0, 0
	for _, item in ipairs(list) do
		if bought >= limit or fail >= 3 then break end
		if M.tryBuy(item.name) then
			bought = bought + 1
			fail = 0
		else
			fail = fail + 1
		end
		task.wait(0.15)
	end
	return bought, fail
end

-- ══════════ ④ 悬浮挂机 ══════════
local PAD_NAME = "__PF_FloatPad"

local function ensurePad()
	local pad = workspace:FindFirstChild(PAD_NAME)
	if pad then return pad end
	local p = Instance.new("Part")
	p.Name = PAD_NAME
	p.Size = Vector3.new(10, 1, 10)
	p.Anchored = true
	p.CanCollide = true
	p.CanQuery = false
	p.CanTouch = false
	p.Transparency = 1
	p.Massless = true
	p.Parent = workspace
	return p
end

function M.floatUp(height)
	local _, hum, hrp = char()
	if not hrp then return false, "无角色（大厅菜单中天然安全）" end
	height = tonumber(height) or 800
	local pad = ensurePad()
	local base = hrp.Position + Vector3.new(0, height, 0)
	pad.CFrame = CFrame.new(base - Vector3.new(0, 3.6, 0))
	task.wait(0.1)
	hrp.CFrame = CFrame.new(base + Vector3.new(0, 4, 0))
	task.wait(0.4)
	local _, _, hrp2 = char()
	if not hrp2 then return false, "角色丢失" end
	hrp2.CFrame = CFrame.new(base + Vector3.new(0, 4, 0))
	return true, string.format("已悬浮 %d 格", height)
end

function M.floatDown()
	local pad = workspace:FindFirstChild(PAD_NAME)
	if pad then pad:Destroy() end
	local _, hum, hrp = char()
	if not hrp then return true, "已落地（大厅菜单中）" end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { plr.Character }
	local from = hrp.Position + Vector3.new(0, 4, 0)
	local hit = workspace:Raycast(from, Vector3.new(0, -3000, 0), params)
	while hit do
		local n = string.lower(hit.Instance.Name)
		if not (string.find(n, "kill") or string.find(n, "void") or string.find(n, "death")
			or string.find(n, "lava") or string.find(n, "damage")) then
			break
		end
		from = hit.Position - Vector3.new(0, 2, 0)
		hit = workspace:Raycast(from, Vector3.new(0, -3000, 0), params)
	end
	if not hit then return false, "下方 3000 格内没有地面" end
	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.CFrame = CFrame.new(hit.Position + Vector3.new(0, 4, 0))
	pcall(function()
		if hum then
			hum:ChangeState(Enum.HumanoidStateType.Landed)
			hum:ChangeState(Enum.HumanoidStateType.Running)
		end
	end)
	task.wait(0.15)
	return true, "已落地"
end

function M.padAlive()
	return workspace:FindFirstChild(PAD_NAME) ~= nil
end

-- ══════════ ⑤ 图鉴 / 徽章奖励 ══════════
local LOBBY_GUI = "LobbyFramesPlayerGui"

local function lobbyGui()
	local pg = plr:FindFirstChild("PlayerGui")
	return pg and pg:FindFirstChild(LOBBY_GUI)
end

-- INDEX：Index[name.."_INDEX"]==true 且 Powers[name]~=true 时可领
function M.claimIndex()
	local lobby = lobbyGui()
	local frame = lobby and lobby:FindFirstChild("IndexFrame")
	if not frame then return 0, "大厅 UI 未加载" end
	local idx = data("Index") or {}
	local powers = data("Powers") or {}
	local n = 0
	for _, d in ipairs(frame:GetDescendants()) do
		if d:IsA("TextButton") then
			local name = d.Name:match("%) (.+)$")
			local claim = name and d:FindFirstChild("ClaimButton")
			if name and claim and idx[name .. "_INDEX"] == true and powers[name] ~= true then
				local parentName = d.Parent and d.Parent.Name or ""
				pcall(function() RE:FindFirstChild("IndexClaimReward"):FireServer(name, parentName) end)
				n = n + 1
				task.wait(0.22)
			end
		end
	end
	return n, n > 0 and string.format("已领图鉴 %d 个", n) or "图鉴暂无可领"
end

-- BADGES：已拥有徽章 且 BadgesClaimed[id]~=true 时可领
function M.claimBadges()
	local lobby = lobbyGui()
	local frame = lobby and lobby:FindFirstChild("BadgesFrame")
	if not frame then return 0, "大厅 UI 未加载" end
	local scroll = frame:FindFirstChild("ScrollingFrame") or frame
	local claimed = data("BadgesClaimed") or {}
	local n = 0
	for _, d in ipairs(scroll:GetChildren()) do
		if d:IsA("Frame") then
			local id = d.Name:match("%)%s*(%d+)$")
			local b = d:FindFirstChild("ClaimButton")
			local hidden = d:FindFirstChild("Hidden")
			local owned = b and b.Visible and not (hidden and hidden.Visible)
			local used = id and (claimed[id] == true or claimed[tonumber(id)] == true)
			if id and owned and not used then
				pcall(function() RE:FindFirstChild("RewardBadgeEvent"):FireServer(tonumber(id)) end)
				n = n + 1
				task.wait(0.3)
			end
		end
	end
	return n, n > 0 and string.format("已领徽章 %d 个", n) or "徽章暂无可领"
end

-- ══════════ ⑥ 药水商店 ══════════
local POTION_CURRENCY = {
	["Lucky Potion"] = "Coins",
	["Speedy Potion"] = "Coins",
	["Fortune Potion"] = "Coins",
	["Haste Potion"] = "Coins",
	["Demonic Potion"] = "Diamonds",
	["Heavenly Potion"] = "Diamonds",
	["Pumpkin Potion"] = "CandyCorns",
}
local CUR_LABEL = { Coins = "金币", Diamonds = "钻石", CandyCorns = "玉米糖" }
local CUR_COLOR = {
	Coins = Color3.fromRGB(232, 196, 96),
	Diamonds = Color3.fromRGB(96, 190, 235),
	CandyCorns = Color3.fromRGB(235, 140, 190),
}
-- 中文名以游戏内官方译名为准：Speedy=迅捷、Haste=急速
local DISP = {
	["Lucky Potion"] = "幸运药水",
	["Speedy Potion"] = "迅捷药水",
	["Fortune Potion"] = "财富药水",
	["Haste Potion"] = "急速药水",
	["Demonic Potion"] = "恶魔药水",
	["Heavenly Potion"] = "神圣药水",
	["Pumpkin Potion"] = "南瓜药水",
}
local function disp(name) return DISP[name] or name end

local function potionScrollFrame()
	local lobby = lobbyGui()
	local frame = lobby and lobby:FindFirstChild("PotionsFrame")
	return frame and frame:FindFirstChild("ScrollingFrame")
end

-- 价格文本容错：去富文本标签、$、逗号，支持 K/M/B 后缀
local function parsePrice(text)
	if type(text) ~= "string" then return 0 end
	local s = string.gsub(text, "<[^>]->", "")
	s = string.gsub(s, "[%s,%(%)%$]", "")
	local num, suffix = string.match(s, "([%d%.]+)([KkMmBb]?)")
	if not num then return 0 end
	local v = tonumber(num) or 0
	suffix = string.upper(suffix or "")
	if suffix == "K" then v = v * 1000
	elseif suffix == "M" then v = v * 1000000
	elseif suffix == "B" then v = v * 1000000000 end
	return math.floor(v)
end

-- 价格/效果直接读游戏 UI，折扣变化会自动同步
function M.potionList()
	local s = potionScrollFrame()
	if not s then return {} end
	local inv = data("Inventory") or {}
	local owned = inv.Potions or {}
	local list = {}
	for _, d in ipairs(s:GetChildren()) do
		if d:IsA("Frame") and d.Name ~= "Space" then
			local bb = d:FindFirstChild("BuyButton")
			local price = 0
			if bb then
				for _, t in ipairs(bb:GetDescendants()) do
					if t:IsA("TextLabel") then
						local v = parsePrice(t.Text)
						if v > price then price = v end
					end
				end
			end
				if price > 0 then
				local effect = ""
				local inner = d:FindFirstChild("Frame")
				if inner then
					local e1, e2, tm
					for _, e in ipairs(inner:GetChildren()) do
						if e:IsA("TextLabel") then
							local n = e.Name
							if string.find(n, "Effect1") then e1 = e.Text
							elseif string.find(n, "Effect2") then e2 = e.Text
							elseif string.find(n, "TimeEffect") then tm = e.Text end
						end
					end
					local parts = {}
					if e1 and #e1 > 0 then parts[#parts + 1] = e1 end
					if e2 and #e2 > 0 then parts[#parts + 1] = e2 end
					if tm and #tm > 0 then parts[#parts + 1] = tm end
					effect = table.concat(parts, " · ")
				end
				list[#list + 1] = {
					name = d.Name,
					price = price,
					currency = POTION_CURRENCY[d.Name] or "Coins",
					owned = tonumber(owned[d.Name]) or 0,
					effect = effect,
					}
				end
		end
	end
	return list
end

function M.buyPotion(name, qty)
	qty = math.clamp(math.floor(tonumber(qty) or 1), 1, 99)
	local info
	for _, p in ipairs(M.potionList()) do
		if p.name == name then info = p break end
	end
	if not info then return false, "未找到 " .. tostring(name) end
	local cur = data("Currency") or {}
	local bal = tonumber(cur[info.currency]) or 0
	local total = info.price * qty
	if bal < total then
		return false, string.format("%s不足（需 %s）", CUR_LABEL[info.currency] or info.currency, fmt(total))
	end
	local rem = RE:FindFirstChild("BuyItem")
	if not rem then return false, "无购买接口" end
	local before = info.owned
	for _ = 1, qty do
		pcall(function() rem:FireServer(name, info.price, info.currency) end)
		task.wait(0.06)
	end
	task.wait(0.6)
	local inv = data("Inventory") or {}
	local after = tonumber((inv.Potions or {})[name]) or 0
	local got = after - before
	if got > 0 then
		return true, string.format("已买 %s ×%d · -%s %s", disp(name), got, fmt(got * info.price), CUR_LABEL[info.currency] or info.currency)
	end
	return false, "购买未生效"
end

-- 定时购买：间隔秒数与倒计时（首次购买后才启动）
function M.intervalSeconds()
	local h = tonumber(CFG.ivH) or 0
	local m = tonumber(CFG.ivM) or 0
	local s = tonumber(CFG.ivS) or 0
	local total = h * 3600 + m * 60 + s
	if total < 5 then total = 5 end
	return total
end

function M.startCountdown(name)
	CFG.nextAt[name] = os.clock() + M.intervalSeconds()
end

function M.intervalDesc()
	local t = M.intervalSeconds()
	local h = math.floor(t / 3600)
	local m = math.floor((t % 3600) / 60)
	local s = t % 60
	local parts = {}
	if h > 0 then parts[#parts + 1] = h .. " 小时" end
	if m > 0 then parts[#parts + 1] = m .. " 分" end
	if s > 0 or #parts == 0 then parts[#parts + 1] = s .. " 秒" end
	return table.concat(parts, " ")
end

function M.buySelected()
	if M._buyBusy then return 0, "上一轮还在进行" end
	M._buyBusy = true
	local sel = CFG.potionSel or {}
	local bought, last = 0, "未勾选药水"
	pcall(function()
		for _, p in ipairs(M.potionList()) do
			if sel[p.name] then
				local qty = math.clamp(tonumber(CFG.qty[p.name]) or 1, 1, 99)
				local ok, msg = M.buyPotion(p.name, qty)
				last = msg
				if ok then
					bought = bought + 1
					M.startCountdown(p.name)
				end
				task.wait(0.2)
			end
		end
	end)
	M._buyBusy = false
	return bought, last
end

-- 药水效果状态：Effects.Potions[name.."_EFFECT"] > 0 表示正在生效
function M.effectActive(name)
	local eff = data("Effects") or {}
	local potions = eff.Potions or {}
	return (tonumber(potions[name .. "_EFFECT"]) or 0) > 0
end

function M.effectCount()
	local c = char()
	if c then
		local ps = c:FindFirstChild("PlayerStats")
		local n = ps and ps:FindFirstChild("EffectsRnCount")
		if n then return tonumber(n.Value) or 0 end
	end
	local eff = data("Effects") or {}
	local n = 0
	for _, v in pairs(eff.Potions or {}) do
		if (tonumber(v) or 0) > 0 then n = n + 1 end
	end
	return n
end

local perkMod, perkTried = nil, false
local function effectSlotLimit()
	if perkTried then
		if not perkMod then return nil end
		local ok2, v = pcall(function() return perkMod.EffectSlots:getValue() end)
		return ok2 and type(v) == "number" and v or nil
	end
	perkTried = true
	local ok, mod = pcall(function() return require(SH:FindFirstChild("PerkLimits")) end)
	perkMod = ok and mod or nil
	if ok and mod and mod.EffectSlots then
		local ok2, v = pcall(function() return mod.EffectSlots:getValue() end)
		if ok2 and type(v) == "number" then return v end
	end
	return nil
end

local lastUse = {}
function M.usePotion(name)
	local inv = data("Inventory") or {}
	local count = tonumber((inv.Potions or {})[name]) or 0
	if count < 1 then return false, "没有库存" end
	if M.effectActive(name) then return false, "效果已生效" end
	if os.clock() - (lastUse[name] or -999) < 8 then return false, "冷却中" end
	local limit = effectSlotLimit()
	if limit and M.effectCount() + 1 > limit then return false, "效果栏已满" end
	local rem = RE:FindFirstChild("UseItem")
	if not rem then return false, "无使用接口" end
	lastUse[name] = os.clock()
	pcall(function() rem:FireServer(name) end)
	task.wait(0.5)
	local inv2 = data("Inventory") or {}
	local after = tonumber((inv2.Potions or {})[name]) or 0
	if after < count or M.effectActive(name) then
		return true, string.format("已喝 %s", disp(name))
	end
	return false, "使用未生效"
end

function M.useSelected()
	local sel = CFG.potionSel or {}
	local used, last = 0, "未勾选药水"
	for _, p in ipairs(M.potionList()) do
		if sel[p.name] then
			local ok, msg = M.usePotion(p.name)
			last = msg
			if ok then used = used + 1 end
			task.wait(0.2)
		end
	end
	return used, last
end

getgenv().__PF = M

-- ══════════ 防挂机 ══════════
local VirtualUser = game:GetService("VirtualUser")
local afk = { kicks = 0, t0 = os.clock() }
if getgenv().__PF_AFK_CONN then pcall(function() getgenv().__PF_AFK_CONN:Disconnect() end) end
getgenv().__PF_AFK_CONN = plr.Idled:Connect(function()
	if not CFG.antiAfk then return end
	pcall(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new(0, 0))
	end)
	local _, hum = char()
	if hum then pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end) end
	afk.kicks = afk.kicks + 1
end)

local function hms(sec)
	sec = math.max(0, math.floor(sec))
	return string.format("%02d:%02d:%02d", math.floor(sec / 3600), math.floor(sec % 3600 / 60), sec % 60)
end


-- ══════════ ⑧ 战斗 / 防护 / 移动 ══════════
local combat = { on = false, hitbox = 0, target = nil, swings = 0, hits = 0, range = 12, lead = 200, autoLead = true, ping = 0 }
-- 自动挥击：只做「范围内有敌人 → 触发攻击」，不移动、不转向、不选目标
local swing = { on = false, range = 8, last = 0, n = 0 }
local rag = { on = false, fixed = 0 }
local move = { speed = 0, orig = nil }
M.combat, M.rag, M.move = combat, rag, move

-- 注意：角色里同时有 HitboxPlayer(Script) 和 HitboxPlayer(Part)，必须按类型取
local function hitboxPart()
	local c = char()
	if not c then return nil end
	for _, d in ipairs(c:GetChildren()) do
		if d.Name == "HitboxPlayer" and d:IsA("BasePart") then return d end
	end
	return nil
end

local HITBOX_DEF = Vector3.new(4.5, 6, 2.75)

local function applyHitbox()
	local hp = hitboxPart()
	if not hp then return end
	local want = combat.hitbox > 4 and Vector3.new(combat.hitbox, combat.hitbox, combat.hitbox) or HITBOX_DEF
	if hp.Size ~= want then pcall(function() hp.Size = want end) end
end

function M.restoreHitbox()
	combat.hitbox = 0
	applyHitbox()
end

local function fixRagdoll()
	local c, h = char()
	if not (c and h and h.Health > 0) then return end
	local ab = c:FindFirstChild("AttackBooleans")
	if ab then
		for _, nm in ipairs({ "Ragdolled", "Stunned" }) do
			local v = ab:FindFirstChild(nm)
			if v and v.Value then v.Value = false end
		end
	end
	local dirty = false
	if h.PlatformStand then
		h.PlatformStand = false
		dirty = true
	end
	local st = h:GetState()
	if st == Enum.HumanoidStateType.Physics or st == Enum.HumanoidStateType.FallingDown then
		pcall(function() h:ChangeState(Enum.HumanoidStateType.GettingUp) end)
		pcall(function() h:ChangeState(Enum.HumanoidStateType.Running) end)
		dirty = true
	end
	for _, m in ipairs(c:GetDescendants()) do
		if m:IsA("Motor6D") then
			if not m.Enabled then m.Enabled = true dirty = true end
		elseif m:IsA("BallSocketConstraint") then
			m:Destroy()
			dirty = true
		end
	end
	if dirty then
		rag.fixed = rag.fixed + 1
		local hrp = c:FindFirstChild("HumanoidRootPart")
		if hrp then
			local lv = hrp.CFrame.LookVector
			hrp.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + Vector3.new(lv.X, 0, lv.Z))
		end
	end
end

local function startSpeedLoop()
	if getgenv().__PF_SPD_CONN then return end
	getgenv().__PF_SPD_CONN = RunService.Heartbeat:Connect(function()
		if move.speed <= 0 then return end
		local _, h, hrp = char()
		if not (h and hrp) then return end
		if h.WalkSpeed ~= move.speed then h.WalkSpeed = move.speed end
		local d = h.MoveDirection
		local v = hrp.AssemblyLinearVelocity
		hrp.AssemblyLinearVelocity = Vector3.new(d.X * move.speed, v.Y, d.Z * move.speed)
	end)
end

function M.setSpeed(v)
	v = math.clamp(tonumber(v) or 0, 0, 300)
	local _, h = char()
	if v > 0 then
		if not move.orig and h then move.orig = h.WalkSpeed end
		move.speed = v
		if h then h.WalkSpeed = v end
		startSpeedLoop()
	else
		move.speed = 0
		if getgenv().__PF_SPD_CONN then
			pcall(function() getgenv().__PF_SPD_CONN:Disconnect() end)
			getgenv().__PF_SPD_CONN = nil
		end
		if h then h.WalkSpeed = move.orig or 16 end
		move.orig = nil
	end
	return move.speed
end

function M.setRagdollFix(on)
	rag.on = on == true
	if rag.on then
		if not getgenv().__PF_RAG_CONN then
			getgenv().__PF_RAG_CONN = RunService.Heartbeat:Connect(function()
				if rag.on then fixRagdoll() end
			end)
		end
	elseif getgenv().__PF_RAG_CONN then
		pcall(function() getgenv().__PF_RAG_CONN:Disconnect() end)
		getgenv().__PF_RAG_CONN = nil
	end
	return rag.on
end

local function nearestEnemy(maxd)
	local _, _, hrp = char()
	if not hrp then return nil end
	local best, bd
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= plr and p.Character then
			local ph = p.Character:FindFirstChildOfClass("Humanoid")
			local pr = p.Character:FindFirstChild("HumanoidRootPart")
			if ph and pr and ph.Health > 0 then
				local d = (pr.Position - hrp.Position).Magnitude
				if d <= maxd and (not bd or d < bd) then
					best, bd = { plr = p, root = pr, hum = ph }, d
				end
			end
		end
	end
	return best, bd
end

local lastSwing, lastTargetHp = 0, nil

local function curPing()
	local ok, v = pcall(function()
		return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
	end)
	return ok and (tonumber(v) or 0) or 0
end

local function leadMs()
	if combat.autoLead then return math.clamp(combat.ping or 0, 0, 600) end
	return math.clamp(tonumber(combat.lead) or 0, 0, 600)
end

-- 预判：用目标水平速度 × 预判时长，算出「网络延迟后它会在哪」
local function predictPos(root)
	local pos = root.Position
	local v = root.AssemblyLinearVelocity
	local flat = Vector3.new(v.X, 0, v.Z)
	if flat.Magnitude > 300 then flat = flat.Unit * 300 end
	return pos + flat * (leadMs() / 1000)
end

-- ══ 寻路 / 探路：绝不往虚空里走 ══
local pfs = game:GetService("PathfindingService")
local walk = { wps = nil, i = 1, at = 0, goal = nil, state = "" }

local function groundBelowAt(pos, depth)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	local ch = plr.Character
	params.FilterDescendantsInstances = ch and { ch } or {}
	local hit = workspace:Raycast(pos + Vector3.new(0, 3, 0), Vector3.new(0, -(depth or 14), 0), params)
	if not hit then return nil end
	local nm = string.lower(hit.Instance.Name)
	if string.find(nm, "kill") or string.find(nm, "void") then return nil end
	return hit.Position
end

-- 探路：朝目标方向 ±80° 扫一圈，挑「落脚是实地、高度差不大、又离目标最近」的点
local function probeGround(hrp, targetPos)
	local flat = Vector3.new(targetPos.X - hrp.Position.X, 0, targetPos.Z - hrp.Position.Z)
	if flat.Magnitude < 0.5 then return nil end
	flat = flat.Unit
	local best, bestScore
	for _, ang in ipairs({ 0, 20, -20, 40, -40, 60, -60, 80, -80 }) do
		local dir = CFrame.Angles(0, math.rad(ang), 0) * flat
		local p = hrp.Position + dir * 8
		local g = groundBelowAt(p, 18)
		if g and math.abs(g.Y - hrp.Position.Y) <= 9 then
			local score = (g - targetPos).Magnitude + math.abs(ang) * 0.2
			if not bestScore or score < bestScore then best, bestScore = g, score end
		end
	end
	return best
end

-- 沿直线采样，确认一路都有实地（防止 MoveTo 直线穿过缺口）
local function pathClear(hrp, dest)
	local delta = dest - hrp.Position
	local n = math.clamp(math.ceil(delta.Magnitude / 4), 1, 8)
	for i = 1, n do
		if not groundBelowAt(hrp.Position + delta * (i / n), 10) then return false end
	end
	return true
end

local function walkTo(h, hrp, goal)
	if not walk.at or os.clock() - walk.at > 0.7 or not walk.goal or (goal - walk.goal).Magnitude > 6 then
		walk.at, walk.goal = os.clock(), goal
		local p = pfs:CreatePath({
			AgentRadius = 2,
			AgentHeight = 5,
			AgentCanJump = true,
			WaypointSpacing = 5,
		})
		local ok = pcall(function() p:ComputeAsync(hrp.Position, goal) end)
		if ok and p.Status == Enum.PathStatus.Success then
			walk.wps, walk.i, walk.state = p:GetWaypoints(), 2, "寻路"
		else
			walk.wps, walk.state = nil, "探路"
		end
	end
	local wp = walk.wps and walk.wps[walk.i]
	if wp then
		local flat = Vector3.new(wp.Position.X, hrp.Position.Y, wp.Position.Z)
		if (flat - hrp.Position).Magnitude < 3.5 then
			walk.i = walk.i + 1
			return true
		end
		-- 下一个航点脚下必须是实地，且直线过去不跨缺口，否则视为断头路
		if groundBelowAt(wp.Position, 12) and pathClear(hrp, wp.Position) then
			h:MoveTo(wp.Position)
			if wp.Action == Enum.PathWaypointAction.Jump then h.Jump = true end
			return true
		end
		walk.wps, walk.state = nil, "探路"
	end
	local p2 = probeGround(hrp, goal)
	if p2 and pathClear(hrp, p2) then
		h:MoveTo(p2)
		return true
	end
	walk.state = "无路"
	return false
end

-- 自动挥击：范围内有敌人就触发攻击，不移动 / 不转向 / 不选目标
if getgenv().__PF_SWING_CONN then pcall(function() getgenv().__PF_SWING_CONN:Disconnect() end) end
getgenv().__PF_SWING_CONN = RunService.Heartbeat:Connect(function()
	if not swing.on then return end
	local c, h, hrp = char()
	if not (c and h and hrp) or h.Health <= 0 then return end
	if os.clock() - swing.last < 1.02 then return end
	local near = false
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= plr then
			local pc = p.Character
			local ph = pc and pc:FindFirstChildOfClass("Humanoid")
			local pr = pc and pc:FindFirstChild("HumanoidRootPart")
			if ph and pr and ph.Health > 0 and (pr.Position - hrp.Position).Magnitude <= swing.range then
				near = true
				break
			end
		end
	end
	if not near then return end
	swing.last = os.clock()
	local ev = RE:FindFirstChild("CombatEvent")
	if ev then
		task.spawn(function() pcall(function() ev:FireServer() end) end)
		swing.n = swing.n + 1
	end
end)

local function combatTick()
	local c, h, hrp = char()
	if not (h and hrp) then return end
	if not combat.pingAt or os.clock() - combat.pingAt > 0.5 then
		combat.ping = math.floor(curPing() + 0.5)
		combat.pingAt = os.clock()
	end
	applyHitbox()
	-- 每帧重新选最近的敌人（不再死锁在第一个目标上）
	local tgt = nearestEnemy(300)
	if not tgt then
		combat.target, lastTargetHp = nil, nil
		walk.wps, walk.goal = nil, nil
		if h.WalkSpeed < 1 then h.WalkSpeed = 24 end
		h:MoveTo(hrp.Position)
		return
	end
	if not combat.target or combat.target.plr ~= tgt.plr then lastTargetHp = nil end
	combat.target = tgt
	local aim = predictPos(tgt.root)
	local dist = (aim - hrp.Position).Magnitude
	local range = tonumber(combat.range) or 12
	if dist > range then
		-- 还没进范围：寻路/探路过去（绝不直线冲进虚空）
		if dist > range + 1.5 then
			if h.WalkSpeed < 1 then h.WalkSpeed = 24 end
			-- 10Hz 决策就够，避免每帧大量射线
			if os.clock() - (walk.last or 0) > 0.1 then
				walk.last = os.clock()
				walkTo(h, hrp, aim)
			end
		else
			h:MoveTo(hrp.Position)
		end
	else
		-- 已进入指定范围：停下、面向预判点、直接触发攻击（不走模拟点击，不会误触其它按钮）
		h:MoveTo(hrp.Position)
		local flat = Vector3.new(aim.X, hrp.Position.Y, aim.Z)
		hrp.CFrame = CFrame.lookAt(hrp.Position, flat)
		if os.clock() - lastSwing > 1.02 then
			lastSwing = os.clock()
			local ev = RE:FindFirstChild("CombatEvent")
			if ev then
				combat.err = nil
				task.spawn(function()
					local ok, e = pcall(function() ev:FireServer() end)
					if not ok then combat.err = tostring(e) end
				end)
				combat.swings = combat.swings + 1
			else
				combat.err = "无 CombatEvent"
			end
		end
	end
	local hpNow = tgt.hum.Health
	if lastTargetHp and hpNow < lastTargetHp then combat.hits = combat.hits + 1 end
	lastTargetHp = hpNow
end

local compatLoop
function M.setCombat(on)
	combat.on = on == true
	combat.target, lastTargetHp = nil, nil
	walk.wps, walk.goal, walk.state = nil, nil, ""
	if combat.on then
		if not compatLoop then
			compatLoop = task.spawn(function()
				while getgenv().__PF_HOLD do
					task.wait(0.05)
					if combat.on then pcall(combatTick) end
				end
				compatLoop = nil
			end)
		end
	else
		local _, h, hrp = char()
		if h and hrp then h:MoveTo(hrp.Position) end
	end
	return combat.on
end

function M.setSwing(on)
	swing.on = on == true
	swing.last = 0
	return swing.on
end

function M.setSwingRange(v)
	swing.range = math.clamp(tonumber(v) or 8, 2, 60)
	return swing.range
end

function M.setHitboxRange(v)
	combat.hitbox = tonumber(v) or 0
	applyHitbox()
	return combat.hitbox
end

function M.setCombatRange(v)
	combat.range = math.clamp(tonumber(v) or 12, 3, 60)
	return combat.range
end

function M.setCombatLead(v)
	combat.lead = math.clamp(tonumber(v) or 0, 0, 600)
	return combat.lead
end

function M.setAutoLead(v)
	combat.autoLead = v == true
	return combat.autoLead
end


-- ══════════ ⑨ 自动开宝箱 ══════════
-- 宝箱 = Workspace.ChestsStuffFolder.ActiveMapChests 下的 MapLootChest_*
-- 交互 = 箱内 ProximityPrompt（距离上限 5 格、需视线），用 fireproximityprompt 直接触发
local chest = { on = false, mode = "teleport", opened = 0, state = "未开启", last = nil }
M.chest = chest

local function chestFolder()
	local cf = workspace:FindFirstChild("ChestsStuffFolder")
	return cf and cf:FindFirstChild("ActiveMapChests")
end

local function chestPrompt(model)
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("ProximityPrompt") then return d end
	end
	return nil
end

local function chestPart(model)
	return model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
end

local function nearestChest()
	local f = chestFolder()
	if not f then return nil end
	local _, _, hrp = char()
	if not hrp then return nil end
	local best, bd
	for _, m in ipairs(f:GetChildren()) do
		local p = chestPart(m)
		if p then
			local d = (p.Position - hrp.Position).Magnitude
			if not bd or d < bd then best, bd = m, d end
		end
	end
	return best, bd
end

local function openChest(model)
	local prompt = chestPrompt(model)
	if not prompt then return false, "箱子无交互点" end
	local ok = pcall(fireproximityprompt, prompt)
	task.wait(0.35)
	if model.Parent then
		pcall(function() prompt:InputHoldBegin() end)
		task.wait(0.1)
		pcall(function() prompt:InputHoldEnd() end)
		task.wait(0.5)
	end
	return not model.Parent and true or (ok and true or false), nil
end

local chestBusy = false
local function chestTick()
	if chestBusy then return end
	chestBusy = true
	local ok, err = pcall(function()
		local model, dist = nearestChest()
		if not model then
			chest.state = "等刷新"
			return
		end
		chest.state = string.format("宝箱 %d 格", math.floor(dist or 0))
		if dist <= 4.5 then
			local done, why = openChest(model)
			if done then
				if chest.last ~= model then
					chest.opened = chest.opened + 1
					chest.last = model
				end
				chest.state = "已开 " .. chest.opened
			else
				chest.state = "开箱失败" .. (why and ("：" .. why) or "")
			end
			return
		end
		local c, h, hrp = char()
		if not (h and hrp) then return end
		local part = chestPart(model)
		if chest.mode == "teleport" then
			local dst = part.Position + Vector3.new(0, 2.5, 2.5)
			hrp.CFrame = CFrame.new(dst)
			task.wait(0.25)
			local done = openChest(model)
			if done then
				if chest.last ~= model then
					chest.opened = chest.opened + 1
					chest.last = model
				end
				chest.state = "传送开箱 " .. chest.opened
			end
		else
			h:MoveTo(part.Position)
		end
	end)
	chestBusy = false
	if not ok then chest.state = "异常：" .. tostring(err) end
end

function M.setChest(on)
	chest.on = on == true
	if chest.on then
		if not getgenv().__PF_CHEST_LOOP then
			getgenv().__PF_CHEST_LOOP = task.spawn(function()
				while getgenv().__PF_HOLD do
					task.wait(0.6)
					if chest.on then chestTick() end
				end
				getgenv().__PF_CHEST_LOOP = nil
			end)
		end
	else
		chest.state = "已关闭"
	end
	return chest.on
end

function M.setChestMode(m)
	chest.mode = (m == "teleport") and "teleport" or "walk"
	return chest.mode
end

-- ══════════ 跳过开箱动画 ══════════
-- 开箱动画在 PlayerGui.OpeningLootGui.LootOpeningFrame（滚轮逐格展示），纯客户端演出。
-- 奖励由服务端在触发宝箱时已发放，所以直接隐藏动画不会丢奖励。
local loot = { on = false, skipped = 0, last = "" }

local function lootItems(frame)
	local roll = frame:FindFirstChild("CanvasGroupRoll")
	roll = roll and roll:FindFirstChild("RollFrame")
	local names = {}
	if roll then
		for _, c in ipairs(roll:GetChildren()) do
			if c:IsA("Frame") then
				local label
				for _, d in ipairs(c:GetDescendants()) do
					if d:IsA("TextLabel") and d.Text ~= "" then label = d.Text; break end
				end
				if not label then label = c.Name end
				names[#names + 1] = label
			end
		end
	end
	return names
end

local function skipLoot()
	local pg = plr.PlayerGui
	local g = pg:FindFirstChild("OpeningLootGui")
	if not g then return false end
	-- 真实路径：OpeningLootGui.PrincipalFrame.LootOpeningFrame（递归找，防止层级变动）
	local f = g:FindFirstChild("LootOpeningFrame", true)
	if not f then return false end
	if not (f.Visible or g.Enabled) then return false end
	loot.last = table.concat(lootItems(f), " / ")
	-- 停掉动画脚本，避免它继续改属性把我们刚设的 Visible 又拉回来
	for _, d in ipairs(f:GetDescendants()) do
		if d:IsA("LocalScript") or d:IsA("Script") then
			pcall(function() d.Disabled = true end)
		end
	end
	f.Visible = false
	g.Enabled = false
	loot.skipped = loot.skipped + 1
	local nf = getgenv().__PF_NOTIFY
	if nf then pcall(nf, "已跳过开箱动画：" .. (loot.last ~= "" and loot.last or "奖励已到账")) end
	return true
end

-- 光藏界面还不够：动画由 Shared.LootOpening 的 play() 驱动，
-- 内部固定 3 / 4.25 / 5.5 秒后才收发 LootOpeningDoneEvent，期间 isBusy 挡住下一次开箱。
-- 把 play() 换成瞬时版（隐藏界面 + 立刻发 Done），才是真正跳过；关闭时还原原函数。
local function patchLoot()
	local ok, mod = pcall(function() return require(RS.Shared:WaitForChild("LootOpening", 10)) end)
	if not ok or type(mod) ~= "table" or type(mod.play) ~= "function" then return false end
	if getgenv().__PF_LOOT_ORIG then return true end
	getgenv().__PF_LOOT_ORIG = mod.play
	getgenv().__PF_LOOT_MOD = mod
	local doneEv = RS.Events.RemoteEvents:FindFirstChild("LootOpeningDoneEvent")
	mod.play = function(name, payload)
		local pg = plr.PlayerGui
		local g = pg:FindFirstChild("OpeningLootGui")
		if g then
			local f = g:FindFirstChild("LootOpeningFrame", true)
			if f then f.Visible = false end
			g.Enabled = false
		end
		if doneEv then pcall(function() doneEv:FireServer(name, payload) end) end
		loot.skipped = loot.skipped + 1
		loot.last = tostring(name)
		return true
	end
	return true
end

local function unpatchLoot()
	local mod = getgenv().__PF_LOOT_MOD
	local orig = getgenv().__PF_LOOT_ORIG
	if mod and orig then pcall(function() mod.play = orig end) end
	getgenv().__PF_LOOT_MOD = nil
	getgenv().__PF_LOOT_ORIG = nil
end

function M.setSkipLoot(on)
	loot.on = on == true
	if loot.on then
		pcall(patchLoot)
		if not getgenv().__PF_LOOT_CONN then
			getgenv().__PF_LOOT_CONN = RunService.Heartbeat:Connect(function()
				if loot.on then pcall(skipLoot) end
			end)
		end
	else
		pcall(unpatchLoot)
		if getgenv().__PF_LOOT_CONN then
			pcall(function() getgenv().__PF_LOOT_CONN:Disconnect() end)
			getgenv().__PF_LOOT_CONN = nil
		end
	end
	return loot.on
end


-- ══════════ ⑩ 反虚空 ══════════
-- 落地时记录安全点；踩空（悬空且脚下 350 格内没有真地面）当帧拉回安全点，不等坠落。
-- 兜底：低于最近地面 200 格也立即拉回。虚空伤害是秒杀，必须抢在坠落之前。
local voidc = { on = false, back = 0, safe = nil, floorY = nil, msg = "" }
M.voidc = voidc

local VOID_FALL = 350  -- 脚下这么多格内没有地面 = 虚空（够长：正常跳台/下坡不会误判）
local VOID_DROP = 200  -- 低于最近地面这么多格 = 已坠入虚空（兜底）

function M.setAntiVoid(on)
	voidc.on = on == true
	if not voidc.on then
		if getgenv().__PF_VOID_CONN then
			pcall(function() getgenv().__PF_VOID_CONN:Disconnect() end)
			getgenv().__PF_VOID_CONN = nil
		end
		voidc.msg = "已关闭"
		return false
	end
	local _, _, hrp = char()
	voidc.msg = "守护中"
	if getgenv().__PF_VOID_CONN then return true end
	local function isKillPart(inst)
		if not inst then return false end
		local n = string.lower(inst.Name)
		return string.find(n, "kill") ~= nil or string.find(n, "void") ~= nil
			or string.find(n, "death") ~= nil or string.find(n, "lava") ~= nil
			or string.find(n, "damage") ~= nil
	end

	-- 向下找「真地面」：排除角色自己 + 穿透秒杀板
	local function groundBelow(startPos, dist)
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = { plr.Character }
		local traveled = 0
		while traveled < dist do
			local from = startPos - Vector3.new(0, traveled, 0)
			local r = workspace:Raycast(from, Vector3.new(0, -(dist - traveled), 0), params)
			if not r then return nil end
			if not isKillPart(r.Instance) then return r end
			traveled = (startPos.Y - r.Position.Y) + 2
		end
		return nil
	end

	-- 只有站在真地面上才建立安全点（悬浮/空中开启时不会记成半空，避免救人->再掉->再救死循环）
	local _, h0, hrp0 = char()
	if hrp0 and h0 and h0.FloorMaterial ~= Enum.Material.Air and groundBelow(hrp0.Position, 12) then
		voidc.safe = hrp0.Position
		voidc.floorY = hrp0.Position.Y
	end

	local function rescue(hrp)
		local target = voidc.safe
		if not target then return false end
		local ray = groundBelow(Vector3.new(target.X, target.Y + 30, target.Z), 300)
		if not ray then
			voidc.safe = nil
			return false
		end
		local pos = ray.Position + Vector3.new(0, 4, 0)
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.CFrame = CFrame.new(pos)
		pcall(function()
			local h = hrp.Parent:FindFirstChildOfClass("Humanoid")
			if h then
				h:ChangeState(Enum.HumanoidStateType.Landed)
				h:ChangeState(Enum.HumanoidStateType.Running)
			end
		end)
		voidc.t = os.clock()
		voidc.back = voidc.back + 1
		voidc.msg = "检测到掉入虚空，已自动回到地面(≧∇≦)ﾉ"
		local nf = getgenv().__PF_NOTIFY
		if nf then pcall(nf, voidc.msg) end
		return true
	end

	getgenv().__PF_VOID_CONN = RunService.Stepped:Connect(function()
		if not voidc.on then return end
		local c, h, hrp = char()
		if not (c and h and hrp) then return end
		if h.Health <= 0 then return end
		if voidc.t and os.clock() - voidc.t < 0.6 then return end
		local y = hrp.Position.Y
		local vy = hrp.AssemblyLinearVelocity.Y
		-- 只有「确实站在实地」才记录安全点（FloorMaterial 会滞后一帧，不能只信它）
		if h.FloorMaterial ~= Enum.Material.Air then
			if math.abs(vy) < 30 and groundBelow(hrp.Position, 12) then
				voidc.safe = hrp.Position
				if not voidc.floorY or hrp.Position.Y < voidc.floorY then voidc.floorY = hrp.Position.Y end
			end
			return
		end
		-- ① 踩空：正在下落，且脚下 40 格内没有真地面 → 当帧拉回
		if vy < -10 then
			if not groundBelow(hrp.Position, VOID_FALL) then
				if rescue(hrp) then return end
			end
		end
		-- ② 兜底：已经低于最近地面 200 格
		if voidc.floorY and y < voidc.floorY - VOID_DROP then
			rescue(hrp)
		end
	end)
	return true
end


-- ══════════ ⑪ 透视 ══════════
-- 头顶显示：名字 / 血量 / 当前能力 / 稀有度 / 获取概率（概率直接读游戏图鉴里的 Chance 文本）
local espc = { on = false, guis = {}, powers = nil, powersAt = 0 }
M.espc = espc

local RARITY_CN = {
	Basic = "基础", Rare = "稀有", Epic = "史诗",
	Legendary = "传说", Mythic = "神话", Godly = "神级",
}
local RARITY_COLOR = {
	Basic = Color3.fromRGB(205, 205, 205),
	Rare = Color3.fromRGB(95, 175, 255),
	Epic = Color3.fromRGB(190, 125, 255),
	Legendary = Color3.fromRGB(255, 195, 70),
	Mythic = Color3.fromRGB(255, 95, 95),
	Godly = Color3.fromRGB(120, 255, 205),
}

-- 从图鉴 UI 扫出 力量 -> {稀有度, 概率}
local function buildPowerTable()
	local gui = plr:FindFirstChild("PlayerGui")
	if not gui then return nil end
	local frame
	for _, d in ipairs(gui:GetDescendants()) do
		if d.Name == "IndexFrame" then frame = d break end
	end
	if not frame then return nil end
	local map, n = {}, 0
	for _, sc in ipairs(frame:GetDescendants()) do
		if sc:IsA("ScrollingFrame") then
			local rar = string.match(sc.Name, "^(%a+)PowersScroll$")
			if rar then
				for _, btn in ipairs(sc:GetChildren()) do
					if btn:IsA("TextButton") then
						local pn = btn:FindFirstChild("PowerName")
						local name = pn and pn.Text or string.match(btn.Name, "%)%s*(.+)$")
						if name and name ~= "" then
							local ch = btn:FindFirstChild("Chance") or btn:FindFirstChild("ChanceLocked")
							map[name] = { rarity = rar, chance = ch and ch.Text or "" }
							n = n + 1
						end
					end
				end
			end
		end
	end
	return n > 0 and map or nil
end

local function espMake(p)
	local c = p.Character
	if not c then return nil end
	local head = c:FindFirstChild("Head") or c:FindFirstChild("HumanoidRootPart")
	if not head then return nil end
	local old = espc.guis[p]
	if old then pcall(function() old:Destroy() end) end

	local bb = Instance.new("BillboardGui")
	bb.Name = "__PF_ESP"
	bb.Adornee = head
	bb.Size = UDim2.new(0, 230, 0, 74)
	bb.StudsOffset = Vector3.new(0, 2.4, 0)
	bb.AlwaysOnTop = true
	bb.MaxDistance = 2500
	bb.Parent = head

	local function label(y, h, size, color)
		local l = Instance.new("TextLabel")
		l.BackgroundTransparency = 1
		l.Font = Enum.Font.GothamBold
		l.TextColor3 = color
		l.TextStrokeTransparency = 0.35
		l.TextWrapped = true
		l:SetAttribute("BaseY", y)
		l:SetAttribute("BaseH", h)
		l:SetAttribute("BaseSize", size)
		l.Parent = bb
		return l
	end
	label(0, 16, 13, Color3.fromRGB(255, 255, 255)).Name = "NameLbl"
	label(16, 15, 12, Color3.fromRGB(120, 255, 140)).Name = "HpLbl"
	label(31, 30, 12, Color3.fromRGB(200, 200, 200)).Name = "PowerLbl"

	local bg = Instance.new("Frame")
	bg.Name = "BarBg"
	bg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	bg.BackgroundTransparency = 0.35
	bg.BorderSizePixel = 0
	bg:SetAttribute("BaseY", 65)
	bg:SetAttribute("BaseH", 5)
	bg.Parent = bb

	local fill = Instance.new("Frame")
	fill.Name = "BarFill"
	fill.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
	fill.BorderSizePixel = 0
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.Parent = bg

	espc.guis[p] = bb
	espc.styleKey = nil
	return bb
end

-- 按 CFG.espScale / CFG.espAlpha 统一刷新字号与透明度
local function styleSig()
	return string.format("%d|%.2f", tonumber(CFG.espScale) or 100, tonumber(CFG.espAlpha) or 0)
end

local function espStyle()
	local sc = (tonumber(CFG.espScale) or 100) / 100
	local al = math.clamp(tonumber(CFG.espAlpha) or 0, 0, 0.9)
	for _, bb in pairs(espc.guis) do
		if bb and bb.Parent then
			bb.Size = UDim2.new(0, math.max(120, math.floor(230 * sc)), 0, math.max(40, math.floor(74 * sc)))
			for _, d in ipairs(bb:GetChildren()) do
				local by = d:GetAttribute("BaseY")
				local bh = d:GetAttribute("BaseH")
				if by and bh then
					local isBar = d.Name == "BarBg"
					d.Position = UDim2.new(isBar and 0.05 or 0, 0, 0, math.floor(by * sc))
					d.Size = UDim2.new(isBar and 0.9 or 1, 0, 0, math.max(isBar and 3 or 8, math.floor(bh * sc)))
				end
				if d:IsA("TextLabel") then
					local bs = d:GetAttribute("BaseSize")
					if bs then d.TextSize = math.max(8, math.floor(bs * sc)) end
					d.TextTransparency = al
					d.TextStrokeTransparency = math.clamp(al + 0.2, 0, 1)
				end
			end
		end
	end
	espc.styleKey = styleSig()
end

local function espTick()
	if not espc.on then return end
	if not espc.powers or os.clock() - espc.powersAt > 10 then
		local m = buildPowerTable()
		if m then espc.powers = m end
		espc.powersAt = os.clock()
	end
	local map = espc.powers or {}
	for _, p in ipairs(Players:GetPlayers()) do
		local bb = espc.guis[p]
		if not (bb and bb.Parent) then
			bb = espMake(p)
		end
		local c = p.Character
		local h = c and c:FindFirstChildOfClass("Humanoid")
		if bb and h then
			local hp = math.max(0, math.floor(h.Health + 0.5))
			local mhp = math.max(1, math.floor(h.MaxHealth + 0.5))
			local ratio = math.clamp(hp / mhp, 0, 1)
			local hpCol = ratio > 0.6 and Color3.fromRGB(110, 255, 130)
				or (ratio > 0.3 and Color3.fromRGB(255, 220, 90) or Color3.fromRGB(255, 90, 90))
			local cp = c:FindFirstChild("CurrentPower")
			local pname = cp and tostring(cp.Value) or "?"
			local info = map[pname]
			local rar = info and info.rarity or nil
			local rc = rar and RARITY_COLOR[rar] or Color3.fromRGB(190, 190, 190)
			local nl = bb:FindFirstChild("NameLbl")
			local hl = bb:FindFirstChild("HpLbl")
			local pl2 = bb:FindFirstChild("PowerLbl")
			local bar = bb:FindFirstChild("BarBg")
			local fill = bar and bar:FindFirstChild("BarFill")
			if nl then
				nl.Text = p.DisplayName .. (p == plr and "（你）" or "")
				nl.TextColor3 = p == plr and Color3.fromRGB(150, 220, 255) or Color3.fromRGB(255, 255, 255)
			end
			if hl then
				hl.Text = string.format("HP %d/%d", hp, mhp)
				hl.TextColor3 = hpCol
			end
			if pl2 then
				if info then
					pl2.Text = string.format("%s · %s · %s", pname,
						RARITY_CN[rar] or rar, info.chance)
				else
					pl2.Text = pname
				end
				pl2.TextColor3 = rc
			end
			if bar then bar.Visible = true end
			if fill then
				fill.Size = UDim2.new(ratio, 0, 1, 0)
				fill.BackgroundColor3 = hpCol
			end
		end
	end
	for p, bb in pairs(espc.guis) do
		if not bb.Parent or not p.Parent then
			pcall(function() bb:Destroy() end)
			espc.guis[p] = nil
		end
	end
	if espc.styleKey ~= styleSig() then espStyle() end
end

function M.setESP(on)
	espc.on = on == true
	if not espc.on then
		if getgenv().__PF_ESP_CONN then
			pcall(function() getgenv().__PF_ESP_CONN:Disconnect() end)
			getgenv().__PF_ESP_CONN = nil
		end
		for _, bb in pairs(espc.guis) do pcall(function() bb:Destroy() end) end
		espc.guis = {}
		return false
	end
	if getgenv().__PF_ESP_CONN then return true end
	getgenv().__PF_ESP_CONN = RunService.Heartbeat:Connect(espTick)
	return true
end

-- ══════════ Obsidian UI ══════════
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local okLib, Library = pcall(function()
	return loadstring(game:HttpGet(repo .. "Library.lua"))()
end)
if not okLib or type(Library) ~= "table" then
	warn("[辅助] Obsidian 加载失败:", Library)
	return
end
getgenv().__PF_LIB = Library
local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({
	Title = "力量辅助",
	Footer = "v3",
	Center = true,
	AutoShow = true,
	Resizable = true,
	NotifySide = "Right",
	ShowCustomCursor = false,
})

local TabHome = Window:AddTab("主页", "house")
local TabFight = Window:AddTab("战斗", "crosshair")
local TabEye = Window:AddTab("透视", "eye")
local TabSafe = Window:AddTab("防护", "shield")
local TabMove = Window:AddTab("移动", "wind")
local TabFarm = Window:AddTab("农场", "coins")
local TabPot = Window:AddTab("药水", "flask-conical")
local TabFun = Window:AddTab("趣味", "gamepad")

local function notify(msg)
	pcall(function() Library:Notify(tostring(msg), 2) end)
end
getgenv().__PF_NOTIFY = notify

local function confirm(title, desc, onYes)
	local ok = pcall(function()
		Window:AddDialog("pf_dlg_" .. tostring(os.clock()), {
			Title = title,
			Description = desc,
			FooterButtons = {
				{ Title = "确认", Variant = "Primary", Callback = function() task.spawn(onYes) end },
				{ Title = "取消", Variant = "Secondary" },
			},
		})
	end)
	if not ok then notify("确认框失败，请开「免确认」") end
end

-- ───── 主页 ─────
local GCode = TabHome:AddLeftGroupbox("兑换 / 抽卡")
local GSkill = TabHome:AddRightGroupbox("技能点")
local GFloat = TabMove:AddLeftGroupbox("悬浮 / 挂机")
local GAcc = TabMove:AddRightGroupbox("加速")
local GRew = TabFun:AddLeftGroupbox("奖励")
local GFps = TabFun:AddRightGroupbox("FPS")
local GAfk = TabSafe:AddRightGroupbox("防挂机")

local lblCode = GCode:AddLabel("-", true)
local lblRoll = GCode:AddLabel("-", true)
local lblSkill = GSkill:AddLabel("-", true)
local lblFloat = GFloat:AddLabel("-", true)
local lblRew = GRew:AddLabel("-", true)
local lblAfk = GAfk:AddLabel("-", true)
local lblFps = GFps:AddLabel("-", true)

local function setLbl(l, t) pcall(function() l:SetText(tostring(t)) end) end

local busy = false

local function refreshCode()
	setLbl(lblCode, M.inGroup() and "已加群" or "未加群")
end

GCode:AddButton({
	Text = "加群 / 兑换",
	Func = function()
		if busy then return end
		if not M.inGroup() then
			local _, msg = M.joinGroup()
			setLbl(lblCode, msg)
			task.delay(3, refreshCode)
			return
		end
		busy = true
		setLbl(lblCode, "兑换中…")
		task.spawn(function()
			local ok, a, msg = pcall(M.redeemCodes)
			setLbl(lblCode, ok and (msg or "完成") or ("失败：" .. tostring(a)))
			busy = false
			task.delay(2, refreshCode)
		end)
	end,
})

GCode:AddToggle("AutoRoll", {
	Text = "自动抽卡",
	Default = false,
	Callback = function(v)
		if v then
			M.startRoll()
			setLbl(lblRoll, "抽卡中…")
		else
			M.stopRoll()
			setLbl(lblRoll, string.format("已停 · %d 次 · %s", rollStats.n, rollStats.last))
		end
	end,
})

GCode:AddToggle("AutoClaim", {
	Text = "自动领奖",
	Default = CFG.autoClaim == true,
	Callback = function(v)
		CFG.autoClaim = v
		if v then
			task.spawn(function()
				local _, msg = M.claimAll()
				setLbl(lblRoll, msg)
			end)
		end
	end,
})

local function refreshSkill()
	if not okTree then setLbl(lblSkill, "无技能配置") return end
	local list, total, coins = M.scanSkills()
	if total == 0 then
		setLbl(lblSkill, string.format("金币 %s · 暂无可买", fmt(coins)))
	else
		setLbl(lblSkill, string.format("金币 %s · 可买 %d\n%s", fmt(coins), total, list[1] or "-"))
	end
end

local function runBuy()
	busy = true
	setLbl(lblSkill, "购买中…")
	task.spawn(function()
		local bought, fail = M.buyBatch(6)
		setLbl(lblSkill, bought == 0 and "买了 0 个（条件不符）" or string.format("已买 %d · 失败 %d", bought, fail))
		busy = false
		task.delay(1.2, refreshSkill)
	end)
end

GSkill:AddButton({
	Text = "扫描",
	Func = function()
		setLbl(lblSkill, "扫描中…")
		task.spawn(function() task.wait(0.05) refreshSkill() end)
	end,
})

GSkill:AddButton({
	Text = "购买",
	Func = function()
		if busy then return end
		local list, total = M.scanSkills()
		if total == 0 then setLbl(lblSkill, "暂无可买") return end
		if CFG.autoAllow then
			runBuy()
		else
			local sample = {}
			for i = 1, math.min(#list, 4) do sample[i] = list[i] end
			confirm("购买技能点？", table.concat(sample, "  "), runBuy)
		end
	end,
})

GSkill:AddToggle("SkillNoConfirm", {
	Text = "免确认",
	Default = CFG.autoAllow == true,
	Callback = function(v) CFG.autoAllow = v end,
})

GFloat:AddButton({
	Text = "悬浮",
	Func = function()
		local _, msg = M.floatUp(800)
		setLbl(lblFloat, msg)
	end,
})
GFloat:AddButton({
	Text = "落地",
	Func = function()
		local _, msg = M.floatDown()
		setLbl(lblFloat, msg)
	end,
})
GFloat:AddToggle("AutoFloat", {
	Text = "自动悬浮（有人近/掉血）",
	Default = CFG.autoAfk == true,
	Callback = function(v)
		CFG.autoAfk = v
		-- 关掉自动悬浮 = 立刻收回平台并送回地面（否则会挂在半空，被反虚空反复判定）
		if not v then
			local ok, msg = M.floatDown()
			setLbl(lblFloat, "关闭自动悬浮：" .. tostring(msg))
		end
	end,
})

GRew:AddButton({
	Text = "领图鉴",
	Func = function()
		setLbl(lblRew, "领取中…")
		task.spawn(function()
			local _, msg = M.claimIndex()
			setLbl(lblRew, msg)
		end)
	end,
})
GRew:AddButton({
	Text = "领徽章",
	Func = function()
		setLbl(lblRew, "领取中…")
		task.spawn(function()
			local _, msg = M.claimBadges()
			setLbl(lblRew, msg)
		end)
	end,
})
GRew:AddToggle("AutoRewards", {
	Text = "自动领取",
	Default = CFG.autoRewards == true,
	Callback = function(v) CFG.autoRewards = v end,
})

GAfk:AddToggle("AntiAfk", {
	Text = "防挂机",
	Default = CFG.antiAfk == true,
	Callback = function(v) CFG.antiAfk = v end,
})

GFps:AddToggle("FxOff", {
	Text = "关特效",
	Default = getgenv().__PF_FPS == true,
	Callback = function(v)
		local on = getgenv().__PF_FPS == true
		if v ~= on then
			local _, msg = M.fxToggle()
			notify(msg)
		end
	end,
})


local GFight = TabFight:AddLeftGroupbox("攻击")
local GProt = TabSafe:AddLeftGroupbox("防护")
local GEsp = TabEye:AddLeftGroupbox("透视显示")
local lbFight = GFight:AddLabel("未开启", true)
local lbMove = GProt:AddLabel("-", true)
local lbEsp = GEsp:AddLabel("血量 / 能力 / 获取概率", true)

GFight:AddToggle("AutoAttack", {
	Text = "自动攻击（直接触发，不模拟点击）",
	Default = false,
	Callback = function(v) M.setCombat(v) end,
})

GFight:AddSlider("AtkRange", {
	Text = "攻击范围（敌人进入即攻击）",
	Min = 3,
	Max = 60,
	Default = tonumber(combat.range) or 12,
	Rounding = 0,
	Suffix = " 格",
	Callback = function(v) M.setCombatRange(v) end,
})

GFight:AddToggle("AutoLead", {
	Text = "自动预判（跟随当前延迟）",
	Default = true,
	Callback = function(v) M.setAutoLead(v) end,
})

GFight:AddSlider("AtkLead", {
	Text = "手动预判提前量",
	Min = 0,
	Max = 600,
	Default = tonumber(combat.lead) or 200,
	Rounding = 0,
	Suffix = " ms",
	Callback = function(v) M.setCombatLead(v) end,
})

GFight:AddToggle("AutoSwing", {
	Text = "自动挥击（范围内有敌人就触发，不移动）",
	Default = false,
	Callback = function(v) M.setSwing(v) end,
})

GFight:AddSlider("SwingRange", {
	Text = "挥击触发范围",
	Min = 2,
	Max = 40,
	Default = 8,
	Rounding = 0,
	Suffix = " 格",
	Callback = function(v) M.setSwingRange(v) end,
})

GFight:AddDropdown("HitboxRange", {
	Text = "判定框大小",
	Default = "默认",
	Values = { ["默认"] = 0, ["8 格"] = 8, ["12 格"] = 12, ["18 格"] = 18 },
	Callback = function(v) M.setHitboxRange(v) end,
})

GEsp:AddToggle("ESP", {
	Text = "开启透视",
	Default = false,
	Callback = function(v)
		M.setESP(v)
		setLbl(lbEsp, v and "血量 / 能力 / 获取概率" or "已关闭")
	end,
})

GEsp:AddSlider("EspSize", {
	Text = "字体大小",
	Min = 50,
	Max = 250,
	Default = tonumber(CFG.espScale) or 100,
	Rounding = 0,
	Suffix = "%",
	Callback = function(v) CFG.espScale = v end,
})

GEsp:AddSlider("EspAlpha", {
	Text = "字体透明度",
	Min = 0,
	Max = 90,
	Default = math.floor((tonumber(CFG.espAlpha) or 0.15) * 100),
	Rounding = 0,
	Suffix = "%",
	Callback = function(v) CFG.espAlpha = v / 100 end,
})

GProt:AddToggle("RagdollFix", {
	Text = "防布娃娃",
	Default = false,
	Callback = function(v) M.setRagdollFix(v) end,
})

GProt:AddToggle("AntiVoid", {
	Text = "反虚空（掉落自动回地面）",
	Default = false,
	Callback = function(v) M.setAntiVoid(v) end,
})

GAcc:AddSlider("SpeedVal", {
	Text = "加速（无惯性）",
	Min = 0,
	Max = 200,
	Default = 0,
	Rounding = 0,
	Suffix = " 格/秒",
	Callback = function(v) M.setSpeed(v) end,
})


local GChest = TabFarm:AddLeftGroupbox("自动开宝箱")
local lbChest = GChest:AddLabel("未开启", true)

GChest:AddToggle("AutoChest", {
	Text = "自动开宝箱",
	Default = false,
	Callback = function(v) M.setChest(v) end,
})

GChest:AddDropdown("ChestMode", {
	Text = "靠近方式",
	Default = "直接传送",
	Values = { ["直接传送"] = "teleport", ["走过去"] = "walk" },
	Callback = function(v) M.setChestMode(v) end,
})

GChest:AddToggle("SkipLoot", {
	Text = "跳过开箱动画（奖励照常到账）",
	Default = false,
	Callback = function(v) M.setSkipLoot(v) end,
})

-- ───── 药水 ─────
local GPotSel = TabPot:AddLeftGroupbox("药水")
local GPotAuto = TabPot:AddRightGroupbox("自动")
local lblPot = GPotSel:AddLabel("先在游戏里打开一次药水店", true)
local lblPotInfo = GPotAuto:AddLabel("-", true)

local potValues = {}
for name in pairs(POTION_CURRENCY) do potValues[name] = disp(name) end

local function syncSel()
	local ok, opt = pcall(function() return Options.PotionSel end)
	if not (ok and opt and type(opt.Value) == "table") then return end
	local set = {}
	for k, v in pairs(opt.Value) do
		if v then set[k] = true end
	end
	CFG.potionSel = set
end

local function allQty(n)
	n = math.clamp(math.floor(tonumber(n) or 1), 1, 99)
	for name in pairs(POTION_CURRENCY) do CFG.qty[name] = n end
	return n
end
if not next(CFG.qty) then allQty(1) end

GPotSel:AddDropdown("PotionSel", {
	Text = "选择药水",
	Values = potValues,
	Multi = true,
	Callback = function() syncSel() end,
})

GPotSel:AddInput("PotionQty", {
	Text = "数量",
	Default = tostring(CFG.qty["Lucky Potion"] or 1),
	Numeric = true,
	Finished = true,
	ClearTextOnFocus = false,
	Callback = function(v) allQty(v) end,
})

local function selectedCostText()
	local sum = { Coins = 0, Diamonds = 0, CandyCorns = 0 }
	for _, p in ipairs(M.potionList()) do
		if CFG.potionSel[p.name] then
			sum[p.currency] = (sum[p.currency] or 0) + p.price * (tonumber(CFG.qty[p.name]) or 1)
		end
	end
	local parts = {}
	for _, cur in ipairs({ "Coins", "Diamonds", "CandyCorns" }) do
		if sum[cur] > 0 then parts[#parts + 1] = fmt(sum[cur]) .. " " .. (CUR_LABEL[cur] or cur) end
	end
	return #parts > 0 and table.concat(parts, " + ") or "0"
end

local function doBuySelected()
	setLbl(lblPot, "购买中…")
	local n, msg = M.buySelected()
	setLbl(lblPot, n > 0 and string.format("已买 %d 种", n) or msg)
end

GPotSel:AddButton({
	Text = "购买选中",
	Func = function()
		syncSel()
		if CFG.confirmed then
			task.spawn(doBuySelected)
		else
			confirm("确认购买", "花费 " .. selectedCostText(), function()
				CFG.confirmed = true
				doBuySelected()
			end)
		end
	end,
})

GPotSel:AddButton({
	Text = "喝选中",
	Func = function()
		syncSel()
		task.spawn(function()
			setLbl(lblPot, "喝药水中…")
			local n, msg = M.useSelected()
			setLbl(lblPot, n > 0 and string.format("已喝 %d 瓶", n) or msg)
		end)
	end,
})

GPotAuto:AddToggle("TimedBuy", {
	Text = "定时买",
	Default = CFG.timed == true,
	Callback = function(v)
		CFG.timed = v
		if v then syncSel() end
		setLbl(lblPotInfo, v and ("每 " .. M.intervalDesc() .. " 买一次，首次购买后计时") or "定时买已关")
	end,
})

local function ivInput(idx, text, key, maxv)
	GPotAuto:AddInput(idx, {
		Text = text,
		Default = tostring(CFG[key]),
		Numeric = true,
		Finished = true,
		ClearTextOnFocus = false,
		Callback = function(v)
			CFG[key] = math.clamp(math.floor(tonumber(v) or 0), 0, maxv)
		end,
	})
end
ivInput("IvH", "间隔·时", "ivH", 99)
ivInput("IvM", "间隔·分", "ivM", 99)
ivInput("IvS", "间隔·秒", "ivS", 99)

GPotAuto:AddToggle("AutoDrink", {
	Text = "自动喝",
	Default = CFG.autoDrink == true,
	Callback = function(v)
		CFG.autoDrink = v
		if v then syncSel() end
	end,
})

local function potionInfoText()
	local cur = data("Currency") or {}
	local lim = effectSlotLimit()
	local lines = {
		string.format("金币 %s · 钻石 %s · 效果 %d%s", fmt(cur.Coins), fmt(cur.Diamonds), M.effectCount(), lim and ("/" .. lim) or ""),
	}
	local list = M.potionList()
	for _, p in ipairs(list) do
		local line = string.format("%s %d%s 有%d", disp(p.name), p.price, CUR_LABEL[p.currency] or "", p.owned)
		local nxt = CFG.nextAt[p.name]
		if CFG.timed and CFG.potionSel[p.name] and nxt then
			line = line .. " · 下次 " .. hms(nxt - os.clock())
		end
		lines[#lines + 1] = line
	end
	if #list == 0 then lines[#lines + 1] = "先在游戏里打开药水店" end
	return table.concat(lines, "\n")
end

-- ───── 自动刷 ─────
local GFarm = TabFarm:AddLeftGroupbox("自动刷")
local GFarmInfo = TabFarm:AddRightGroupbox("状态")
local lblFarm = GFarmInfo:AddLabel("未运行", true)

local FARM_DEF = {
	coins = { name = "金币", cur = "Coins" },
	diamonds = { name = "钻石", gadget = "Billionaire", cur = "Diamonds" },
}

-- 手套不固定：按 RollCDAddition（越小越快）从已拥有的里挑最快，同速比金币加成
local function bestGlove()
	local inv = (data("Inventory") or {}).Gloves or {}
	local root = RS:FindFirstChild("Gloves")
	if not root then return "Surge" end
	local best, bestCd, bestCoin
	for _, folder in ipairs(root:GetChildren()) do
		if folder:IsA("Folder") then
			for _, g in ipairs(folder:GetChildren()) do
				if (tonumber(inv[g.Name]) or 0) > 0 then
					local st = g:FindFirstChild("Stats")
					local cdv = st and st:FindFirstChild("RollCDAddition")
					local cnv = st and st:FindFirstChild("CoinMultiAddition")
					local cd = cdv and tonumber(cdv.Value) or 0
					local cn = cnv and tonumber(cnv.Value) or 0
					if not bestCd or cd < bestCd or (cd == bestCd and cn > (bestCoin or 0)) then
						best, bestCd, bestCoin = g.Name, cd, cn
					end
				end
			end
		end
	end
	return best or "Surge"
end

local function farmEquipped(model)
	local ch = plr.Character
	return ch ~= nil and ch:FindFirstChild(model) ~= nil
end

local function farmEquip(eventName, model)
	local ev = RE:FindFirstChild(eventName)
	if not ev then return false end
	pcall(function() ev:FireServer(model) end)
	return true
end

local hudLabel, hudButton
local stopFarm

local function destroyHud()
	if hudLabel then pcall(function() hudLabel:Destroy() end) hudLabel = nil end
	if hudButton then pcall(function() hudButton:Destroy() end) hudButton = nil end
	getgenv().__PF_FARM_HUD = nil
end

stopFarm = function()
	local st = getgenv().__PF_FARM
	destroyHud()
	if not st then return end
	getgenv().__PF_FARM = nil
	M.stopRoll()
	CFG.timed = false
	CFG.autoDrink = false
	pcall(function() Toggles.TimedBuy:SetValue(false) end)
	pcall(function() Toggles.AutoDrink:SetValue(false) end)
	pcall(function() Library:Toggle(true) end)
	setLbl(lblFarm, "已停止")
end

local function farmTick(st)
	local def = FARM_DEF[st.mode]
	if M.clearAnim() then st.anim = (st.anim or 0) + 1 end
	st.glove = st.glove or bestGlove()
	if not farmEquipped(st.glove) then
		if farmEquip("GloveEquipEvent", st.glove) then st.status = "装备 " .. st.glove end
	else
		st.status = "手套 " .. st.glove
	end

	-- 小工具不固定：钻石模式挂亿万富翁，金币模式只确保不带亿万富翁
	local gad = st.gadget
	if gad and gad ~= "" then
		if not farmEquipped(gad) then
			farmEquip("GadgetEquipEvent", gad)
			st.status = "装备 " .. gad
		else
			st.status = st.status .. " · " .. gad
		end
	elseif farmEquipped("Billionaire") then
		farmEquip("GadgetEquipEvent", "")
		st.status = "卸下亿万富翁"
	end

	if not M.padAlive() then
		local ok = M.floatUp(800)
		if ok then st.status = "悬浮中" end
	end

	local th = getgenv().__PF_ROLL
	if not getgenv().__PF_ROLL_ON or not th or coroutine.status(th) == "dead" then
		getgenv().__PF_ROLL_ON = nil
		if M.startRoll() then st.status = "抽卡中" end
	end

	for _, nm in ipairs({ "Speedy Potion", "Haste Potion" }) do
		if getgenv().__PF_FARM ~= st then return end
		if not M.effectActive(nm) then
			st.potWait = st.potWait or {}
			local now = os.clock()
			if now >= (st.potWait[nm] or 0) then
				st.potWait[nm] = now + 6
				local inv = (data("Inventory") or {}).Potions or {}
				if (tonumber(inv[nm]) or 0) < 1 then
					if M.buyPotion(nm, 1) then st.bought = st.bought + 1 end
					task.wait(0.25)
				end
				if M.usePotion(nm) then st.drunk = st.drunk + 1 end
			end
		end
	end

	local elapsed = os.clock() - st.t0
	local cur = tonumber((data("Currency") or {})[def.cur]) or 0
	local text = string.format(
		"刷%s %s\n抽 %d · +%s\n药水 买%d 喝%d\n%s · %s",
		def.name, hms(elapsed), rollStats.n - st.baseRolls, fmt(math.max(0, cur - st.base)),
		st.bought, st.drunk,
		M.effectActive("Speedy Potion") and "加速✓" or "加速×",
		M.effectActive("Haste Potion") and "急速✓" or "急速×"
	)
	if hudLabel then pcall(function() hudLabel:SetText(text) end) end
	setLbl(lblFarm, text .. "\n" .. (st.status or ""))
end

local function startFarm(mode)
	local def = FARM_DEF[mode]
	if not def then return end
	if getgenv().__PF_FARM then stopFarm() end
	CFG.timed = false
	CFG.autoDrink = false
	pcall(function() Toggles.TimedBuy:SetValue(false) end)
	pcall(function() Toggles.AutoDrink:SetValue(false) end)

	local st = {
		mode = mode,
		glove = bestGlove(),
		gadget = (mode == "diamonds") and def.gadget or nil,
		t0 = os.clock(),
		base = tonumber((data("Currency") or {})[def.cur]) or 0,
		baseRolls = rollStats.n,
		bought = 0,
		drunk = 0,
		status = "启动中…",
	}
	getgenv().__PF_FARM = st

	pcall(function() hudLabel = Library:AddDraggableLabel("刷" .. def.name .. "…") end)
	pcall(function() hudButton = Library:AddDraggableButton({ Text = "停止刷", Func = function() stopFarm() end }) end)
	getgenv().__PF_FARM_HUD = { Destroy = destroyHud }
	pcall(function() Library:Toggle(false) end)

	task.spawn(function()
		while getgenv().__PF_FARM == st and not Library.Unloaded do
			pcall(farmTick, st)
			task.wait(1)
		end
	end)
end

GFarm:AddButton({ Text = "刷金币", Func = function() startFarm("coins") end })
GFarm:AddButton({ Text = "刷钻石", Func = function() startFarm("diamonds") end })
GFarm:AddButton({ Text = "停止", Func = function() stopFarm() end })
GFarm:AddLabel("手套：自动选转得最快的（已拥有）\n金币：不挂亿万富翁 · 钻石：自动挂亿万富翁", true)

refreshCode()
pcall(refreshSkill)

Library:OnUnload(function()
	pcall(stopFarm)
	M.stopRoll()
	pcall(M.floatDown)
	pcall(M.setCombat, false)
	pcall(M.setRagdollFix, false)
	pcall(M.setSpeed, 0)
	pcall(M.restoreHitbox)
	pcall(M.setChest, false)
	pcall(M.setAntiVoid, false)
	if getgenv().__PF_AFK_CONN then pcall(function() getgenv().__PF_AFK_CONN:Disconnect() end) getgenv().__PF_AFK_CONN = nil end
	if getgenv().__PF_FPS_CONN_MAIN then pcall(function() getgenv().__PF_FPS_CONN_MAIN:Disconnect() end) getgenv().__PF_FPS_CONN_MAIN = nil end
	getgenv().__PF_HOLD = nil
	getgenv().__PF_LIB = nil
	getgenv().__PF_PANEL = nil
end)
getgenv().__PF_PANEL = Library.ScreenGui
getgenv().__PF_HOLD = true

-- ══════════ 主循环 ══════════
getgenv().__PF_LOOP = task.spawn(function()
	local lastHp, lastClaim = nil, 0
	local lastRoll, lastRewards = 0, -60
	local lastDrink = 0
	while not Library.Unloaded do
		task.wait(1)
		local _, hum, hrp = char()
		local hp = hum and math.floor(hum.Health) or 0

		-- 悬浮平台跟随；被传送则放弃平台
		if M.padAlive() and hrp then
			local pad = workspace:FindFirstChild(PAD_NAME)
			if pad then
				local d = (hrp.Position - pad.Position).Magnitude
				if d > 60 then
					pad:Destroy()
					setLbl(lblFloat, "被传送，已收起平台")
				elseif d > 8 then
					hrp.CFrame = CFrame.new(pad.Position + Vector3.new(0, 4, 0))
				end
			end
		end

		if getgenv().__PF_ROLL_ON and os.clock() - lastRoll > 0.8 then
			lastRoll = os.clock()
			local c = char()
			local cp = c and c:FindFirstChild("CurrentPower")
			if cp then rollStats.last = tostring(cp.Value) end
			setLbl(lblRoll, string.format("抽卡中 · %d 次 · %s", rollStats.n, rollStats.last))
		end

		local frames = getgenv().__PF_FRAMES or 0
		getgenv().__PF_FRAMES = 0
		setLbl(lblFps, string.format("FPS %d · %s", frames, getgenv().__PF_FPS and ("特效已关 " .. tostring(getgenv().__PF_FX_N)) or "特效正常"))
		setLbl(lblAfk, string.format("%s · 拦截 %d · %s", hms(os.clock() - afk.t0), afk.kicks, CFG.antiAfk and "开" or "关"))
		setLbl(lbFight, (combat.on and string.format("范围 %d · 预判 %dms%s · 延迟 %dms · %s · 挥 %d · 中 %d · %s%s",
			combat.range, math.floor(leadMs()), combat.autoLead and "(自动)" or "", combat.ping or 0,
			walk.state ~= "" and walk.state or "待机", combat.swings, combat.hits,
			combat.target and ("目标 " .. tostring(combat.target.plr.Name)) or "搜索中",
			combat.err and (" · " .. combat.err) or "") or "自动攻击未开启")
			.. (swing.on and string.format(" · 自动挥击 %d 格 · 已触发 %d", swing.range, swing.n) or ""))
		setLbl(lbChest, string.format("%s · 已开 %d · 跳过动画 %d", chest.state, chest.opened, loot.skipped))
		setLbl(lbMove, string.format("解除 %d · 速度 %d\n反虚空 %s · 救回 %d", rag.fixed, move.speed, voidc.on and voidc.msg or "关", voidc.back))

		if CFG.autoClaim and os.clock() - lastClaim > 90 then
			lastClaim = os.clock()
			pcall(function() RE:FindFirstChild("ClaimDailyReward"):FireServer() end)
		end

		if CFG.autoRewards and os.clock() - lastRewards > 60 then
			lastRewards = os.clock()
			task.spawn(function()
				local ni, mi = M.claimIndex()
				local nb, mb = M.claimBadges()
				if ni or nb then setLbl(lblRew, tostring(mi) .. " · " .. tostring(mb)) end
			end)
		end

		-- 定时购买
		if CFG.timed and not M._buyBusy then
			local iv = M.intervalSeconds()
			for _, p in ipairs(M.potionList()) do
				if CFG.potionSel[p.name] then
					local nxt = CFG.nextAt[p.name]
					if nxt and os.clock() >= nxt then
						local qty = math.clamp(math.floor(tonumber(CFG.qty[p.name]) or 1), 1, 99)
						CFG.nextAt[p.name] = os.clock() + iv
						M._buyBusy = true
						local ok, msg = M.buyPotion(p.name, qty)
						M._buyBusy = false
						setLbl(lblPot, (ok and "定时 " or "定时失败 ") .. msg)
					end
				end
			end
		end

		-- 自动喝
		if CFG.autoDrink and os.clock() - lastDrink > 3 then
			lastDrink = os.clock()
			task.spawn(function()
				for _, p in ipairs(M.potionList()) do
					if CFG.potionSel[p.name] and p.owned > 0 and not M.effectActive(p.name) then
						local ok, msg = M.usePotion(p.name)
						if ok then setLbl(lblPot, msg) end
						task.wait(0.3)
					end
				end
			end)
		end

		-- 药水页信息（仅该页可见时刷新）
		pcall(function() setLbl(lblPotInfo, potionInfoText()) end)

		-- 自动悬浮
		if CFG.autoAfk and hrp then
			local attacked = lastHp and hp < lastHp - 2
			local near = false
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= plr and p.Character then
					local h = p.Character:FindFirstChild("HumanoidRootPart")
					if h and (h.Position - hrp.Position).Magnitude < 300 then near = true break end
				end
			end
			if (attacked or near) and not M.padAlive() then
				local _, msg = M.floatUp(800)
				setLbl(lblFloat, "自动升空：" .. tostring(msg))
			end
		end
		lastHp = hp
	end
	getgenv().__PF_LOOP = nil
end)

print("[辅助] v3 已加载")
