--[[
  力量随机生成 · 辅助面板 v2
  ─────────────────────────────
  ① 兑换码    需加官方群组（客户端硬性校验）
  ② 自动抽卡  秒抽 + 自动领每日/在线奖励
  ③ 技能点    扫描 → 确认 → 购买（失败不扣钱）
  ④ 悬浮挂机  脚底生成本地透明平台，抬到高空，只有自己能看见
  ⑤ 图鉴/徽章  自动领取 INDEX 与 BADGES 奖励
  ⑥ 药水商店  POTIONS 全列表 + 勾选购买 + 自动补货 / 自动喝
  ⑦ 自动刷    刷金币（Surge）/ 刷钻石（Billionaire）+ 精简挂机 HUD
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
						if d.Parent then d.Enabled = false end
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
	Lighting.GlobalShadows = true
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
	local _, _, hrp = char()
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
	if hrp then
		local ray = workspace:Raycast(hrp.Position + Vector3.new(0, 2, 0), Vector3.new(0, -600, 0))
		if ray then
			hrp.CFrame = CFrame.new(ray.Position + Vector3.new(0, 4, 0))
		end
	end
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
local DISP = {
	["Speedy Potion"] = "加速药水",
	["Haste Potion"] = "高级加速药水",
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

local function effectSlotLimit()
	local ok, mod = pcall(function() return require(SH:FindFirstChild("PerkLimits")) end)
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

local TabMain = Window:AddTab("主页", "house")
local TabPot = Window:AddTab("药水", "flask-conical")
local TabFarm = Window:AddTab("自动刷", "zap")

local function notify(msg)
	pcall(function() Library:Notify(tostring(msg), 2) end)
end

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
local GCode = TabMain:AddLeftGroupbox("兑换 / 抽卡")
local GSkill = TabMain:AddLeftGroupbox("技能点")
local GFloat = TabMain:AddRightGroupbox("悬浮")
local GRew = TabMain:AddRightGroupbox("奖励")
local GAfk = TabMain:AddRightGroupbox("防挂机")
local GFps = TabMain:AddLeftGroupbox("FPS")

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
	Callback = function(v) CFG.autoAfk = v end,
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
		if v and POTION_CURRENCY[k] then set[k] = true end
	end
	CFG.potionSel = set
end

local function allQty(n)
	n = math.clamp(math.floor(tonumber(n) or 1), 1, 99)
	for name in pairs(POTION_CURRENCY) do CFG.qty[name] = n end
	return n
end
allQty(CFG.qty["Lucky Potion"] or 1)

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
	local coins, dias = 0, 0
	for _, p in ipairs(M.potionList()) do
		if CFG.potionSel[p.name] then
			local total = p.price * (tonumber(CFG.qty[p.name]) or 1)
			if p.currency == "Diamonds" then dias = dias + total else coins = coins + total end
		end
	end
	local parts = {}
	if coins > 0 then parts[#parts + 1] = fmt(coins) .. " 金币" end
	if dias > 0 then parts[#parts + 1] = fmt(dias) .. " 钻石" end
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
	coins = { name = "金币", glove = "Surge", gadgetPool = { "Rarely", "Fury", "Suppressor", "Reducer" }, cur = "Coins" },
	diamonds = { name = "钻石", glove = "Surge", gadget = "Billionaire", cur = "Diamonds" },
}

local function pickCoinGadget()
	local owned = (data("Inventory") or {}).Gadgets or {}
	for _, g in ipairs(FARM_DEF.coins.gadgetPool) do
		if (tonumber(owned[g]) or 0) > 0 then return g end
	end
	return ""
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
	if not farmEquipped(def.glove) then
		if farmEquip("GloveEquipEvent", def.glove) then st.status = "装备手套" end
	else
		st.status = "手套 " .. def.glove
	end

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
		gadget = mode == "diamonds" and def.gadget or pickCoinGadget(),
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
GFarm:AddLabel("金币：Surge，不挂亿万富翁\n钻石：Surge + 亿万富翁", true)

refreshCode()
pcall(refreshSkill)

Library:OnUnload(function()
	pcall(stopFarm)
	M.stopRoll()
	pcall(M.floatDown)
	if getgenv().__PF_AFK_CONN then pcall(function() getgenv().__PF_AFK_CONN:Disconnect() end) getgenv().__PF_AFK_CONN = nil end
	if getgenv().__PF_FPS_CONN_MAIN then pcall(function() getgenv().__PF_FPS_CONN_MAIN:Disconnect() end) getgenv().__PF_FPS_CONN_MAIN = nil end
	getgenv().__PF_LIB = nil
	getgenv().__PF_PANEL = nil
end)
getgenv().__PF_PANEL = Library.ScreenGui

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
