--[[
  一键脚本 v22（含全部最新改动 · 自包含单文件）
  ============================================================
  六标签 UI「巫（不要停下）」：驾驶 / 透视 / 画面 / 杂项 / 传送 / 趣味
  · 自动驾驶：路径跟踪 + 复活 + 避障 + 穿墙 + 平移归中(越偏离越快的平滑回中)
  · 速度控制：固定速度巡航 + 自主调速(油门/刹车)
  · 透视：怪物 / 障碍 / 建筑高亮 + 小箭头
  · 画面：夜视 / 超远视距 / 无雾 / 锁白天 / 关阴影 / FPS 等 14 项
  · 传送：直达 / 间歇 / 一键通关(保守分段)
  · 趣味：倒着开车 / 车旋转 / 车弹跳(默认关,可还原)
  · QTE：特殊怪精确 tap 触发
  用法：直接把本文件整段贴进执行器 loadstring 运行即可，无需 Bridge / 守护。
  ============================================================
]]

getgenv().__SRC_TUNE = [=[
--[[
  VehicleTune v3 — 车辆属性实时调校（全车型版）
  v2 只改 Rally.Hatch 一种车，若玩家开的是别的车型则加速/抓地/刹车全部无效。
  v3 遍历 Rally 下所有"带 Engine 表"的车型，逐个改写，任何车都生效。
  通过改写客户端配置表实现，运行时立即生效（若游戏为服务端权威则客户端无效，见 _TUNE_DIAG 诊断）。
  全局接口：
    _TUNE_SET(key, value)  key=accel|topspeed|control|brake   value=倍率
    _TUNE_GET()            返回当前四项值
    _TUNE_RESET()          恢复游戏默认值
    _TUNE_APPLY()          重新应用当前设定
    _TUNE_STATUS()         一行状态串
    _TUNE_DIAG()           诊断：车型清单/当前车/配置表实测值/车速，用于判断调校是否生效
]]
local RS = game:GetService("ReplicatedStorage")
local Shared = RS:FindFirstChild("Shared")
if not Shared then
    getgenv()._TUNE_DIAG = function() return "TUNE_FAIL: 无 ReplicatedStorage.Shared" end
    return
end
local CFG = Shared:FindFirstChild("Config")
if not CFG then
    getgenv()._TUNE_DIAG = function() return "TUNE_FAIL: 无 Shared.Config" end
    return
end
local okC, Car = pcall(function() return require(CFG:FindFirstChild("Car")) end)
local okR, Rally = pcall(function() return require(CFG:FindFirstChild("Rally")) end)
if not okC or not okR or type(Car) ~= "table" or type(Rally) ~= "table" then
    getgenv()._TUNE_DIAG = function() return "TUNE_FAIL: require Car/Rally 失败" end
    return
end

-- 收集所有"车型"配置：Rally 下带 Engine 表的子项
local MODELS = {}
for k, v in pairs(Rally) do
    if type(v) == "table" and type(v.Engine) == "table" then
        MODELS[tostring(k)] = v
    end
end

-- 缓存默认原值（新的 key 避免与旧版 __VT_DEF 结构冲突）
local DEF
if not getgenv().__VT_DEF3 then
    DEF = { topspeed = tonumber(Car.TopSpeed) or 140, models = {} }
    for name, m in pairs(MODELS) do
        DEF.models[name] = {
            force = m.Engine.Force,
            brake = m.Brakes and tonumber(m.Brakes.Force) or nil,
            lat   = m.Tyres and tonumber(m.Tyres.LateralGrip) or nil,
            long  = m.Tyres and tonumber(m.Tyres.LongitudinalGrip) or nil,
        }
    end
    getgenv().__VT_DEF3 = DEF
else
    DEF = getgenv().__VT_DEF3
end

local cur = { accel=1.0, topspeed=1.0, control=1.0, brake=1.0 }
getgenv().__VT_CUR = cur

local function apply()
    local ok, err = pcall(function()
        Car.TopSpeed = math.floor(DEF.topspeed * cur.topspeed + 0.5)
        for name, m in pairs(MODELS) do
            local d = DEF.models[name]
            if not d then continue end
            if d.force then m.Engine.Force = d.force * cur.accel end
            if d.brake and m.Brakes then m.Brakes.Force = d.brake * cur.brake end
            if d.lat and m.Tyres then m.Tyres.LateralGrip = d.lat * cur.control end
            if d.long and m.Tyres then m.Tyres.LongitudinalGrip = d.long * cur.control end
        end
    end)
    return ok, err
end

getgenv()._TUNE_SET = function(key, value)
    if cur[key] == nil then return "BAD_KEY:" .. tostring(key) end
    local v = tonumber(value)
    if not v then return "BAD_VALUE" end
    local lo, hi = 0.2, 8.0
    if key == "topspeed" then lo, hi = 0.3, 4.0 end
    cur[key] = math.clamp(v, lo, hi)
    local ok, err = apply()
    return ok and string.format("已设 %s=%.2fx", key, cur[key]) or ("ERR:" .. tostring(err))
end

getgenv()._TUNE_GET = function()
    return { accel=cur.accel, topspeed=cur.topspeed, control=cur.control, brake=cur.brake }
end

getgenv()._TUNE_RESET = function()
    cur.accel, cur.topspeed, cur.control, cur.brake = 1.0, 1.0, 1.0, 1.0
    local ok, err = apply()
    return ok and "已恢复游戏默认" or ("ERR:" .. tostring(err))
end

getgenv()._TUNE_APPLY = function() local ok, err = apply() return ok and "OK" or ("ERR:" .. tostring(err)) end

getgenv()._TUNE_STATUS = function()
    return string.format("加速%.2fx 极速%.0f 控制%.2fx 刹车%.2fx",
        cur.accel, DEF.topspeed * cur.topspeed, cur.control, cur.brake)
end

-- 诊断：确认车型命中 + 配置表实测值 + 当前车速。
-- 若"车型清单"里没有你正在开的车，或拉满后车速不变，说明游戏是服务端权威/初始化缓存，客户端改表无效。
getgenv()._TUNE_DIAG = function()
    local names = {}
    for k in pairs(MODELS) do names[#names+1] = k end
    table.sort(names)
    local lp = game:GetService("Players").LocalPlayer
    local ch = lp and lp.Character
    local hum = ch and ch:FindFirstChildOfClass("Humanoid")
    local hrp = hum and hum.RootPart
    local seat = hum and hum.SeatPart
    local carModel = seat and seat:FindFirstAncestorOfClass("Model")
    local first = MODELS[names[1]]
    local forceNow = first and first.Engine and tostring(first.Engine.Force) or "?"
    return string.format(
        "车型清单=[%s] 当前车=%s 车型数=%d TopSpeed=%.0f(默认%.0f) 首车型Force=%s 车速=%.1f 设定[%s]",
        table.concat(names, ","),
        tostring(carModel and carModel.Name or "nil"),
        #names,
        tonumber(Car.TopSpeed) or 0, DEF.topspeed, forceNow,
        hrp and hrp.Velocity.Magnitude or -1,
        getgenv()._TUNE_STATUS())
end

apply()
print("[VehicleTune v3 全车型] 已注入，" .. #MODELS .. " 种车型。" .. getgenv()._TUNE_DIAG())
]=]

getgenv().__SRC_TP = [=[
--[[
  teleport.lua —— 传送到终点 / 间歇分段传送（v2 保守版）
  依赖：游戏自身的 RoadPath + World（与自动驾驶同一套路径）
  对外接口：
    _TP_PROBE()          探测终点坐标，返回可读字符串
    _TP_TARGET()         返回终点 Vector3 或 nil
    _TP_FINISH()         一次性直达终点(易被反作弊复位，不推荐)
    _TP_INTERMITTENT()   沿路径分段推进到终点(默认保守参数)
    _TP_AUTO_FINISH()    一键通关：停驾驶->探测->间歇推进->冲线触发结算
    _TP_STOP()           停止分段传送
    _TP_SET(step,delay,speed)  调整分段步长/间隔/落点速度
    _TP_STATUS()         状态诊断
  v2 改动：
    1) 步长 120->55m、间隔 0.15->0.35s，默认更接近真实行驶，降低被复位概率
    2) 每段落点带沿路径切线方向的速度(speed)，不是瞬移静止，游戏更认可
    3) 推进期间暂停自动驾驶 override，避免驾驶/传送打架
    4) 到终点后复现"冲线"：落在 FinishS 前一点并带电速度冲过终点线
]]
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local ws = game:GetService("Workspace")

if getgenv()._TP_STOP then pcall(getgenv()._TP_STOP) end

local RoadPath, World, route, FinishS = nil, nil, nil, nil
local targetPos = nil
local targetLook = nil
local stepConn = nil
local stepping = false
local stepS = 0
local statusText = "待机"

-- 【v2】保守参数（可通过 _TP_SET 调整）
local TP_STEP  = 55    -- 每段步长(米)：越小越像真实行驶
local TP_DELAY = 0.35  -- 每段间隔(秒)
local TP_SPEED = 105   -- 落点沿路径方向的初速度(studs/s)，接近正常车速
local driveWasOn = false  -- 推进前自动驾驶是否开着，结束后恢复

local function init()
    if route then return true end
    local ok, err = pcall(function()
        local RS = game:GetService("ReplicatedStorage")
        local Shared = RS:WaitForChild("Shared")
        RoadPath = require(Shared.Rules.RoadPath)
        World    = require(Shared.Config.World)
        route    = RoadPath.build(World)
        FinishS  = tonumber(World.FinishS) or math.huge
    end)
    if not ok then statusText = "初始化失败:" .. tostring(err):sub(1,50); return false end
    return true
end

local function getCarRoot()
    local ch = lp.Character; if not ch then return nil end
    local hum = ch:FindFirstChildOfClass("Humanoid")
    local sp = hum and hum.SeatPart
    if not sp or not (sp:IsA("VehicleSeat") or sp:IsA("Seat")) then return nil end
    local car = sp.Parent and sp.Parent.Parent
    local chassis = car and (car:FindFirstChild("Chassis") or car:FindFirstChildWhichIsA("BasePart"))
    if chassis and chassis:IsA("BasePart") then return chassis, sp end
    return sp, sp
end

local function probe()
    if not init() then return "PROBE_FAIL " .. statusText end
    local ok, x, y, z, fx, fz = pcall(function()
        return RoadPath.pointAt(route, FinishS, 0)
    end)
    if not ok or type(x) ~= "number" then
        statusText = "终点求解失败"
        return "PROBE_FAIL 无法求解终点坐标"
    end
    targetPos = Vector3.new(x, y, z)
    targetLook = Vector3.new(fx or 0, 0, fz or -1)
    if targetLook.Magnitude < 0.01 then targetLook = Vector3.new(0, 0, -1) end
    targetLook = targetLook.Unit
    statusText = "终点已探测"
    return string.format("终点 FinishS=%.0f 坐标=(%.0f, %.1f, %.0f)", FinishS, x, y, z)
end

-- 把整车移到指定坐标；带速度(沿 look 方向)让它像在行驶而非瞬移静止
local function placeCar(pos, look, speed)
    local root = getCarRoot()
    if not root then statusText = "未上车"; return false, "未上车" end
    local ok, err = pcall(function()
        root.CFrame = CFrame.lookAt(pos + Vector3.new(0, 1.5, 0), pos + look)
        if root:IsA("BasePart") then
            root.AssemblyLinearVelocity = look * (speed or 0)
            root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end)
    if not ok then statusText = "摆放失败"; return false, tostring(err) end
    return true, "ok"
end

local function finish()
    if not targetPos then probe() end
    if not targetPos then return "TP_FAIL 无终点坐标" end
    local ok, x, y, z, fx, fz = pcall(function()
        return RoadPath.pointAt(route, math.max(0, FinishS - 3), 0)
    end)
    local pos, look = targetPos, targetLook
    if ok and type(x) == "number" then
        pos = Vector3.new(x, y, z)
        look = Vector3.new(fx or 0, 0, fz or -1)
        if look.Magnitude < 0.01 then look = targetLook end
        look = look.Unit
    end
    local placed, why = placeCar(pos, look, TP_SPEED)
    if not placed then return "TP_FAIL " .. why end
    statusText = "已直达终点"
    return "TP_OK 已放到终点(FinishS=" .. tostring(math.floor(FinishS)) .. ")"
end

local function stop()
    stepping = false
    if stepConn then stepConn:Disconnect(); stepConn = nil end
    statusText = "已停止传送"
    return "间歇传送已停止"
end

local function pathPointAt(s)
    local ok, x, y, z, fx, fz = pcall(function()
        return RoadPath.pointAt(route, math.max(0, s), 0)
    end)
    if not ok or type(x) ~= "number" then return nil end
    local look = Vector3.new(fx or 0, 0, fz or -1)
    if look.Magnitude < 0.01 then look = Vector3.new(0, 0, -1) end
    return Vector3.new(x, y, z), look.Unit
end

-- 间歇分段：沿路径小步推进。每段落点带切向速度，间隔可调，模拟真实行驶。
local function intermittent(resumeDrive)
    if not targetPos then probe() end
    if not targetPos then return "TP_FAIL 无终点坐标" end
    if stepping then return "间歇传送进行中" end
    local root = getCarRoot()
    if not root then return "TP_FAIL 未上车" end

    -- 记录并暂停自动驾驶，避免每帧 override 与传送抢控制权
    local stStatus = getgenv()._AUTOPILOT_V2_STATUS
    driveWasOn = false
    if type(stStatus) == "function" then
        local ok, s = pcall(stStatus)
        driveWasOn = ok and string.find(tostring(s), "enabled=true") ~= nil
    end
    if driveWasOn then
        local st = getgenv()._AUTOPILOT_V2_STOP; if type(st) == "function" then pcall(st) end
    end

    local s = RoadPath.project(route, root.Position.X, root.Position.Z)
    stepS = tonumber(s) or 0
    stepping = true
    statusText = "间歇传送中"
    if stepConn then stepConn:Disconnect() end
    stepConn = RunService.Heartbeat:Connect(function()
        if not stepping then return end
        -- 到终点：落在 FinishS 前 2m 带速度冲线
        if stepS >= FinishS - 2 then
            local pos, look = pathPointAt(FinishS - 2)
            if pos then placeCar(pos, look, TP_SPEED) end
            stepping = false
            if stepConn then stepConn:Disconnect(); stepConn = nil end
            statusText = "间歇传送完成-冲线"
            -- 短暂等待游戏结算，再恢复自动驾驶(若之前开着)
            task.delay(1.5, function()
                if resumeDrive ~= false and driveWasOn then
                    local st = getgenv()._AUTOPILOT_V2_START
                    if type(st) == "function" then pcall(st) end
                end
            end)
            return
        end
        stepS = math.min(stepS + TP_STEP, FinishS - 2)
        local pos, look = pathPointAt(stepS)
        if pos then placeCar(pos, look, TP_SPEED) end
        stepping = false
        task.delay(TP_DELAY, function() if statusText == "间歇传送中" then stepping = true end end)
    end)
    return string.format("间歇传送启动 S=%.0f 步长=%dm 间隔=%.2fs 落点速度=%d", stepS, TP_STEP, TP_DELAY, TP_SPEED)
end

-- 一键通关：探测 + 间歇推进(不自动恢复驾驶，停在终点结算)
local function autoFinish()
    if not targetPos then probe() end
    local r = intermittent(false)
    statusText = "一键通关进行中"
    return "AUTO_FINISH " .. r
end

getgenv()._TP_PROBE        = probe
getgenv()._TP_TARGET       = function() return targetPos end
getgenv()._TP_FINISH       = finish
getgenv()._TP_INTERMITTENT = intermittent
getgenv()._TP_AUTO_FINISH  = autoFinish
getgenv()._TP_STOP         = stop
getgenv()._TP_SET          = function(step, delay, speed)
    if tonumber(step)  then TP_STEP  = math.clamp(tonumber(step), 15, 200) end
    if tonumber(delay) then TP_DELAY = math.clamp(tonumber(delay), 0.1, 1.5) end
    if tonumber(speed) then TP_SPEED = math.clamp(tonumber(speed), 0, 200) end
    return string.format("传送参数 步长=%dm 间隔=%.2fs 速度=%d", TP_STEP, TP_DELAY, TP_SPEED)
end
getgenv()._TP_STATUS       = function()
    return string.format("tp状态=%s 终点=%s FinishS=%s 分段中=%s 步长=%d 间隔=%.2f 速度=%d",
        statusText, targetPos and string.format("(%.0f,%.1f,%.0f)",targetPos.X,targetPos.Y,targetPos.Z) or "未探测",
        FinishS and tostring(math.floor(FinishS)) or "?", tostring(stepping), TP_STEP, TP_DELAY, TP_SPEED)
end

print("[Teleport v2] 已注入。接口: _TP_PROBE / _TP_FINISH / _TP_INTERMITTENT / _TP_AUTO_FINISH / _TP_SET / _TP_STOP")

]=]

getgenv().__SRC_AUTO = [=[
--// ================================================================
--//  Autopilot v2 - path-following autopilot via CarInput.setOverride
--//  游戏: Don't Stop (县道13号 / Map02)
--//  机制: require(CarInput).setOverride(fn) -> fn() returns
--//        throttle, brake, steer, handbrake every frame
--//        RoadPath.project(route,x,z) -> (s, lateral, dist, fork)
--//        RoadPath.pointAt(route,s,offset) -> (x,y,z,fx,fz)
--// ================================================================
local Players     = game:GetService("Players")
local RunService  = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- 清理旧实例（防重复注入叠加）
if getgenv()._AUTOPILOT_V2_STOP then
    pcall(function() getgenv()._AUTOPILOT_V2_STOP() end)
end

local CFG = {
    lookahead   = 22,     -- 前瞻距离(studs)
    -- v6: 已取消速度上限(targetSpeed 不再使用)，油门恒满，极速由游戏物理决定
    targetSpeed = 100,    -- [废弃/保留字段] v6 不再据此限速，油门常满
    maxSteer    = 1.0,    -- 转向上限
    stuckSec    = 2.5,    -- 判定卡死的时间
    recoverSec  = 1.2,    -- 脱困倒车时长
    gripAssist  = 0.55,   -- 【对策1/惯性】侧滑抵消强度:每帧削减侧向速度的比例(0=关,1=完全贴合车头)
    turnBoost   = 0.18,   -- 【对策2/转向掉速】转弯时额外补油
    -- 对策3: 障碍物检测 + 自动穿墙（运动学主检测 + 射线辅助）
    obsRange    = 55,     -- 射线辅助探测距离(studs) v14:40->55, 高速下更早发现石头/建筑
    obsHalfAng  = 0.55,   -- 探测扇面半角(弧度) v14:0.30->0.55, 加宽覆盖侧前方石头(偏出中线时也能打到)
    noclipSec   = 2.2,    -- 命中障碍后穿墙持续时间(秒) v14:1.6->2.2, 确保整车完全穿过石堆
    noclipCool  = 1.0,    -- 穿墙冷却(缩短, v14:1.6->1.0)
    crashDrop   = 24,     -- 【主检测】速度骤降阈值 v14:28->24, 更早判定撞障碍
    crashMinSpd = 45,     -- 且撞前速度需高于此值 v14:55->45
    crashLowAbs = 22,     -- 或绝对速度低于此值且仍在给油=撞停
    -- 【v27】打舵回中默认关：用户要的是"平移辅助转弯"，不要这套需要手动调力度/灵敏度的打舵回中。
    -- 保留接口 _STEER_ASSIST_SET(true) 可随时开回，纯转向微调兜底仍在。
    steerAssistOn = false, -- 【v27默认关】打舵式回中(越偏打舵越狠)，已被平移辅助转弯取代
    steerCap      = 0.62, -- 大弯道防甩尾的转向软上限(仅 steerAssistOn 开启时启用)
    recenterDead  = 0.25, -- 打舵回中死区(米)，仅 steerAssistOn 开启时生效
    recenterFull  = 4.0,  -- 打舵回中满力距离，仅 steerAssistOn 开启时生效
    recenterMax   = 0.85, -- 打舵回中最大舵角，仅 steerAssistOn 开启时生效
    tuneLinkSpeed = true, -- 车辆极速倍率联动自动驾驶安全速度(让调校在自动驾驶时生效)
    -- 【v20 防出界穿墙】偏离主道过远时不穿，穿墙中被推出/坠落立即拉回路径
    noclipMaxLat  = 16,   -- 触发穿墙前允许的最大横向偏离(米)，超过则放弃穿墙
    guardLat      = 20,   -- 穿墙期间横向偏离超过此值判定"被推出主道"->拉回
    guardFall     = 4,    -- 【v26】车低于路径地面此值判定"坠落虚空"->拉回(旧12太晚，整车幽灵掉4m就该救)
    -- 【v24】穿墙总开关：默认关闭（保留接口 _NOCLIP_SET 可手动开启）。
    -- 实测结论：车"一直掉下去"的真凶是平移层(glideToCenter)每帧 CFrame.lookAt 强制水平+死守高度，
    -- 不是穿墙。对照实验：穿墙开+平移关时 carY 恒定 41.9~42.5、velY≈0，完全不掉；
    -- 而关穿墙后 Wreck.Cabin/Outcrop 这类残骸正面撞死无法通关。故穿墙保留开启。
    noclipEnabled = false, -- 默认关闭穿墙辅助，需手动开启自动驾驶后再按需启用
}

-- 启动时强制清理可能由上次注入遗留的开关状态，确保本脚本功能默认全关。
for _, stopName in ipairs({"_TP_STOP", "_ARROW_STOP"}) do
    local stopFn = getgenv()[stopName]
    if type(stopFn) == "function" then pcall(stopFn) end
end
for _, setName in ipairs({"_AUTO_REVIVE_SET", "_GLIDE_CENTER_SET", "_ESP_MONSTER_SET", "_ESP_OBST_SET", "_ESP_BLDG_SET", "_NOCLIP_SET"}) do
    local setFn = getgenv()[setName]
    if type(setFn) == "function" then pcall(setFn, false) end
end

local enabled  = false
local finished = false
local conn     = nil
local uiConn   = nil
local lastSeat = nil
local CarInput, RoadPath, World, route = nil, nil, nil, nil
local FinishS = math.huge
local chassis = nil         -- 车辆底盘 BasePart (Workspace.Cars.Car_*.Chassis)
local sideSlip = 0          -- 当前侧向滑移速度(诊断用)
local ws = game:GetService("Workspace")
local noclipUntil = 0       -- 穿墙截止 os.clock()
local noclipCoolUntil = 0   -- 穿墙冷却截止
local obsHitName = "none"   -- 最近命中的障碍(诊断用)
local obsCount = 0          -- 累计触发穿墙次数
local savedCollide = {}     -- 记录被临时关闭碰撞的部件原状态 {part=bool}
local prevSpeed = 0         -- 上一帧速度(运动学撞停检测用)
local crashByDrop = 0       -- 由速度骤降触发的穿墙次数(诊断用)
local lastBldgScan = 0      -- 【v19】建筑区域扫描节流
local noclipAborted = false -- 【v20】本次穿墙是否因防出界被中止(中止后冷却期内不再重复触发)
local lastSafePos = nil     -- 【v20】最近一次在路径走廊内且贴地的安全坐标(Vector3)，用于拉回
local guardPulls = 0        -- 【v29】穿墙因防坠中止次数(诊断用；出界拉回已删)
local steerAssistOn = false -- 【v27默认关】打舵回中开关(与CFG同步)，已被平移辅助转弯取代
local steerCapNow = 0.62    -- 【v20】当前转向软上限
local recenterMaxNow = 0.85 -- 【v24】当前最大回中修正量(关平移后加强)
local recenterDeadNow = 0.25-- 【v21】当前回中死区
local recenterFullNow = 4.0 -- 【v24】回中力达到最大的偏离距离(提前满格)
local tuneLinkNow = true    -- 【v21】车辆调校联动自动驾驶开关
local tuneTopMul = 1.0      -- 【v21】从车辆调校读到的极速倍率(缓存)
-- ===== 【v27】平移辅助转弯：用户要的唯一回中功能，默认开 =====
-- 用"横向平移"把车拉回中心线（不是打舵角的回中辅助）。参数内置为最安全值，无需手动调。
-- 安全的平移实现见 glideToCenter()：纯位置平移、保留车身姿态、Y交给物理、单帧封顶、不碰速度。
local autoGlideCenter = true  -- 平移辅助转弯总开关(默认开，v27)
local glidePulls = 0          -- 平移辅助触发帧数(诊断用)
local GLIDE_RATE = 3.5        -- 【v31】基础平滑收敛速率(1/秒)：帧率无关指数平滑；近中心时用此值，柔和贴合
local GLIDE_RATE_MAX = 16     -- 【v31】越偏离越快的速率上限(1/秒)：偏离越大收敛速率按比例升到此值
local GLIDE_BOOST_AT = 12     -- 【v31】偏离多少米时速率升到上限(米)：12m 偏离时达到最快回中
local GLIDE_STEP_MAX = 0.45   -- 【v31】单帧位移硬上限(米)：越偏离越快但仍封顶，杜绝瞬移抛飞
local lastGlideT = 0          -- 【v29】上次平移时刻(os.clock)，算 dt 用，做帧率无关平滑
local GLIDE_EPS = 0.02        -- 【v29】"已基本在中心"判定(米)，仅避免厘米级抖动，不是死区：一偏离就平滑拉回

-- ===== 【v30】速度控制：① 固定速度巡航 ② 自主调速(油门/刹车手动) =====
-- 两者都是对 computeDrive 算出的 throttle/brake 做"覆盖"，转向/避障/平移等其它逻辑完全不动。
local cruiseOn = false        -- 固定速度巡航开关(默认关)：ON 时忽略弯道限速，一直锁定 cruiseSpeed
local cruiseSpeed = 90        -- 固定速度值(studs/s)：滑块滑到哪就锁哪，靠油门/刹车维持在 ±5%
local manualSpdOn = false     -- 自主调速开关(默认关)：ON 时油门/刹车直接取滑块值，转向仍自动
local manualThrottle = 0.6    -- 手动油门(0~1)
local manualBrake = 0         -- 手动刹车(0~1)
local CRUISE_BAND = 0.05      -- 巡航速度容差：进入 ±5% 松油门滑行，避免来回抖
local CRUISE_BRAKE = 0.45     -- 巡航超速时的刹车力度

-- 运行时状态
local mapS = 0
local mapLateral = 0
local speed = 0
local curvNow = 0         -- 前方曲率(诊断用)
local safeSpdNow = 0      -- 当前弯道安全速度(诊断用)
local stuckT = 0        -- 里程无进展累计时间
local recoverT = 0      -- 脱困剩余时间
local lastProgressS = 0 -- 上次有进展时的里程
local recoverDir = 1    -- 脱困转向方向（交替）
local recoverCount = 0  -- 【v14】连续脱困次数, 超过阈值才退回游戏复位
local stateText = "待机"

--// ---------- 初始化：require 模块 + build route ---------- //--
local function initModules()
    local ok, err = pcall(function()
        local RS = game:GetService("ReplicatedStorage")
        local Shared = RS:WaitForChild("Shared")
        RoadPath = require(Shared.Rules.RoadPath)
        World    = require(Shared.Config.World)
        local ps = LocalPlayer:WaitForChild("PlayerScripts")
        local Client = ps:WaitForChild("Client")
        CarInput = require(Client:WaitForChild("CarInput"))
        -- build route 与游戏自身一致: build(World)
        route = RoadPath.build(World)
        FinishS = tonumber(World.FinishS) or math.huge
    end)
    if not ok then
        stateText = "初始化失败: " .. tostring(err):sub(1, 60)
        return false
    end
    return true
end

local function getSeat()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return nil end
    local sp = hum.SeatPart
    if sp and (sp:IsA("VehicleSeat") or sp:IsA("Seat")) then
        lastSeat = sp
        -- 定位底盘: Car_<userId>.Chassis (Seat 的父级的父级)
        if not chassis or not chassis.Parent then
            local car = sp.Parent and sp.Parent.Parent
            local c = car and car:FindFirstChild("Chassis")
            if c and c:IsA("BasePart") then chassis = c end
        end
        return sp
    end
    return nil
end

--// ---------- 对策1: 侧滑抵消(减小惯性甩尾) ---------- //--
-- 把底盘速度分解为车头/侧向分量，削减侧向分量后重组，等价于人为提高抓地力。
-- 只改我们自己的车，不碰游戏物理配置，随时可关。
local function applyGrip()
    if CFG.gripAssist <= 0 then return end
    local ch = chassis
    if not ch or not ch.Parent then return end
    local lv = ch.AssemblyLinearVelocity
    local cf = ch.CFrame
    local fwd = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
    if fwd.Magnitude < 0.01 then return end
    fwd = fwd.Unit
    local right = Vector3.new(-fwd.Z, 0, fwd.X) -- 水平右向量
    local vF = lv.X * fwd.X + lv.Z * fwd.Z
    local vR = lv.X * right.X + lv.Z * right.Z
    sideSlip = vR
    if math.abs(vR) < 0.3 then return end
    -- 只削减侧向速度，保留前向分量与竖直分量
    local newR = vR * (1 - CFG.gripAssist)
    ch.AssemblyLinearVelocity = Vector3.new(
        fwd.X * vF + right.X * newR,
        lv.Y,
        fwd.Z * vF + right.Z * newR
    )
end

--// ---------- 对策3: 障碍物检测 + 自动穿墙 ---------- //--
-- 从车头打扇形射线(正前/左斜前/右斜前)，命中近处可碰撞障碍时临时关掉
-- 该障碍与本车底盘的碰撞一小段时间冲过去，之后自动恢复，绝不永久穿墙。
local function getCarDescendants()
    local t = {}
    if chassis and chassis.Parent then
        for _, o in ipairs(chassis.Parent:GetDescendants()) do
            if o:IsA("BasePart") then t[#t+1] = o end
        end
    end
    return t
end

local function saveAndDisableCollide(part)
    if not part or not part:IsA("BasePart") then return end
    if savedCollide[part] == nil then
        savedCollide[part] = part.CanCollide
    end
    if part.CanCollide then part.CanCollide = false end
end

local function restoreCollide()
    for part, orig in pairs(savedCollide) do
        pcall(function()
            if part and part.Parent then part.CanCollide = orig end
        end)
        savedCollide[part] = nil
    end
end

-- ===== 【v20 机灵穿墙】防出界：路径参考高度 / 安全点 / 拉回 =====
-- 路径点的 y 作为"当前里程应有的地面高度"，车远低于它即判定已掉出地图进虚空。
local function getPathGroundY(s)
    if not route then return nil end
    local ok, tx, ty = pcall(function()
        return RoadPath.pointAt(route, math.max(0, s or 0), 0)
    end)
    if ok and typeof(tx) == "number" and typeof(ty) == "number" then return ty end
    return nil
end

-- 【v29】出界自动拉回已删除：不再保留瞬移回安全点的函数。防坠只恢复碰撞，回中交给平滑平移辅助。

-- 每帧守卫：① 记录安全点 ② 穿墙中被推出主道/坠落则立刻中止并拉回
local function guardNoclip()
    local now = os.clock()
    if not chassis or not chassis.Parent or not route then return end
    local lat = math.abs(mapLateral or 0)
    local gy = getPathGroundY(mapS)
    local dy = gy and (chassis.Position.Y - gy) or 0

    -- ① 只在贴地、在走廊内、非穿墙时记录安全点
    if now >= noclipUntil and lat < 10 and dy > -3 and dy < 8 then
        lastSafePos = { p = chassis.Position, look = chassis.CFrame.LookVector }
    end

    -- ② 穿墙中监控
    if now < noclipUntil and not noclipAborted then
        local bad = nil
        local velY = chassis.AssemblyLinearVelocity and chassis.AssemblyLinearVelocity.Y or 0
        if lat > CFG.guardLat then
            bad = "推出主道 lat=" .. string.format("%.0f", lat)
        elseif velY < -7 and dy < 1 then
            -- 【v26】整车幽灵失去地面支撑开始下坠(velY<-7且已低于路径)->立刻恢复碰撞，
            -- 避免一路掉进虚空被复位。这是撞横梁后整车穿墙掉下去的直接防护。
            bad = "下坠 velY=" .. string.format("%.1f", velY)
        elseif gy and dy < -CFG.guardFall then
            bad = "坠落虚空 dy=" .. string.format("%.0f", dy)
        end
        if bad then
            -- 【v29】用户要求删除"出界自动拉回"：不再瞬移回安全点。
            -- 仅恢复碰撞+中止穿墙让车靠物理归位，杜绝瞬移抛飞；平移辅助负责平滑回中。
            noclipAborted = true
            guardPulls = guardPulls + 1
            restoreCollide()
            noclipUntil = 0
            noclipCoolUntil = now + 1.5
            stateText = "中止穿墙(已删拉回)"
            print("[AutoDriveV29] 中止穿墙(已删拉回): " .. bad .. " #" .. guardPulls)
        end
    end
end

-- ===== 【v29】平移辅助转弯：始终平滑收敛到中心线（用户要的"控制在中心位置 + 平滑平移"）=====
-- 与旧版唯一区别：去掉 1.2m 死区（旧版偏离1米内不管），现在只要偏 > GLIDE_EPS(2cm) 就平滑往中心线拉，
-- 且改用"帧率无关的指数平滑"：step = 偏离 × (1 - e^(-rate·dt))，60fps/144fps 手感一致，越接近中心步子越小，自然贴合不抖。
-- 【安全保证（不变）】
--  ① 纯位置平移：左乘纯平移 CFrame，俯仰/侧倾/朝向 100% 保留，绝不用 CFrame.lookAt 强制水平。
--  ② Y 高度完全不动：垂直方向交给物理与悬挂，不瞬移/不钻地/不悬空。
--  ③ 单帧位移硬封顶 GLIDE_STEP_MAX=0.45m：越偏离越快，但偏离再大也不瞬移，物理引擎吃得消。
--  ④ 不碰 AssemblyLinearVelocity：撞停检测依赖真实速度骤降触发穿墙救援，抹平会卡死。
local function glideToCenter()
    if not autoGlideCenter then return end
    if not chassis or not chassis.Parent or not route then return end

    -- 帧率无关 dt：首帧/异常跳变用 1/60 兜底，避免一帧巨移
    local nowT = os.clock()
    local dt = nowT - lastGlideT
    lastGlideT = nowT
    if dt <= 0 or dt > 0.2 then dt = 1 / 60 end

    local ok, cx, cy, cz = pcall(function()
        return RoadPath.pointAt(route, math.max(0, mapS), 0)
    end)
    if not ok or typeof(cx) ~= "number" then return end

    local p = chassis.Position
    local dx, dz = cx - p.X, cz - p.Z
    local dist = math.sqrt(dx * dx + dz * dz)
    if dist <= GLIDE_EPS then return end  -- 已在中心线(2cm内)不动，避免抖动

    -- 【v31】越偏离越快的平滑收敛：偏离越大，收敛速率 rate 越高（GLIDE_RATE → GLIDE_RATE_MAX 线性）。
    -- 近中心(1m内)用低速率柔和贴合不抖；远偏离(12m)用高速率快速拉回；全程帧率无关、单帧仍封顶防抛飞。
    local boost = math.min(dist / GLIDE_BOOST_AT, 1)          -- 0~1，偏离越大越接近1
    local rate = GLIDE_RATE + (GLIDE_RATE_MAX - GLIDE_RATE) * boost
    local alpha = 1 - math.exp(-rate * dt)
    local step = math.min(dist * alpha, GLIDE_STEP_MAX)
    local ux, uz = dx / dist, dz / dist
    -- 关键：左乘纯平移 CFrame → 只挪 XZ 位置，旋转(Y/S俯仰/侧倾/朝向)与速度全部原样保留
    pcall(function()
        chassis.CFrame = CFrame.new(ux * step, 0, uz * step) * chassis.CFrame
    end)
    glidePulls = glidePulls + 1
end

local function doNoclip(reason, part, dist, disableChassis)
    -- 【v22】穿墙总开关关闭时：只有"脱困"这种短暂整车幽灵允许，其它一律不穿。
    -- 实测撞树/石头穿墙会把车带出赛道 -> 游戏强制复位回起点 -> 永远过不了关。
    if not CFG.noclipEnabled and reason ~= "脱困" then
        stateText = "避障绕行(穿墙已关)"
        noclipCoolUntil = os.clock() + 0.4
        return
    end
    -- 【v20】车已被撞偏出主道太远时，绝不再穿墙：此时车头多朝图外，穿墙=冲进虚空。
    -- 交给卡死/倒车脱困或先转向回中线，比一路幽灵冲出地图安全。
    if reason ~= "脱困" and math.abs(mapLateral or 0) > CFG.noclipMaxLat then
        stateText = "偏道过远-放弃穿墙"
        noclipCoolUntil = os.clock() + 0.8
        return
    end
    obsCount = obsCount + 1
    noclipAborted = false
    obsHitName = part and part:IsA("Instance") and part:GetFullName() or reason
    if part and part:IsA("BasePart") then
        -- v12: 命中建筑/大障碍时，把其所在 Model 的所有 CanCollide 部件一起临时关闭，
        -- 避免只关一个部件后车又撞上同一栋建筑的其他墙/柱
        local parentModel = part:FindFirstAncestorOfClass("Model")
        if parentModel and parentModel ~= chassis.Parent then
            for _, o in ipairs(parentModel:GetDescendants()) do
                if o:IsA("BasePart") then saveAndDisableCollide(o) end
            end
        else
            saveAndDisableCollide(part)
        end
    end
    -- 【v14 关键修复】穿墙时把整车所有 BasePart 碰撞一起关掉(不只底盘)。
    -- 旧版只关底盘:车侧/顶部卡进石堆时仍被自己的其他部件(轮胎/车身)顶住 -> 反复撞停回起点。
    -- 整车一起进入"幽灵"状态才能干净利落冲过整个石堆。
    if disableChassis then
        for _, o in ipairs(getCarDescendants()) do saveAndDisableCollide(o) end
    end
    local now = os.clock()
    noclipUntil = now + CFG.noclipSec
    noclipCoolUntil = now + CFG.noclipSec + CFG.noclipCool
    stateText = "穿墙(" .. reason .. (dist and string.format(" %.0fm", dist) or "") .. ")"
    print("[AutoDriveV5] 穿墙触发: " .. obsHitName .. " reason=" .. reason)
end

local function updateObstacle()
    local now = os.clock()
    -- 穿墙到期 -> 恢复碰撞
    if now >= noclipUntil and next(savedCollide) ~= nil then
        restoreCollide()
    end
    if not enabled or finished then return end
    if not chassis or not chassis.Parent then return end

    -- 读取当前速度
    local lv = chassis.AssemblyLinearVelocity
    local curSpeed = lv.Magnitude

    -- ===== 主检测: 运动学撞停 =====
    -- 车在高速行驶中速度骤降(撞上障碍被弹停)，对象无关，射线打不到的墙/地形也能捕获
    if now >= noclipCoolUntil then
        local drop = prevSpeed - curSpeed
        local suddenDrop = prevSpeed > CFG.crashMinSpd and drop > CFG.crashDrop
        local stallAfterRun = prevSpeed > CFG.crashLowAbs and curSpeed < CFG.crashLowAbs
        if suddenDrop or stallAfterRun then
            crashByDrop = crashByDrop + 1
            doNoclip("撞停", nil, nil, true)   -- 真撞停：关底盘冲过去
            prevSpeed = curSpeed
            return
        end
    end
    prevSpeed = curSpeed

    if now < noclipCoolUntil then return end  -- 冷却中，跳过射线

    -- ===== 辅助检测: 扇形射线(正前/左前/右前) =====
    local cf = chassis.CFrame
    local fwd = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
    if fwd.Magnitude < 0.01 then return end
    fwd = fwd.Unit
    local right = Vector3.new(-fwd.Z, 0, fwd.X)
    local origin = chassis.Position + Vector3.new(0, 1.2, 0)

    local ignore = getCarDescendants()
    local char = LocalPlayer.Character
    if char then
        for _, o in ipairs(char:GetDescendants()) do
            if o:IsA("BasePart") then ignore[#ignore+1] = o end
        end
    end

    -- 【v13】探测距离随速度增长：高速(110)时能提前看到石头，避免一帧冲过探测范围
    local dynRange = CFG.obsRange + math.min(curSpeed * 0.45, 45)
    -- 【v14】5条射线:正前/左右斜前/左右侧前。车偏出中线到路肩时石头常在侧前方,
    -- 旧版3条只覆盖±0.30rad, 侧面石头打不到 -> 车直接撞上。
    local dirs = {
        fwd,
        (fwd + right * CFG.obsHalfAng).Unit,
        (fwd - right * CFG.obsHalfAng).Unit,
        (fwd + right * (CFG.obsHalfAng * 1.9)).Unit,
        (fwd - right * (CFG.obsHalfAng * 1.9)).Unit,
    }
    local hitPart, hitDist = nil, math.huge
    for _, d in ipairs(dirs) do
        local ray = Ray.new(origin, d * dynRange)
        local ok, part, pos = pcall(function()
            return ws:FindPartOnRayWithIgnoreList(ray, ignore)
        end)
        if ok and part and typeof(part) == "Instance" and part.CanCollide then
            -- 【v12】识别两类障碍：
            --  (a) 竖直物(墙/杆/残骸)：最高边>=1.5 且高/扁>=2
            --  (b) 大体积建筑(大棚/仓库/基座)：体积>250 且非地面 —— v11 漏掉立方体建筑，这里补上
            local sz = part.Size
            local hi, lo = math.max(sz.X, sz.Y, sz.Z), math.min(sz.X, sz.Y, sz.Z)
            local vol = sz.X * sz.Y * sz.Z
            local upright = hi >= 1.5 and lo > 0 and hi / lo >= 2.0
            local bigBuilding = vol > 250 and hi >= 4
            -- 【v14】中等体积实体门槛放宽：体积>50且高度>2(旧>80/>3漏掉半埋的石头)
            local midSolid = vol > 50 and hi >= 2 and lo >= 0.8
            local nm = part.Name:lower()
            -- 石头/岩石/碎石按名字直接识别
            local isRock = string.find(nm, "rock") or string.find(nm, "stone") or string.find(nm, "boulder")
                or string.find(nm, "debris") or string.find(nm, "rubble") or string.find(nm, "stump")
                or string.find(nm, "crate") or string.find(nm, "barrel")
                -- 树干/树林
                or string.find(nm, "trunk") or string.find(nm, "tree") or string.find(nm, "pine")
                or string.find(nm, "log") or string.find(nm, "branch")
                -- 【v19】所有建筑物关键词：墙/屋顶/圆顶/棚屋/地基/塔/仓库等一律算障碍
                or string.find(nm, "wall") or string.find(nm, "building") or string.find(nm, "dome")
                or string.find(nm, "hut") or string.find(nm, "cabin") or string.find(nm, "shed")
                or string.find(nm, "garage") or string.find(nm, "house") or string.find(nm, "silo")
                or string.find(nm, "tank") or string.find(nm, "tower") or string.find(nm, "roof")
                or string.find(nm, "base") or string.find(nm, "pillar") or string.find(nm, "post")
                or string.find(nm, "abutment") or string.find(nm, "pier") or string.find(nm, "girder")
                or string.find(nm, "depot") or string.find(nm, "outpost")
            -- 【v19】部位归属 Map.Places(建筑群) 的部件也直接算建筑障碍
            local full = part:GetFullName()
            local inPlaces = string.find(full, "Map.Places", 1, true) ~= nil
            local isGround = part:IsA("Terrain") or string.find(nm, "road") or string.find(nm, "ground")
                or string.find(nm, "floor") or string.find(nm, "asphalt") or string.find(nm, "surface")
                or string.find(nm, "bridge") or string.find(nm, "deck") or string.find(nm, "terrain")
                or string.find(nm, "snow") or string.find(nm, "gravel") or string.find(nm, "dirt")
            -- 【v19】放宽中等实体门槛 + 建筑群部件直接命中
            local midSolid2 = vol > 30 and hi >= 1.5 and lo >= 0.5
            if (upright or bigBuilding or isRock or midSolid or midSolid2 or inPlaces) and not isGround then
                local dist = (pos - origin).Magnitude
                if dist < hitDist then hitDist = dist; hitPart = part end
            end
        end
    end

    -- 【v26 车顶高位射线】抓悬在车顶正上方的横梁/桁架(bottomY≈车顶)。
    -- 常规射线从 chassis+1.2m 水平打出，从横梁下方穿过打不到；故从车顶+3m 再打一组，
    -- 专命中 truss/girder/beam/roof 这类高架结构，提前触发(只关目标)穿墙，车不减速不掉下去。
    if not hitPart then
        local highOrigin = chassis.Position + Vector3.new(0, 3.2, 0)
        for _, d in ipairs(dirs) do
            local ray = Ray.new(highOrigin, d * dynRange)
            local ok, part, pos = pcall(function()
                return ws:FindPartOnRayWithIgnoreList(ray, ignore)
            end)
            if ok and part and typeof(part) == "Instance" and part.CanCollide then
                local nmh = part.Name:lower()
                if string.find(nmh, "truss") or string.find(nmh, "girder") or string.find(nmh, "beam")
                    or string.find(nmh, "roof") or string.find(nmh, "arch") then
                    local dist = (pos - highOrigin).Magnitude
                    if dist < hitDist then hitDist = dist; hitPart = part end
                end
            end
        end
    end

    if hitPart then
        local nm = hitPart.Name:lower()
        local isStoneName = string.find(nm, "rock") or string.find(nm, "stone") or string.find(nm, "boulder")
            or string.find(nm, "trunk") or string.find(nm, "tree") or string.find(nm, "log")
        -- 【v26】结构类(建筑/桁架/横梁)：关掉目标 Model 自身碰撞即可通过。
        -- 关键：绝不能关整车碰撞——整车幽灵会连车轮与地面的接触一起关掉，
        -- 车失去支撑直接下坠(velY=-32/carY 42→32)，这正是"撞桁架后掉下去复位"的根因。
        local isStructName = string.find(nm, "truss") or string.find(nm, "girder") or string.find(nm, "beam")
            or string.find(nm, "wall") or string.find(nm, "building") or string.find(nm, "dome")
            or string.find(nm, "hut") or string.find(nm, "roof") or string.find(nm, "base")
            or string.find(nm, "cabin") or string.find(nm, "pillar") or string.find(nm, "post")
        local tag = isStoneName and "树石" or (isStructName and "建筑" or "物")
        -- 树石/残骸可能半埋需整车冲过(true)；结构类只关目标自身(false)，保留车轮着地。
        doNoclip("射线-" .. tag, hitPart, hitDist, isStoneName and true or false)
    end

    -- ===== 【v19】建筑区域扫描兜底：射线打不到的扁墙/侧面建筑也能发现 =====
    local clockNow = os.clock()
    if not hitPart and clockNow - lastBldgScan > 0.3 then
        lastBldgScan = clockNow
        local places = ws:FindFirstChild("Map") and ws.Map:FindFirstChild("Places")
        if places then
            local look = fwd * 30
            local center = chassis.Position + Vector3.new(look.X, 0, look.Z)
            local nearest, nd = nil, math.huge
            for _,o in ipairs(places:GetDescendants()) do
                if o:IsA("BasePart") and o.CanCollide then
                    local nm2 = o.Name:lower()
                    -- 只关心建筑类部件，排除地面
                    local bld = string.find(nm2,"wall") or string.find(nm2,"dome") or string.find(nm2,"hut")
                        or string.find(nm2,"roof") or string.find(nm2,"base") or string.find(nm2,"building")
                        or string.find(nm2,"cabin") or string.find(nm2,"shed") or string.find(nm2,"depot")
                        or string.find(nm2,"tower") or string.find(nm2,"silo") or string.find(nm2,"tent")
                    if bld then
                        local d = (o.Position - center).Magnitude
                        -- 前方30m/横向12m 的盒状范围
                        local rel = o.Position - chassis.Position
                        local along = rel.X*fwd.X + rel.Z*fwd.Z
                        local lateral = math.abs(rel.X*right.X + rel.Z*right.Z)
                        if along > -2 and along < 34 and lateral < 13 and d < nd then
                            nd = d; nearest = o
                        end
                    end
                end
            end
            if nearest then
                obsHitName = nearest:GetFullName()
                doNoclip("建筑区扫", nearest, nd, true)
            end
        end
    end
end

-- 计算转向：pure-pursuit
local function computeDrive(seat)
    local pos = seat.Position
    local vel = seat.AssemblyLinearVelocity or seat.Velocity or Vector3.new()
    speed = vel.Magnitude

    -- 投影到路径，拿当前里程
    local s, lateral, dist = RoadPath.project(route, pos.X, pos.Z)
    mapS = s or 0
    mapLateral = lateral or 0

    -- 到达终点
    if mapS >= FinishS - 2 then
        finished = true
        stateText = "已到达终点!"
        return 0, 1, 0, false
    end

    -- 车头方向（投影到水平面）
    local cf = seat.CFrame
    local forward = cf.LookVector
    forward = Vector3.new(forward.X, 0, forward.Z)
    if forward.Magnitude < 0.01 then forward = Vector3.new(0, 0, -1) end
    forward = forward.Unit

    -- 前瞻目标点
    local la = CFG.lookahead + math.min(speed * 0.25, 18)
    local tx, ty, tz, fx, fz = RoadPath.pointAt(route, mapS + la, 0)
    local target = Vector3.new(tx, 0, tz)
    local toTarget = target - Vector3.new(pos.X, 0, pos.Z)
    toTarget = Vector3.new(toTarget.X, 0, toTarget.Z)
    if toTarget.Magnitude < 0.01 then return 0.6, 0, 0, false end
    toTarget = toTarget.Unit

    -- 用叉积符号算左右偏差：cross(forward, toTarget).Y
    local cross = forward.X * toTarget.Z - forward.Z * toTarget.X
    local dot = forward:Dot(toTarget)
    local angle = math.atan2(cross, dot) -- 正=目标在右
    local steer = math.clamp(angle * 1.6, -CFG.maxSteer, CFG.maxSteer)

    -- ===== 【v21 回中辅助】偏离中线一点点就介入，越偏回中力越强，主动把车拉回中线 =====
    -- 与 v20 只"收窄打舵防甩尾"不同：这里算"带符号横向偏差"，往中线方向叠加一个额外舵角。
    -- 特性：① 死区极小(0.25m)，一偏离就拉；② 拉回力随偏离单调增强(越偏越狠)；
    --       ③ 用 tanh 平滑饱和，接近中线时力自然减小，不会左右过冲画龙；
    --       ④ 完全不碰油门，速度几乎不受影响。
    if steerAssistOn then
        -- 带符号横向偏差：用当前里程的路径中线点，投影到车头右向量
        -- signedLat > 0 表示中线在车右侧(车偏左)，需要往右打(steer 正方向)
        local signedLat = lateral  -- project 返回的 lateral 本身带符号，首选
        if signedLat == nil then
            local mx, my, mz = RoadPath.pointAt(route, mapS, 0)
            local rx, rz = -forward.Z, forward.X  -- 车头右向量(水平)
            signedLat = (mx - pos.X) * rx + (mz - pos.Z) * rz
        end
        local latAbs = math.abs(signedLat)
        if latAbs > recenterDeadNow then
            local pullDir = signedLat >= 0 and 1 or -1
            -- 强度：从死区到 recenterFull 单调递增，用 t^0.75 让"刚偏离"也有明显力
            local t = math.clamp((latAbs - recenterDeadNow) / math.max(recenterFullNow - recenterDeadNow, 0.01), 0, 1)
            local strength = recenterMaxNow * (t ^ 0.75)
            steer = steer + pullDir * strength
            steer = math.clamp(steer, -CFG.maxSteer, CFG.maxSteer)
        end
        -- 大弯道防甩尾：仅当"偏离不大但转角很大"时收窄，避免回中舵角在急弯里过猛
        -- 【v24】cap下限0.35->0.65：关平移后急弯需要足够舵角压住外飘，压太狠会甩出赛道
        local angAbs = math.abs(angle)
        if angAbs > 0.22 and latAbs < 3 then
            local danger = math.clamp((angAbs - 0.22) / 0.4, 0, 1)
            local cap = steerCapNow - (steerCapNow - 0.65) * danger
            if cap < 0.65 then cap = 0.65 end
            local a = math.abs(steer)
            if a > cap then
                local sign = steer >= 0 and 1 or -1
                local over = (a - cap) / math.max(1 - cap, 0.01)
                local squeezed = cap + (1 - cap) * math.tanh(over)
                steer = sign * math.min(squeezed, CFG.maxSteer)
            end
        end
    end

    -- 【v10 直道无上限 + 曲率预判进弯减速】
    -- 根因: 四版实测撞停都在"长直道冲到130+后遭遇急弯"瞬间——横向加速度随速度平方增长,
    -- 超过抓地极限就甩出赛道。v7~v9 都是"偏了才补救"来不及; 正确解法是提前看弯道曲率。
    -- 用赛道切线夹角算前方曲率(纯几何、对象无关), 弯道按物理安全速度限速, 直道油门常满不限速。
    local function curvatureAt(s)
        local _,_,_, fx1, fz1 = RoadPath.pointAt(route, s, 0)
        local _,_,_, fx2, fz2 = RoadPath.pointAt(route, s + 25, 0)
        local dotc = fx1 * fx2 + fz1 * fz2
        dotc = math.clamp(dotc, -1, 1)
        return math.acos(dotc)   -- 0=直道, 越大越弯
    end
    local kNow = curvatureAt(mapS + 8)
    -- 【v24】前瞻拉远到+55：关平移后靠"提前减速"代替"事后平移拉回"，早看到弯早收油
    local kAhead = curvatureAt(mapS + 55)
    local kFar = curvatureAt(mapS + 90)
    local k = math.max(kNow, kAhead, kFar * 0.85)
    -- 【v21 车辆调校联动】读极速倍率，让自动驾驶的安全速度跟着调校走。
    -- 旧版基准固定200，把物理极速卡在~140：即使把车辆极速调到2.5倍，自动驾驶仍限速200，
    -- 表现为"调车辆属性没区别"。联动后极速倍率提高，直道基准同步放大，调校才真正生效。
    tuneTopMul = 1.0
    if tuneLinkNow then
        local g = getgenv()._TUNE_GET
        if type(g) == "function" then
            local ok, t = pcall(g)
            if ok and type(t) == "table" and tonumber(t.topspeed) then
                tuneTopMul = math.clamp(tonumber(t.topspeed), 0.3, 4.0)
            end
        end
    end
    -- 联动系数：极速倍率提升时，直道基准线性放大、弯道获得80%提升(避免过弯飞出，有回中辅助兜底)
    local linkGain = 1 + (tuneTopMul - 1) * (tuneLinkNow and 1.0 or 0)
    local corner = math.abs(angle)
    local throttle = 1.0
    local SAFE_MIN = 55
    -- 【v24】弯道系数5.0->7.5：同样曲率下弯道限速更低，避免高速冲弯甩出。
    -- k=0直道仍=200*联动系数(不影响直道速度/调校联动)，只压弯道。
    local safeSpd = (200 * linkGain) / (1 + k * 7.5)
    if safeSpd < SAFE_MIN then safeSpd = SAFE_MIN end
    curvNow, safeSpdNow = k, safeSpd
    local brake = 0
    if cruiseOn then
        -- 【v30 固定速度巡航】忽略弯道限速，把速度锁在滑块的 cruiseSpeed：低了给油、高了点刹、进带滑行。
        local lo, hi = cruiseSpeed * (1 - CRUISE_BAND), cruiseSpeed * (1 + CRUISE_BAND)
        if speed > hi then
            throttle, brake = 0, CRUISE_BRAKE
        elseif speed < lo then
            throttle, brake = 1, 0
        else
            -- 带内：轻油门维持，避免频繁抖动
            throttle, brake = 0.45, 0
        end
        stateText = "定速巡航 " .. math.floor(cruiseSpeed) .. " (当前" .. math.floor(speed) .. ")"
    elseif manualSpdOn then
        -- 【v30 自主调速】油门/刹车直接取滑块值，转向仍由自动驾驶负责
        throttle, brake = manualThrottle, manualBrake
        stateText = "自主调速 油" .. math.floor(manualThrottle * 100) .. "% 刹" .. math.floor(manualBrake * 100) .. "%"
    else
        -- 默认：弯道安全限速
        if speed > safeSpd * 1.02 then
            throttle = tuneLinkNow and 0.25 or 0
            if speed > safeSpd * 1.12 then return 0, 0.5, steer, false end
        elseif speed < safeSpd then
            throttle = 1.0
        else
            throttle = tuneLinkNow and 0.8 or 0.6
        end
        if k > 0.12 then stateText = "过弯限速(曲率" .. string.format("%.2f", k) .. ")" end
    end

    -- 【v17】回起点(游戏自动复位)检测：里程大幅倒退时重置脱困计数。
    -- 旧版recoverCount永不归零(回起点后mapS变小,差值恒为负), 导致永远>4=一卡就回起点。
    if mapS < lastProgressS - 50 then
        recoverCount = 0; stuckT = 0; recoverT = 0; lastProgressS = mapS
    end
    -- 【v17】穿墙/冷却期间暂停卡死脱困：整车幽灵状态低速滑行属正常,
    -- 旧版此时仍累加stuckT->倒车/回起点, 树林/石堆卡点因此永远过不去。
    local inNoclip = os.clock() < noclipCoolUntil
    if not inNoclip then
        local progressed = mapS - lastProgressS > 3
        if progressed then
            lastProgressS = mapS
            stuckT = 0
        else
            stuckT = stuckT + 0.05
        end
        if stuckT > CFG.stuckSec then
            recoverT = CFG.recoverSec
            stuckT = 0
            recoverDir = -recoverDir
            lastProgressS = mapS
            recoverCount = recoverCount + 1
            doNoclip("脱困", nil, nil, true)
        end
        if recoverT > 0 then
            recoverT = recoverT - 0.05
            if recoverCount <= 4 then
                stateText = "卡住-倒车脱困#" .. recoverCount
                return 0, 0.85, recoverDir * 0.7, false
            else
                stateText = "多次脱困失败-游戏复位"
                return 0.85, 0, 0, false
            end
        end
        if mapS - lastProgressS > 8 then recoverCount = 0 end
    else
        stuckT = 0
        stateText = "穿墙推进中"
    end

    -- 【v30】巡航/手动模式已各自设好 stateText，不要被通用"驾驶中"覆盖
    if not cruiseOn and not manualSpdOn then stateText = "驾驶中" end
    return throttle, brake, steer, false
end

--// ---------- 主 override：每帧被 CarInput.Read 调用 ---------- //--
local function override()
    if not enabled or finished then
        return 0, (finished and 1 or 0), 0, false
    end
    local seat = getSeat()
    if not seat then
        stateText = "等待上车"
        return 0, 0, 0, false
    end
    local ok, th, br, st, hb = pcall(computeDrive, seat)
    if not ok then
        stateText = "计算异常(已停)"
        return 0, 1, 0, false
    end
    -- 对策1: 每帧抵消侧向滑移(减小惯性甩尾)，独立于转向计算
    pcall(applyGrip)
    -- 对策3: 障碍物检测 + 自动穿墙
    pcall(updateObstacle)
    -- 【v20】每帧防出界守卫：记录安全点/被推出或坠落则中止穿墙并拉回
    pcall(guardNoclip)
    -- 【v23】自动平移回中：把车横向挪回当前里程中心线(保留速度、不瞬移)，解决急弯甩出赛道撞停
    pcall(glideToCenter)
    -- 若本次穿墙已被守卫中止，不再满油门冲，交回正常计算（下一帧基于拉回位置重算）
    if noclipAborted then
        noclipAborted = false
        return 0, 0.5, 0, false
    end
    -- 【v17】穿墙期间强制满油门：整车幽灵状态靠动力冲出障碍, 不靠滑行
    -- 【v30】巡航/手动模式下不再强制满油门，否则会突破设定速度：改用 computeDrive 算出的速度控制值。
    if os.clock() < noclipUntil and not cruiseOn and not manualSpdOn then
        return 1, 0, st, false
    end
    return th, br, st, hb
end

--// ---------- 死亡自动重启：检测 Caught 页面 -> 点 RESTART FROM BEGINNING ---------- //--
local restartCool = 0
local restartCount = 0
local autoRevive = true  -- v18: 自动复活独立开关（默认开），由 _AUTO_REVIVE_SET 控制
local function findRestartBtn()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return nil end
    local caught = pg:FindFirstChild("Caught")
    if not caught then return nil end
    -- 关键：死亡页面用 ScreenGui.Enabled 控制显隐（源码 v10.Enabled=false），不是 Root.Visible
    local okEnabled, enabled = pcall(function() return caught.Enabled end)
    if not okEnabled or enabled ~= true then return nil end
    local root = caught:FindFirstChild("Root")
    local col = root and root:FindFirstChild("Column")
    local btns = col and col:FindFirstChild("Buttons")
    local btn = btns and btns:FindFirstChild("Restart")
    if btn and btn:IsA("TextButton") then return btn end
    return nil
end

local function clickRestart(btn)
    -- 关键：UiKit.button 把回调绑在 Activated（MouseButton1Click 没有连接）
    if getconnections then
        local ok, conns = pcall(getconnections, btn.Activated)
        if ok and type(conns) == "table" then
            for _, c in ipairs(conns) do
                local okF, fn = pcall(function() return c.Function end)
                if okF and type(fn) == "function" then
                    -- 带按钮作为参数调用（回调签名 function(btn)）
                    pcall(fn, btn)
                    return true, "Activated.Function"
                end
            end
        end
    end
    return false, "no valid connection"
end

local guardConn = RunService.Heartbeat:Connect(function(dt)
    if not enabled then return end
    restartCool = restartCool - dt
    if restartCool > 0 then return end
    local btn = findRestartBtn()
    if btn and autoRevive then
        stateText = "死亡->自动重启 #" .. (restartCount + 1)
        local ok, method = clickRestart(btn)
        restartCount = restartCount + 1
        restartCool = 3.0  -- 冷却3秒，避免重复点
        mapS = 0
        lastProgressS = 0
        stuckT = 0
        print("[AutoDriveV2] 检测到死亡，触发 RESTART (" .. tostring(method) .. ") 第" .. restartCount .. "次")
    end
end)

--// ============================================================ //--
--// 【v31 趣味标签页】倒着开车 / 车旋转 / 车弹跳                    //--
--// 三个都是纯视觉/物理叠加层，默认关闭，关掉立即还原，不影响自动驾驶路径。 //--
--// ============================================================ //--
local funReverse = false   -- 倒着开车：车身视觉翻转180°(车头朝后)，物理/路径照常前进
local funSpin    = false   -- 车旋转：每帧给底盘叠加 Y 轴自转
local funBounce  = false   -- 车弹跳：周期性向上冲量
local funSpinSpeed = 6     -- 自转角速度(rad/s)，可调
local funBouncePower = 35  -- 弹跳向上速度(studs/s)，可调
local funBounceInterval = 0.9 -- 弹跳间隔(秒)
local funBounceT = 0
local funRevCache = nil    -- 翻转用的视觉部件本地变换缓存
local funRevCar = nil      -- 缓存对应的车模型(换车时重建)

-- 收集整车视觉根(车身/轮子)，返回 {o=对象, t="model"|"part", c=相对chassis本地CFrame}
local function collectVisualRoots(car, ch)
    local roots = {}
    for _, nm in ipairs({"Exterior", "Cockpit", "Wheel_FL", "Wheel_FR", "Wheel_RL", "Wheel_RR"}) do
        local m = car:FindFirstChild(nm)
        if m then
            local ok, cur = pcall(function() return m:GetPivot() end)
            if ok then roots[#roots + 1] = { o = m, t = "model", c = ch.CFrame:inverse() * cur } end
        end
    end
    local cabin = car:FindFirstChild("Cabin")
    if cabin and cabin:IsA("BasePart") then
        roots[#roots + 1] = { o = cabin, t = "part", c = ch.CFrame:inverse() * cabin.CFrame }
    end
    return roots
end

-- 把缓存的视觉部件按"是否翻转"写回当前 chassis 姿态
local function applyVisualRoots(flip)
    if not funRevCache or not chassis or not chassis.Parent then return end
    local R = flip and CFrame.Angles(0, math.pi, 0) or CFrame.new()
    for _, r in ipairs(funRevCache) do
        if r.o and r.o.Parent then
            local target = chassis.CFrame * R * r.c
            pcall(function()
                if r.t == "model" then r.o:PivotTo(target) else r.o.CFrame = target end
            end)
        end
    end
end

local funConn = RunService.Heartbeat:Connect(function(dt)
    if not getSeat() then return end
    local ch = chassis
    if not ch or not ch.Parent then return end

    -- ① 倒着开车：换车时重建缓存；每帧写回翻转姿态(覆盖 weld 的默认位置)
    if funReverse then
        local car = ch.Parent
        if car ~= funRevCar then
            funRevCar = car
            funRevCache = collectVisualRoots(car, ch)
        end
        applyVisualRoots(true)
    elseif funRevCache then
        -- 关闭时写回原始姿态一次，然后清空缓存
        applyVisualRoots(false)
        funRevCache = nil
        funRevCar = nil
    end

    -- ② 车旋转：叠加 Y 轴角速度(保留 X/Z 分量，不破坏悬挂稳定)
    if funSpin then
        local av = ch.AssemblyAngularVelocity
        pcall(function()
            ch.AssemblyAngularVelocity = Vector3.new(av.X, funSpinSpeed, av.Z)
        end)
    end

    -- ③ 车弹跳：到间隔且车贴近地面时给向上冲量
    if funBounce then
        funBounceT = funBounceT - dt
        if funBounceT <= 0 then
            local lv = ch.AssemblyLinearVelocity
            -- 只在下落/贴地(vy 较小)时弹，避免空中叠加
            if lv.Y < 6 then
                pcall(function()
                    ch.AssemblyLinearVelocity = Vector3.new(lv.X, funBouncePower, lv.Z)
                end)
                funBounceT = funBounceInterval
            else
                funBounceT = 0.1
            end
        end
    else
        funBounceT = 0
    end
end)

-- 趣味功能控制接口
getgenv()._FUN_REVERSE_SET = function(on)
    funReverse = on and true or false
    if not funReverse then applyVisualRoots(false); funRevCache = nil; funRevCar = nil end
    return "倒着开车=" .. (funReverse and "开" or "关")
end
getgenv()._FUN_SPIN_SET = function(on, speed)
    funSpin = on and true or false
    if type(speed) == "number" then funSpinSpeed = speed end
    return "车旋转=" .. (funSpin and "开" or "关") .. " 速度=" .. tostring(funSpinSpeed)
end
getgenv()._FUN_BOUNCE_SET = function(on, power)
    funBounce = on and true or false
    if type(power) == "number" then funBouncePower = power end
    return "车弹跳=" .. (funBounce and "开" or "关") .. " 力度=" .. tostring(funBouncePower)
end
-- 只调参数、不改开关(供滑块使用)
getgenv()._FUN_SPIN_SPEED = function(v) if type(v)=="number" then funSpinSpeed = v end return funSpinSpeed end
getgenv()._FUN_BOUNCE_POWER = function(v) if type(v)=="number" then funBouncePower = v end return funBouncePower end
getgenv()._FUN_STATUS = function()
    return string.format("倒着开车=%s 车旋转=%s(%.0f) 车弹跳=%s(%.0f)",
        tostring(funReverse), tostring(funSpin), funSpinSpeed, tostring(funBounce), funBouncePower)
end

--// ---------- UI (Obsidian 六标签页: 驾驶 / 透视 / 画面 / 杂项 / 传送 / 趣味) ---------- //--
local function toggleAuto()
    if finished then finished = false; mapS = 0 end
    enabled = not enabled
    if enabled then
        stateText = "初始化中..."
        if not route then
            if not initModules() then enabled = false; stateText = "初始化失败"; return end
        end
        local ok = pcall(function() CarInput.setOverride(override) end)
        if not ok then enabled = false; stateText = "setOverride 失败"; return end
        stateText = "已启动"
    else
        stateText = "已停止"
        pcall(function() if CarInput then CarInput.setOverride(nil) end end)
        local seat = lastSeat
        if seat and seat:IsA("VehicleSeat") then pcall(function() seat.Throttle = 0 end) end
    end
end

if getgenv().__AUTO_OBSIDIAN then
    pcall(function() getgenv().__AUTO_OBSIDIAN:Unload() end)
    getgenv().__AUTO_OBSIDIAN = nil
end

local Obsidian = nil
local uiConn = nil
local obsOkay, obsErr = pcall(function()
    local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
    Obsidian = loadstring(game:HttpGet(repo .. "Library.lua"))()
    getgenv().__AUTO_OBSIDIAN = Obsidian
    Obsidian.ForceCheckbox = false
    local Window = Obsidian:CreateWindow({
        Title = "巫（不要停下）",
        Footer = "驾驶 / 透视 / 画面 / 杂项 / 传送 / 趣味",
        NotifySide = "Right",
        ShowCustomCursor = false,
        AlwaysOnTop = true,
    })

    local function gstat(name)
        local f = getgenv()[name]
        if type(f) ~= "function" then return false end
        local ok, s = pcall(f); return ok and string.find(tostring(s), "=true") ~= nil
    end
    local function gbool(name)  -- 返回 "=true"/"=false" 中的布尔
        local f = getgenv()[name]
        if type(f) ~= "function" then return false end
        local ok, s = pcall(f); return ok and tostring(s):find("true") ~= nil
    end

    ---------- 标签页 1：驾驶 ----------
    local tabDrive = Window:AddTab("驾驶", "car")
    local gd = tabDrive:AddGroupbox({ Side = "Left", Name = "实时状态" })
    -- 【v19修复】Label 不进 Options：保存 AddLabel 返回对象，直接 :SetText()
    local LB = {}
    LB.Status = gd:AddLabel("AP_Status", { Text = "状态：待机", DoesWrap = false })
    LB.Speed  = gd:AddLabel("AP_Speed",  { Text = "速度：0 studs/s", DoesWrap = false })
    LB.Mile   = gd:AddLabel("AP_Mile",   { Text = "里程：0 / 0 m", DoesWrap = false })
    LB.Lat    = gd:AddLabel("AP_Lat",    { Text = "偏离中线：0 m", DoesWrap = false })
    LB.Curve  = gd:AddLabel("AP_Curve",  { Text = "曲率：0.00   安全速度：0", DoesWrap = false })
    gd:AddDivider()
    gd:AddButton({ Text = "▶  启动 / 停止自动驾驶", Func = toggleAuto })
    local gd2 = tabDrive:AddGroupbox({ Side = "Right", Name = "功能开关" })
    -- 自动复活独立成项：状态显示 + 独立开关 + 计数
    LB.Revive    = gd2:AddLabel("AP_Revive", { Text = "自动复活：关闭", DoesWrap = false })
    LB.ReviveCnt = gd2:AddLabel("AP_ReviveCnt", { Text = "已复活次数：0", DoesWrap = false })
    gd2:AddToggle("AP_ReviveTog", { Text = "死亡后自动点 RESTART", Default = false, Callback = function(v)
        local f = getgenv()._AUTO_REVIVE_SET; if type(f)=="function" then pcall(f, v) end
    end })
    gd2:AddDivider()
    gd2:AddToggle("AP_GlideAssist", { Text = "★ 平移辅助转弯(平滑归中/免调)", Default = false, Callback = function(v)
        local f = getgenv()._GLIDE_CENTER_SET; if type(f)=="function" then pcall(f, v) end
    end })
    LB.Guard = gd2:AddLabel("AP_Guard", { Text = "平移归中：0 帧", DoesWrap = false })
    gd2:AddDivider()
    gd2:AddLabel("AP_Help", { Text = "平移辅助转弯：偏离中心线就平滑把车拉回并稳定在中心(帧率无关)，参数内置最安全值：不抛飞/不掉速/不瞬移，无需手动调。已删除出界瞬移拉回。", DoesWrap = true })
    gd2:AddDivider()
    -- 【v30】速度控制：固定速度巡航 + 自主调速（两模式互斥）
    gd2:AddLabel("AP_SpdTitle", { Text = "── 速度控制 ──", DoesWrap = false })
    gd2:AddToggle("AP_CruiseOn", { Text = "① 固定速度巡航(忽略弯道限速)", Default = false, Callback = function(v)
        local f = getgenv()._CRUISE_SET; if type(f)=="function" then pcall(f, v) end
    end })
    gd2:AddSlider("AP_CruiseSpd", { Text = "固定速度值(studs/s)", Default = 90, Min = 10, Max = 200, Rounding = 0, Compact = true,
        Callback = function(v) local f=getgenv()._CRUISE_SPEED_SET; if type(f)=="function" then pcall(f, v) end end })
    gd2:AddToggle("AP_ManualOn", { Text = "② 自主调速(手动油门/刹车)", Default = false, Callback = function(v)
        local f = getgenv()._MANUAL_SPD_SET; if type(f)=="function" then pcall(f, v) end
    end })
    gd2:AddSlider("AP_Throttle", { Text = "手动油门(%)", Default = 60, Min = 0, Max = 100, Rounding = 0, Compact = true,
        Callback = function(v) local f=getgenv()._MANUAL_THROTTLE_SET; if type(f)=="function" then pcall(f, v/100) end end })
    gd2:AddSlider("AP_Brake", { Text = "手动刹车(%)", Default = 0, Min = 0, Max = 100, Rounding = 0, Compact = true,
        Callback = function(v) local f=getgenv()._MANUAL_BRAKE_SET; if type(f)=="function" then pcall(f, v/100) end end })
    LB.SpeedMode = gd2:AddLabel("AP_SpeedMode", { Text = "速度模式：自动", DoesWrap = false })
    gd2:AddLabel("AP_SpdHelp", { Text = "固定速度=滑到哪就一直跑哪(低了给油/高了点刹)。自主调速=油门刹车你自己给，转向仍自动。两者互斥，脱困/穿墙时安全逻辑会临时接管。", DoesWrap = true })

    ---------- 标签页 2：透视 ----------
    local tabEsp = Window:AddTab("透视", "eye")
    local ge = tabEsp:AddGroupbox({ Side = "Left", Name = "显示开关" })
    ge:AddToggle("AP_Monster", { Text = "怪物透视", Default = false, Callback = function(v)
        local f = getgenv()._ESP_MONSTER_SET; if type(f)=="function" then pcall(f, v) end
    end })
    ge:AddToggle("AP_Obstacle", { Text = "障碍物透视", Default = false, Callback = function(v)
        local f = getgenv()._ESP_OBST_SET; if type(f)=="function" then pcall(f, v) end
    end })
    ge:AddToggle("AP_Building", { Text = "建筑透视", Default = false, Callback = function(v)
        local f = getgenv()._ESP_BLDG_SET; if type(f)=="function" then pcall(f, v) end
    end })
    ge:AddToggle("AP_TP", { Text = "第三人称拉远", Default = false, Callback = function(v)
        local f = v and getgenv()._TP_START or getgenv()._TP_STOP
        if type(f) == "function" then pcall(f) end
    end })
    ge:AddToggle("AP_ARROW", { Text = "追击者小箭头 + 距离", Default = false, Callback = function(v)
        local f = v and getgenv()._ARROW_START or getgenv()._ARROW_STOP
        if type(f) == "function" then pcall(f) end
    end })
    -- 【v2】箭头锁定目标名可自定义(默认 Runner)；用 pcall 保护兼容旧库
    pcall(function()
        local getName = getgenv()._ARROW_GET_NAME
        local def = (type(getName)=="function") and getName() or "Runner"
        ge:AddInput("AP_ArrowName", { Text = "箭头锁定目标名", Default = def,
            PlaceholderText = "Runner",
            Callback = function(v)
                local f = getgenv()._ARROW_SET_NAME
                if type(f)=="function" and type(v)=="string" and #v>0 then pcall(f, v) end
            end })
    end)
    ge:AddDivider()
    ge:AddButton({ Text = "全部开启", Func = function()
        local f = getgenv()._ESPA_ALL_ON; if type(f) == "function" then pcall(f) end
    end })
    ge:AddButton({ Text = "全部关闭", Func = function()
        local f = getgenv()._ESPA_ALL_OFF; if type(f) == "function" then pcall(f) end
    end })
    -- 【v19】透视信息面板已移除(用户不需要)

    ---------- 标签页 3：画面 ----------
    local function EXTOG(box, id, text, key, default)
        box:AddToggle(id, { Text = text, Default = default or false, Callback = function(v)
            local f = getgenv()._EX_SET; if type(f)=="function" then pcall(f, key, v) end
        end })
    end
    local tabFx = Window:AddTab("画面", "sun")
    local gfx = tabFx:AddGroupbox({ Side = "Left", Name = "夜视 / 视距" })
    EXTOG(gfx, "FX_Night",   "★ 夜视模式(提亮环境)", "nightvision", false)
    EXTOG(gfx, "FX_Far",     "★ 超远视距(拉远雾)", "farview", false)
    EXTOG(gfx, "FX_NoFog",   "无雾模式(极限视距)", "nofog", false)
    EXTOG(gfx, "FX_Day",     "锁定白天(正午)", "day", false)
    EXTOG(gfx, "FX_Dusk",    "锁定黄昏(暖光)", "dusk", false)
    EXTOG(gfx, "FX_NoShade", "关闭阴影(更亮)", "noshadow", false)
    EXTOG(gfx, "FX_HQ",      "高清渲染(未来画质)", "hq", false)
    EXTOG(gfx, "FX_Fov",     "广角视野(FOV110)", "fov", false)
    local gfx2 = tabFx:AddGroupbox({ Side = "Right", Name = "屏幕叠加" })
    EXTOG(gfx2, "FX_FpsCnt",  "FPS 实时显示", "fpscounter", false)
    EXTOG(gfx2, "FX_Coord",   "坐标实时显示", "coord", false)
    EXTOG(gfx2, "FX_Cross",   "屏幕准星", "crosshair", false)
    EXTOG(gfx2, "FX_HideHud", "隐藏叠加HUD", "hidehud", false)
    EXTOG(gfx2, "FX_FpsUnlock", "解除帧率限制", "fpsunlock", false)
    EXTOG(gfx2, "FX_Mute",      "全局静音", "mute", false)
    gfx2:AddDivider()
    gfx2:AddLabel("FX_Info", { Text = "夜视/视距类同时只生效安全叠加；全部功能默认关闭，随时可切回游戏原样。已移除无效的角色能力功能(本游戏为驾驶游戏，角色不可控)。", DoesWrap = true })

    ---------- 标签页 4：杂项 ----------
    local tabMisc = Window:AddTab("杂项", "settings")
    local gm = tabMisc:AddGroupbox({ Side = "Left", Name = "系统" })
    gm:AddButton({ Text = "重置全部附加功能", Func = function()
        local f = getgenv()._EX_ALL_OFF; if type(f)=="function" then pcall(f) end
    end })
    gm:AddButton({ Text = "⚠ 离开游戏(关闭程序)", Func = function()
        local f = getgenv()._EX_LEAVE; if type(f)=="function" then pcall(f) end
    end })
    gm:AddDivider()
    local gm2 = tabMisc:AddGroupbox({ Side = "Right", Name = "状态" })
    LB.ExStat = gm2:AddLabel("EX_Stat", { Text = "附加功能：全部关闭", DoesWrap = true })
    gm2:AddLabel("EX_Info", { Text = "全部为可选功能，关掉即还原游戏默认，不影响自动驾驶。", DoesWrap = true })

    ---------- 标签页 5：传送 ----------
    local tabTp = Window:AddTab("传送", "rocket")
    local gtp = tabTp:AddGroupbox({ Side = "Left", Name = "直达 / 间歇传送" })
    LB.TpStat = gtp:AddLabel("AP_TPStat", { Text = "终点坐标：未探测", DoesWrap = true })
    gtp:AddButton({ Text = "① 探测终点坐标", Func = function()
        local f = getgenv()._TP_PROBE; if type(f)=="function" then
            local ok, v = pcall(f); if ok and LB.TpStat then pcall(function() LB.TpStat:SetText(v) end) end
        end
    end })
    gtp:AddButton({ Text = "★ 一键通关(推荐:自动分段冲线)", Func = function()
        local f = getgenv()._TP_AUTO_FINISH; if type(f)=="function" then
            local ok, v = pcall(f); if ok and LB.TpStat then pcall(function() LB.TpStat:SetText(v) end) end
        end
    end })
    gtp:AddButton({ Text = "② 间歇传送(分段推进)", Func = function()
        local f = getgenv()._TP_INTERMITTENT; if type(f)=="function" then pcall(f) end
    end })
    gtp:AddButton({ Text = "③ 直达终点(易被复位,不推荐)", Func = function()
        local f = getgenv()._TP_FINISH; if type(f)=="function" then pcall(f) end
    end })
    gtp:AddButton({ Text = "■ 停止传送", Func = function()
        local f = getgenv()._TP_STOP; if type(f)=="function" then pcall(f) end
    end })
    gtp:AddDivider()
    local gtps = tabTp:AddGroupbox({ Side = "Right", Name = "传送参数(保守)" })
    gtps:AddSlider("AP_TPStep", { Text = "每段步长(米)", Default = 55, Min = 15, Max = 150, Rounding = 0, Compact = true,
        Callback = function(v) local f=getgenv()._TP_SET; if type(f)=="function" then pcall(f, v, nil, nil) end end })
    gtps:AddSlider("AP_TPDelay", { Text = "每段间隔(秒)", Default = 0.35, Min = 0.1, Max = 1.5, Rounding = 2, Compact = true,
        Callback = function(v) local f=getgenv()._TP_SET; if type(f)=="function" then pcall(f, nil, v, nil) end end })
    gtps:AddSlider("AP_TPSpeed", { Text = "落点速度", Default = 105, Min = 0, Max = 180, Rounding = 0, Compact = true,
        Callback = function(v) local f=getgenv()._TP_SET; if type(f)=="function" then pcall(f, nil, nil, v) end end })
    LB.TpLive = gtps:AddLabel("AP_TPLive", { Text = "传送状态：待机", DoesWrap = true })
    gtps:AddLabel("AP_TPHelp", { Text = "一键通关=小步分段+落点带速度冲线，最像真实行驶、最不易被反作弊复位。步长越小越稳但越慢。", DoesWrap = true })

    ---------- 标签页 6：趣味 ----------
    local tabFun = Window:AddTab("趣味", "star")
    local gfun = tabFun:AddGroupbox({ Side = "Left", Name = "趣味玩法(默认关,可还原)" })
    gfun:AddToggle("FUN_Reverse", { Text = "倒着开车(车头朝后)", Default = false, Callback = function(v)
        local f = getgenv()._FUN_REVERSE_SET; if type(f)=="function" then pcall(f, v) end
    end })
    gfun:AddToggle("FUN_Spin", { Text = "车旋转(原地打转)", Default = false, Callback = function(v)
        local f = getgenv()._FUN_SPIN_SET; if type(f)=="function" then pcall(f, v) end
    end })
    gfun:AddToggle("FUN_Bounce", { Text = "车弹跳(一路蹦跶)", Default = false, Callback = function(v)
        local f = getgenv()._FUN_BOUNCE_SET; if type(f)=="function" then pcall(f, v) end
    end })
    gfun:AddDivider()
    local gfun2 = tabFun:AddGroupbox({ Side = "Right", Name = "参数与说明" })
    gfun2:AddSlider("FUN_SpinSpd", { Text = "旋转速度", Default = 6, Min = 1, Max = 20, Rounding = 0, Compact = true,
        Callback = function(v) local f=getgenv()._FUN_SPIN_SPEED; if type(f)=="function" then pcall(f, v) end end })
    gfun2:AddSlider("FUN_BouncePow", { Text = "弹跳力度", Default = 35, Min = 10, Max = 80, Rounding = 0, Compact = true,
        Callback = function(v) local f=getgenv()._FUN_BOUNCE_POWER; if type(f)=="function" then pcall(f, v) end end })
    LB.FunStat = gfun2:AddLabel("FUN_Stat", { Text = "状态：全部关闭", DoesWrap = true })
    gfun2:AddLabel("FUN_Help", { Text = "趣味功能只做视觉/物理叠加，不影响自动驾驶的转向与路径。关掉立即还原游戏原样。弹跳/旋转幅度大时可能翻车或掉出赛道，属正常娱乐效果。", DoesWrap = true })

    -- UI 刷新（8Hz 节流）
    local lastUi = 0
    local function safeSet(lbl, txt)
        if lbl then pcall(function() lbl:SetText(txt) end) end
    end
    uiConn = RunService.Heartbeat:Connect(function()
        local now = os.clock()
        if now - lastUi < 0.125 then return end
        lastUi = now
        local pct = 0
        if FinishS ~= math.huge and FinishS > 0 then pct = math.clamp(mapS / FinishS, 0, 1) end
        -- 【v19修复】直接对保存的 Label 对象 SetText，不再走 Options(那里没有 label)
        safeSet(LB.Status, "状态：" .. stateText)
        safeSet(LB.Speed,  string.format("速度：%.0f studs/s", speed))
        safeSet(LB.Mile,   string.format("里程：%.0f / %s m  (%.0f%%)", mapS,
            FinishS == math.huge and "∞" or tostring(math.floor(FinishS)), pct * 100))
        safeSet(LB.Lat,    string.format("偏离中线：%.1f m   侧滑：%.1f", mapLateral, sideSlip))
        safeSet(LB.Curve,  string.format("曲率：%.2f   安全速度：%.0f", curvNow, safeSpdNow))
        safeSet(LB.Guard,  "平移归中：" .. tostring(glidePulls) .. " 帧")
        -- 自动复活
        safeSet(LB.Revive, "自动复活：" .. (autoRevive and "开启" or "关闭"))
        safeSet(LB.ReviveCnt, "已复活次数：" .. tostring(restartCount))
        -- 【v30】速度模式实时状态
        safeSet(LB.SpeedMode, "速度模式：" .. (cruiseOn and ("定速 " .. math.floor(cruiseSpeed)) or
            (manualSpdOn and ("手动 油" .. math.floor(manualThrottle*100) .. "% 刹" .. math.floor(manualBrake*100) .. "%") or "自动(弯道限速)")))
        -- 附加功能状态（杂项页）
        local exs=getgenv()._EX_STATUS
        if type(exs)=="function" then local ok,v=pcall(exs); if ok then
            local onCnt=0; for w in v:gmatch(":开") do onCnt=onCnt+1 end
            safeSet(LB.ExStat, "附加功能开启：" .. tostring(onCnt) .. " 项")
        end end
        -- 传送状态
        local tps=getgenv()._TP_STATUS
        if type(tps)=="function" then local ok,v=pcall(tps); if ok and LB.TpLive then safeSet(LB.TpLive, "传送状态：" .. v) end end
        -- 【v31】趣味状态
        local fs=getgenv()._FUN_STATUS
        if type(fs)=="function" then local ok,v=pcall(fs); if ok and LB.FunStat then safeSet(LB.FunStat, "状态：" .. v) end end
    end)
end)
if not obsOkay then
    warn("[AutoDriveV19] Obsidian UI 加载失败：" .. tostring(obsErr))
end

-- 自动复活独立开关（控制 guardConn 是否点击 RESTART）
getgenv()._AUTO_REVIVE_SET = function(on)
    autoRevive = on and true or false
    return "自动复活=" .. tostring(autoRevive)
end
getgenv()._AUTO_REVIVE_STATUS = function()
    return "自动复活：" .. (autoRevive and "开启" or "关闭")
end

-- 全局控制接口
getgenv()._AUTOPILOT_V2_START = function()
    if not route then
        if not initModules() then return "INIT_FAIL" end
    end
    finished = false
    mapS = 0
    enabled = true
    stateText = "已启动"
    local ok, err = pcall(function() CarInput.setOverride(override) end)
    if not ok then enabled = false; stateText = "setOverride失败"; return "OVR_FAIL:"..tostring(err) end
    return string.format("STARTED FinishS=%s samples=%d", tostring(FinishS), route and #route.samples or 0)
end

getgenv()._AUTOPILOT_V2_STOP = function()
    enabled = false
    finished = false
    pcall(function() if CarInput then CarInput.setOverride(nil) end end)
    stateText = "已停止"
    if conn then conn:Disconnect() end
    if uiConn then uiConn:Disconnect() end
    if guardConn then guardConn:Disconnect() end
    pcall(restoreCollide)
    if Obsidian then pcall(function() Obsidian:Unload() end) end
    if getgenv().__AUTO_OBSIDIAN == Obsidian then getgenv().__AUTO_OBSIDIAN = nil end
end

getgenv()._AUTOPILOT_V2_STATUS = function()
    return string.format("enabled=%s finished=%s state=%s S=%.0f FinishS=%s speed=%.1f lateral=%.1f slip=%.1f restarts=%d obs=%d noclip=%s noclipOn=%s crash=%d recov=%d k=%.2f safe=%.0f last=%s revive=%s recenter=%s rmax=%.2f dead=%.2f link=%s topMul=%.2f pulls=%d gcenter=%s glide=%d cruise=%s/%d manual=%s/%.2f/%.2f fun=%s/%s/%s ui=%s",
        tostring(enabled), tostring(finished), stateText, mapS,
        FinishS == math.huge and "inf" or tostring(FinishS), speed, mapLateral, sideSlip, restartCount,
        obsCount, tostring(os.clock() < noclipUntil), tostring(CFG.noclipEnabled), crashByDrop, recoverCount, curvNow, safeSpdNow, obsHitName,
        tostring(autoRevive), tostring(steerAssistOn), recenterMaxNow, recenterDeadNow, tostring(tuneLinkNow), tuneTopMul, guardPulls,
        tostring(autoGlideCenter), glidePulls,
        tostring(cruiseOn), math.floor(cruiseSpeed), tostring(manualSpdOn), manualThrottle, manualBrake,
        tostring(funReverse), tostring(funSpin), tostring(funBounce),
        obsOkay and "obsidian-6tab" or ("FAIL:"..tostring(obsErr):sub(1,40)))
end

-- 【v21】回中辅助接口
getgenv()._STEER_ASSIST_SET = function(on)
    steerAssistOn = on and true or false
    CFG.steerAssistOn = steerAssistOn
    return "回中辅助=" .. tostring(steerAssistOn)
end
getgenv()._STEER_CAP_SET = function(v)
    local n = tonumber(v)
    if n then steerCapNow = math.clamp(n, 0.28, 1.0) end
    return string.format("转弯软上限=%.2f", steerCapNow)
end
getgenv()._RECENTER_SET = function(v)
    local n = tonumber(v); if n then recenterMaxNow = math.clamp(n, 0.05, 1.5) end
    return string.format("回中力度=%.2f", recenterMaxNow)
end
getgenv()._RECENTER_DEAD_SET = function(v)
    local n = tonumber(v); if n then recenterDeadNow = math.clamp(n, 0.02, 5.0) end
    return string.format("回中死区=%.2f", recenterDeadNow)
end
-- 【v23】自动平移回中总开关(默认开)：偏离中心时横向平移拉回中心线，不手动调中心点
getgenv()._GLIDE_CENTER_SET = function(on)
    autoGlideCenter = on and true or false
    return "自动平移回中=" .. tostring(autoGlideCenter)
end
getgenv()._GLIDE_CENTER_GET = function() return autoGlideCenter end

-- ===== 【v30】速度控制接口 =====
getgenv()._CRUISE_SET = function(on)
    cruiseOn = on and true or false
    if cruiseOn then manualSpdOn = false end  -- 两模式互斥
    return "定速巡航=" .. tostring(cruiseOn)
end
getgenv()._CRUISE_SPEED_SET = function(v)
    local n = tonumber(v)
    if n then cruiseSpeed = math.clamp(n, 10, 200) end
    return string.format("固定速度=%.0f", cruiseSpeed)
end
getgenv()._CRUISE_GET = function() return cruiseOn, cruiseSpeed end
getgenv()._MANUAL_SPD_SET = function(on)
    manualSpdOn = on and true or false
    if manualSpdOn then cruiseOn = false end   -- 两模式互斥
    return "自主调速=" .. tostring(manualSpdOn)
end
getgenv()._MANUAL_THROTTLE_SET = function(v)
    local n = tonumber(v)
    if n then manualThrottle = math.clamp(n, 0, 1) end
    return string.format("手动油门=%.0f%%", manualThrottle * 100)
end
getgenv()._MANUAL_BRAKE_SET = function(v)
    local n = tonumber(v)
    if n then manualBrake = math.clamp(n, 0, 1) end
    return string.format("手动刹车=%.0f%%", manualBrake * 100)
end
getgenv()._SPEED_MODE_STATUS = function()
    return string.format("模式=%s 巡航=%s/%d 手动=油%.0f%%刹%.0f%% 当前速度=%.0f",
        cruiseOn and "定速" or (manualSpdOn and "手动" or "自动"),
        tostring(cruiseOn), math.floor(cruiseSpeed),
        manualThrottle * 100, manualBrake * 100, speed)
end
getgenv()._TUNE_LINK_SET = function(on)
    tuneLinkNow = on and true or false
    CFG.tuneLinkSpeed = tuneLinkNow
    return "调校联动=" .. tostring(tuneLinkNow)
end

-- 【v22】穿墙总开关：关掉后撞树/石头靠转向绕行，杜绝穿墙把车带出赛道触发强制复位
getgenv()._NOCLIP_SET = function(on)
    CFG.noclipEnabled = on and true or false
    return "穿墙=" .. tostring(CFG.noclipEnabled)
end
getgenv()._NOCLIP_GET = function() return CFG.noclipEnabled end

print("[AutoDriveV28] 已注入(平移辅助转弯 + 穿墙防复位 + 保守传送 + 6标签UI)。附加功能包独立注入。调用 getgenv()._AUTOPILOT_V2_START() 启动。")
]=]

getgenv().__SRC_ESP = [=[
--[[
  v4：透视 + 第三人称 + 小箭头（只指追击者Runner）+ 帧率优化 + 建筑高亮
  改动：
   1) 追击者 Runner 的身体其实在 RunnerSkin(Body/Dark/Hard/Face)，旧版只高亮 Runner 本体的头(Face/Chin) -> 改为高亮 RunnerSkin 全部身体大部件
   2) 小箭头去掉方框/底框，只留一个纯箭头 TextLabel，目标锁定 Runner(追击者)
   3) 帧率优化：关阴影/关粒子/减少高亮/降低扫描频率/缩短距离
   4) 建筑高亮：Map.Places 下大体积 CanCollide(Dome/Walls/Base/Hut/TentWall...) 青色高亮
]]
local lp = game.Players.LocalPlayer
local WS = game.Workspace
local RS = game:GetService("RunService")
local cam = WS.CurrentCamera
local PG = lp:WaitForChild("PlayerGui")

local CFG = {
    monsterFill=Color3.fromRGB(255,25,25), monsterOutline=Color3.fromRGB(255,130,130),
    chaserFill=Color3.fromRGB(255,0,0), chaserOutline=Color3.fromRGB(255,180,180),
    carFill=Color3.fromRGB(255,150,20), carOutline=Color3.fromRGB(255,220,100),
    obstFill=Color3.fromRGB(255,190,30), obstOutline=Color3.fromRGB(255,240,130),
    bldgFill=Color3.fromRGB(40,200,255), bldgOutline=Color3.fromRGB(180,245,255), -- 建筑：青色
    fillTrans=0.5, outlineTrans=0.0, maxParts=3, scanInterval=0.45, maxDist=400,
    tpDist=38, tpHeight=17, lerp=0.16,
    ownCarDist=30,
    perfMode=true,
}
local espOn, tpOn, arrowOn = false, false, false
-- v6: 怪物透视 / 障碍透视 / 建筑透视 拆成独立开关
local monsterOn, obstOn, bldgOn = true, true, true
local highlights = {}
local scanConn, tpConn, arrowConn = nil, nil, nil
local lastScan, monsterCount, obstCount, carCount, bldgCount = 0, 0, 0, 0, 0
local sampleMonsters, sampleObst, sampleBldg = {}, {}, {}
local chaserPart = nil   -- 追击者 Runner 的身体部件（用于箭头定位）

local MOB_SKIP={"runnervoice","runnerskin","steeplefx","thrown","voice","fx","decal"}
local OBST_EXCLUDE={"rail","fence","barrier","barricade","guardrail","railing","hedge","mesh","net",
    "road","floor","ground","terrain","surface","asphalt","lane","sidewalk","curb","patch",
    "spawn","checkpoint","finish","start","trigger","boundary","invisible","collision",
    "snowfall","squall","drift","shutter","windscreen","voxelfx","streamfocus","frostmover"}
local OBST_KW={"log","stump","rock","stone","crate","barrel","cone","debris","wreck","rubble","boulder","buriedcar","outcrop"}
-- 建筑关键词（大体积 CanCollide 建筑/设施，需高亮）
local BLDG_KW={"dome","walls","wall","base","hut","tentwall","abutment","pier","girder","deck",
    "building","cabin","shed","garage","house","silo","tank","tower","radome","outpost","depot",
    "roof","pillar","post","porch","platform","catwalk","bridge","walkway","foundation",
    "barn","stall","shack","lodge","chalet","station","mill","warehouse","shelter","tent"}
local MONSTER_FOLDERS={"ClientMonsters","Monsters","ClientMobs","Enemies","Mobs","Zombies","NPCs"}

local function lower(s) return tostring(s):lower() end
local function skipMob(n) n=lower(n) for _,x in ipairs(MOB_SKIP) do if n==x or n:find(x,1,true) then return true end end return false end
local function obstExcl(n) n=lower(n) for _,x in ipairs(OBST_EXCLUDE) do if n:find(x,1,true) then return true end end return false end
local function obstKw(n) n=lower(n) for _,k in ipairs(OBST_KW) do if n:find(k,1,true) then return true end end return false end
local function bldgKw(n) n=lower(n) for _,k in ipairs(BLDG_KW) do if n:find(k,1,true) then return true end end return false end
-- 【v5 关键修复】"我"的位置必须是玩家正乘坐的车，而不是角色 HRP。
-- 赛车游戏里角色 HRP 常停在出生点/车外，用它算距离会虚高到 1000+ 米，
-- 也会让第三人称镜头跟着错误的点。返回 (部件, 是否车辆)。
local function getMyCar()
    local ch=lp.Character; if not ch then return nil end
    local hum=ch:FindFirstChildOfClass("Humanoid")
    local sp=hum and hum.SeatPart
    if sp and (sp:IsA("VehicleSeat") or sp:IsA("Seat")) then
        local car=sp.Parent and sp.Parent.Parent
        local base=car and (car:FindFirstChild("Chassis") or car:FindFirstChild("Body") or car:FindFirstChildWhichIsA("BasePart"))
        if base and base:IsA("BasePart") then return base end
        return sp
    end
    return nil
end
local function playerRoot()
    local car=getMyCar()
    if car then return car end
    local ch=lp.Character; if not ch then return nil end
    return ch:FindFirstChild("HumanoidRootPart") or ch:FindFirstChildWhichIsA("BasePart")
end

local function addHL(part, fill, outline)
    if not part or not part.Parent then return end
    if highlights[part] then local h=highlights[part]; h.FillColor,h.OutlineColor=fill,outline; return end
    pcall(function()
        local h=Instance.new("Highlight"); h.Name="ESPA_HL"
        h.FillColor=fill; h.OutlineColor=outline
        h.FillTransparency=CFG.fillTrans; h.OutlineTransparency=CFG.outlineTrans
        h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop; h.Parent=part
        highlights[part]=h
    end)
end
-- 高亮模型：limit=上限；limit=0 表示全部
local function hlModel(model, fill, outline, pp, limit)
    limit = limit or CFG.maxParts
    local parts={}
    for _,o in ipairs(model:GetDescendants()) do
        if o:IsA("BasePart") and o~=pp then local sz=o.Size; parts[#parts+1]={o,sz.X*sz.Y*sz.Z} end
    end
    table.sort(parts,function(a,b) return a[2]>b[2] end)
    local cnt = limit==0 and #parts or math.min(#parts,limit)
    for i=1,cnt do addHL(parts[i][1],fill,outline) end
end
local function prune(pp)
    for part,h in pairs(highlights) do
        local keep=false
        if part.Parent and pp then keep=(part.Position-pp).Magnitude<=CFG.maxDist*1.2 end
        if not keep then pcall(function() h:Destroy() end); highlights[part]=nil end
    end
end
local function clearHL()
    for part,h in pairs(highlights) do pcall(function() h:Destroy() end); highlights[part]=nil end
    monsterCount,obstCount,carCount,bldgCount=0,0,0,0
    chaserPart=nil
end

local function scan()
    local pr=playerRoot(); local pp=pr and pr.Position or nil
    local mc,oc,cc,bc=0,0,0,0
    sampleMonsters,sampleObst,sampleBldg={},{},{}
    local bestChaser, bestChaserDist = nil, 1e12
    -- 怪物（v6: 受 monsterOn 独立开关控制）
    for _,fn in ipairs(MONSTER_FOLDERS) do
        local f=WS:FindFirstChild(fn)
        if f and monsterOn then
            for _,o in ipairs(f:GetChildren()) do
                if o:IsA("Model") and not skipMob(o.Name) then
                    local root=o:FindFirstChild("HumanoidRootPart") or o:FindFirstChildWhichIsA("BasePart")
                    if root and pp then
                        local d=(root.Position-pp).Magnitude
                        if d<=CFG.maxDist then
                            local isChaser = (lower(o.Name)==lower(chaserModelName))
                            if isChaser then
                                -- 追击者：身体在 RunnerSkin，全部高亮
                                local skin = f:FindFirstChild("RunnerSkin")
                                if skin then
                                    hlModel(skin, CFG.chaserFill, CFG.chaserOutline, pp, 0)
                                end
                                hlModel(o, CFG.chaserFill, CFG.chaserOutline, pp, 0)
                                -- 【v8】箭头定位只认真实 HRP；没有 HRP 就不锁，绝不退回 Body/root(会跳到别的NPC)
                                local hrp = o:FindFirstChild("HumanoidRootPart")
                                if hrp and hrp:IsA("BasePart") then
                                    bestChaser = hrp; bestChaserDist = d
                                end
                            else
                                hlModel(o,CFG.monsterFill,CFG.monsterOutline,pp)
                            end
                            mc=mc+1
                            if #sampleMonsters<8 then sampleMonsters[#sampleMonsters+1]=o.Name..(isChaser and "★" or "") end
                        end
                    end
                end
            end
        end
    end
    chaserPart = bestChaser
    -- 别人的车
    local cars=WS:FindFirstChild("Cars")
    if cars then
        for _,o in ipairs(cars:GetChildren()) do
            if o:IsA("Model") then
                local root=o:FindFirstChild("Body") or o:FindFirstChild("Chassis") or o:FindFirstChildWhichIsA("BasePart")
                if root and pp then
                    local d=(root.Position-pp).Magnitude
                    if d>CFG.ownCarDist and d<=CFG.maxDist then
                        hlModel(o,CFG.carFill,CFG.carOutline,pp); cc=cc+1
                    end
                end
            end
        end
    end
    -- 建筑 + 散落障碍：Map 下
    -- 【v9修复】旧版遍历 map:GetDescendants() 且有 n>6000 上限；新图 Trees(5626)+Roadside(2527)
    -- 排在 Places 之前，扫到上限就 break，导致 Places 里的建筑/障碍一个都扫不到（计数恒0）。
    -- 改为只遍历含建筑/障碍的相关子文件夹，跳过海量无关树木，且不设硬上限。
    local map=WS:FindFirstChild("Map")
    if map then
        local scanFolders={"Places","Roadside","Roadblocks","Landmarks","Wayside","RoadDetail","Jumps"}
        for _,sf in ipairs(scanFolders) do
            local folder=map:FindFirstChild(sf)
            if folder then
                for _,o in ipairs(folder:GetDescendants()) do
                    if o:IsA("BasePart") and o.CanCollide then
                        local sz=o.Size; local vol=sz.X*sz.Y*sz.Z
                        local hi=math.max(sz.X,sz.Y,sz.Z)
                        local fullName = o:GetFullName()
                        local inPlaces = string.find(fullName, "Map.Places", 1, true) ~= nil
                        -- 【v9修复】障碍优先：Rock/Wreck/BuriedCar/Outcrop 即便在 Places 下也算障碍，
                        -- 不再被 inPlaces 吞进建筑；建筑只在"非障碍"里判定。
                        -- BuriedCar.Body 这类 Name="Body" 需靠 FullName 命中障碍词。
                        local isObst = (obstKw(o.Name) or obstKw(fullName)) and not obstExcl(o.Name)
                        local isBldg = (not isObst) and ((inPlaces and vol>80 and hi>=1.5) or (bldgKw(o.Name) and vol>100)) and not obstExcl(o.Name)
                        local want = (isBldg and bldgOn) or (isObst and obstOn)
                        if pp and want and (o.Position-pp).Magnitude<=CFG.maxDist then
                            if isObst and obstOn then
                                addHL(o,CFG.obstFill,CFG.obstOutline); oc=oc+1
                                if #sampleObst<10 then sampleObst[#sampleObst+1]=o.Name end
                            elseif isBldg and bldgOn then
                                addHL(o,CFG.bldgFill,CFG.bldgOutline); bc=bc+1
                                if #sampleBldg<12 then sampleBldg[#sampleBldg+1]=o.Name end
                            end
                        end
                    end
                end
            end
        end
    end
    monsterCount,obstCount,carCount,bldgCount=mc,oc,cc,bc
    prune(pp)
end

-- 帧率优化：一次性关闭阴影/粒子等重负载特效
local perfApplied=false
local function applyPerf()
    if perfApplied or not CFG.perfMode then return end
    perfApplied=true
    pcall(function() game:GetService("Lighting").GlobalShadows=false end)   -- 关阴影
    pcall(function()
        local L=game:GetService("Lighting")
        L.Brightness = math.min(L.Brightness, 1.0)
    end)
    local cnt=0
    for _,o in ipairs(WS:GetDescendants()) do
        if o:IsA("ParticleEmitter") then pcall(function() o.Enabled=false end); cnt=cnt+1 end
        if o:IsA("Trail") then pcall(function() o.Enabled=false end) end
        if o:IsA("Smoke") or o:IsA("Fire") or o:IsA("Sparkles") then pcall(function() o.Enabled=false end) end
    end
    print("[PERF] 关阴影+关粒子("..cnt..")+降高亮, 帧率优化已应用")
end

local function espStart()
    if espOn then return "ESP already on" end
    espOn=true
    applyPerf()
    if scanConn then scanConn:Disconnect() end
    scanConn=RS.Heartbeat:Connect(function()
        if not espOn then return end
        local now=os.clock()
        if now-lastScan>=CFG.scanInterval then lastScan=now; pcall(scan) end
    end)
    pcall(scan)
    return string.format("ESP运行中(怪%d/障%d/车%d/建筑%d)",monsterCount,obstCount,carCount,bldgCount)
end
local function espStop()
    espOn=false
    if scanConn then scanConn:Disconnect(); scanConn=nil end
    clearHL(); return "ESP stopped"
end

-- 第三人称
local TP_BIND="ESPA_TP_V4"
local function tpStart()
    if tpOn then return "TP already on" end
    tpOn=true
    pcall(function() lp.CameraMode=Enum.CameraMode.Classic end)
    pcall(function() lp.CameraMinZoomDistance=CFG.tpDist*0.4 end)
    pcall(function() lp.CameraMaxZoomDistance=CFG.tpDist*2.5 end)
    local function placeCam()
        if not tpOn then return end
        local root=playerRoot(); if not root then return end
        pcall(function()
            cam.CameraType=Enum.CameraType.Scriptable
            local dir=cam.CFrame.LookVector
            local flat=Vector3.new(dir.X,0,dir.Z)
            if flat.Magnitude<0.05 then local rd=root.CFrame.LookVector; flat=Vector3.new(rd.X,0,rd.Z) end
            if flat.Magnitude<0.05 then flat=Vector3.new(0,0,-1) end
            flat=flat.Unit
            local camPos=root.Position-flat*CFG.tpDist+Vector3.new(0,CFG.tpHeight,0)
            cam.CFrame=CFrame.lookAt(camPos, root.Position+flat*3+Vector3.new(0,2,0))
        end)
    end
    pcall(function() RS:UnbindFromRenderStep(TP_BIND) end)
    RS:BindToRenderStep(TP_BIND,Enum.RenderPriority.Camera.Value+50,placeCam)
    if tpConn then tpConn:Disconnect() end
    tpConn=RS.RenderStepped:Connect(placeCam)
    return string.format("第三人称(dist=%d,height=%d)",CFG.tpDist,CFG.tpHeight)
end
local function tpStop()
    tpOn=false
    pcall(function() RS:UnbindFromRenderStep(TP_BIND) end)
    pcall(function() cam.CameraType=Enum.CameraType.Custom end)
    pcall(function() lp.CameraMinZoomDistance=0.5 end)
    return "第三人称已恢复"
end

-- 小箭头：纯箭头（无方框无底框），只指追击者 Runner + 距离小字
local arrowGui, arrowIcon, arrowDist
local function charRoot()
    local ch=lp.Character; if not ch then return nil end
    return ch:FindFirstChild("HumanoidRootPart") or ch:FindFirstChildWhichIsA("BasePart")
end
local CHASER_MAX_DIST = 500  -- 【v8】超过500米不再显示箭头
local chaserModelName = "Runner"  -- 【v2】可自定义的追击者模型名(默认 Runner)
local function findChaser()
    -- 【v8 修复：箭头乱跳到别的NPC】
    -- 旧版 chaserPart 缓存失效后会回退到 RunnerSkin 的 Body/Dark/任意部件，
    -- 而 RunnerSkin 是共享皮肤容器、里面的部件会被别的怪物/动画复用 -> 箭头就跳到别的NPC身上。
    -- 新规则：只认 ClientMonsters 下"唯一指定名字"的 Model 的 HumanoidRootPart；
    -- 缓存也必须仍是那个 Model 的 HRP，否则作废重找。宁可不显示，也绝不乱指。
    local function realRunnerHRP()
        local cm=WS:FindFirstChild("ClientMonsters")
        if not cm then return nil end
        local runner=cm:FindFirstChild(chaserModelName)
        if not runner or not runner:IsA("Model") then return nil end
        -- 【v9修复】优先 HRP；新图 Runner 无 HRP（身体是 WeldRoot/Face/Chin 等焊接部件），
        -- 回退到 Runner 模型"自身后裔"里的稳定部件。关键：只在 runner 这个 Model 内部找，
        -- 绝不退回 RunnerSkin 共享容器（那会被别的怪复用导致箭头乱跳）。
        local hrp=runner:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:IsA("BasePart") then return hrp end
        local weld=runner:FindFirstChild("WeldRoot")  -- 焊接根，位置最稳
        if weld and weld:IsA("BasePart") then return weld end
        local best,bestVol=nil,-1
        for _,part in ipairs(runner:GetDescendants()) do
            if part:IsA("BasePart") then
                local s=part.Size; local v=s.X*s.Y*s.Z
                if v>bestVol then bestVol=v; best=part end
            end
        end
        return best
    end
    local want = realRunnerHRP()
    if not want then chaserPart=nil; return nil end
    -- 缓存有效当且仅当它正是当前目标 Model 的 HRP
    if chaserPart and chaserPart.Parent and chaserPart == want then return chaserPart end
    chaserPart = want
    return want
end
local function arrowStart()
    if arrowOn then return "Arrow already on" end
    arrowOn=true
    for _,g in ipairs(PG:GetChildren()) do if g.Name=="RunnerArrowV4" then pcall(function() g:Destroy() end) end end
    arrowGui=Instance.new("ScreenGui"); arrowGui.Name="RunnerArrowV4"
    arrowGui.ResetOnSpawn=false; arrowGui.IgnoreGuiInset=true; arrowGui.DisplayOrder=50; arrowGui.Parent=PG
    -- 只有一个小箭头，无背景、无方框
    arrowIcon=Instance.new("ImageLabel")
    arrowIcon.Name="Arrow"; arrowIcon.Size=UDim2.new(0,34,0,34)
    arrowIcon.AnchorPoint=Vector2.new(0.5,0.5); arrowIcon.BackgroundTransparency=1
    arrowIcon.Image="rbxassetid://4458901886"   -- 三角箭头图标
    arrowIcon.ImageColor3=Color3.fromRGB(255,40,40)
    arrowIcon.Visible=false; arrowIcon.Parent=arrowGui
    -- 距离小字（无背景，跟随箭头下方）
    arrowDist=Instance.new("TextLabel")
    arrowDist.Name="Dist"; arrowDist.Size=UDim2.new(0,80,0,20)
    arrowDist.AnchorPoint=Vector2.new(0.5,0.5); arrowDist.BackgroundTransparency=1
    arrowDist.Text=""; arrowDist.TextColor3=Color3.fromRGB(255,235,120)
    arrowDist.TextStrokeColor3=Color3.new(0,0,0); arrowDist.TextStrokeTransparency=0.3
    arrowDist.Font=Enum.Font.GothamBold; arrowDist.TextSize=15
    arrowDist.Visible=false; arrowDist.Parent=arrowGui
    if arrowConn then arrowConn:Disconnect() end
    arrowConn=RS.RenderStepped:Connect(function()
        if not arrowOn or not arrowIcon then return end
        local target=findChaser()
        local pr=playerRoot()
        if not target or not pr then arrowIcon.Visible=false; if arrowDist then arrowDist.Visible=false end; return end
        local dist=(target.Position-pr.Position).Magnitude
        -- 【v8】超过500米不再显示箭头和距离
        if dist > CHASER_MAX_DIST then arrowIcon.Visible=false; if arrowDist then arrowDist.Visible=false end; return end
        local W,H=cam.ViewportSize.X,cam.ViewportSize.Y
        local cx,cy=W/2,H/2
        local vp,front=cam:WorldToViewportPoint(target.Position)
        local dx,dy=vp.X-cx,vp.Y-cy
        if not front then dx,dy=-dx,-dy end
        if math.abs(dx)<0.001 and math.abs(dy)<0.001 then dy=-1 end
        local ang=math.atan2(dy,dx)
        local rx,ry=cx-40,cy-40; if rx<30 then rx=30 end; if ry<30 then ry=30 end
        local ca,sa=math.cos(ang),math.sin(ang)
        local k=1/math.sqrt((ca/rx)^2+(sa/ry)^2)
        arrowIcon.Visible=true
        arrowIcon.Position=UDim2.new(0,cx+ca*k,0,cy+sa*k)
        arrowIcon.Rotation=math.deg(ang)+90   -- 图片朝上，+90对准方向
        if arrowDist then
            arrowDist.Visible=true
            arrowDist.Text=tostring(math.floor(dist+0.5)).."m"
            -- 距离字放箭头外侧偏移一点，避免遮挡箭头
            arrowDist.Position=UDim2.new(0,cx+ca*(k+34),0,cy+sa*(k+34))
        end
    end)
    return "小箭头已开启(只指追击者Runner + 距离)"
end
local function arrowStop()
    arrowOn=false
    if arrowConn then arrowConn:Disconnect(); arrowConn=nil end
    if arrowGui then pcall(function() arrowGui:Destroy() end); arrowGui=nil end
    return "小箭头已关闭"
end

-- 接口
-- v6: 分类独立开关。切换后立即清高亮并重扫，做到即时生效。
local function rescan()
    if not espOn then return end
    pcall(clearHL); pcall(scan)
end
getgenv()._ESP_MONSTER_SET=function(on)
    monsterOn = on and true or false
    rescan()
    return "怪物透视="..tostring(monsterOn)
end
getgenv()._ESP_OBST_SET=function(on)
    obstOn = on and true or false
    rescan()
    return "障碍透视="..tostring(obstOn)
end
getgenv()._ESP_BLDG_SET=function(on)
    bldgOn = on and true or false
    rescan()
    return "建筑透视="..tostring(bldgOn)
end
getgenv()._ESP_CAT_STATUS=function()
    return string.format("怪物=%s 障碍=%s 建筑=%s",tostring(monsterOn),tostring(obstOn),tostring(bldgOn))
end

getgenv()._ESP_START=espStart
getgenv()._ESP_STOP=espStop
getgenv()._ESP_STATUS=function()
    local hn=0; for _ in pairs(highlights) do hn=hn+1 end
    return string.format("esp=%s 怪=%d 障=%d 车=%d 建筑=%d 高亮=%d",tostring(espOn),monsterCount,obstCount,carCount,bldgCount,hn)
end
getgenv()._ESP_NAMES=function()
    return "怪{"..table.concat(sampleMonsters,",").."} 建筑{"..table.concat(sampleBldg,",").."} 障碍{"..table.concat(sampleObst,",").."}"
end
getgenv()._TP_START=tpStart
getgenv()._TP_STOP=tpStop
getgenv()._TP_STATUS=function()
    return string.format("tp=%s camType=%s",tostring(tpOn),tostring(cam.CameraType))
end
getgenv()._ARROW_START=arrowStart
getgenv()._ARROW_STOP=arrowStop
-- 【v2】自定义箭头锁定目标名：改后立即重扫并重置缓存
getgenv()._ARROW_SET_NAME=function(name)
    if type(name)=="string" and #name>0 then chaserModelName=name; chaserPart=nil end
    return "箭头锁定目标="..chaserModelName
end
getgenv()._ARROW_GET_NAME=function() return chaserModelName end
getgenv()._ARROW_STATUS=function()
    local t=findChaser()
    local car=getMyCar()
    local ch=charRoot()
    local carD=(t and car) and math.floor((t.Position-car.Position).Magnitude+0.5) or -1
    local chD=(t and ch) and math.floor((t.Position-ch.Position).Magnitude+0.5) or -1
    return string.format("arrow=%s visible=%s target=%s 车距=%dm 角色距=%dm",
        tostring(arrowOn),tostring(arrowIcon and arrowIcon.Visible),tostring(t and t.Name or "无"),carD,chD)
end
-- 距离严谨性诊断：同时打印车/角色/箭头目标三者坐标，核对基准点
getgenv()._POS_DIAG=function()
    local function vstr(p) return p and string.format("(%.0f,%.0f,%.0f)",p.X,p.Y,p.Z) or "nil" end
    local car=getMyCar(); local ch=charRoot(); local t=findChaser()
    local carP=car and car.Position; local chP=ch and ch.Position; local tP=t and t.Position
    local carD=(carP and tP) and math.floor((tP-carP).Magnitude+0.5) or -1
    local chD=(chP and tP) and math.floor((tP-chP).Magnitude+0.5) or -1
    return string.format("车%s 角色%s 目标%s(%s) | 车距=%dm 角色距=%dm",
        vstr(carP),vstr(chP),tostring(t and t.Name or "无"),vstr(tP),carD,chD)
end
getgenv()._PERF_STATUS=function()
    local l=game:GetService("Lighting")
    local pe=0; for _,o in ipairs(WS:GetDescendants()) do if o:IsA("ParticleEmitter") and o.Enabled then pe=pe+1 end end
    return string.format("perf=%s shadows=%s 活跃粒子=%d",tostring(perfApplied),tostring(l.GlobalShadows),pe)
end
getgenv()._ESPA_ALL_ON=function()
    monsterOn,obstOn,bldgOn=true,true,true
    local a=espStart(); local b=tpStart(); local c=arrowStart()
    rescan()
    return a.." | "..b.." | "..c
end
getgenv()._ESPA_ALL_OFF=function()
    monsterOn,obstOn,bldgOn=false,false,false
    local a=espStop(); local b=tpStop(); local c=arrowStop()
    return a.." | "..b.." | "..c
end

print("[ESPA v4] 已注入。调用 _ESPA_ALL_ON() 开启。")

]=]

getgenv().__SRC_QTE = [=[
-- 特殊怪 QTE 自动应对 v3
-- 修复重点：tap 怪只精确触发 Tap 键(短促点击 begin→延迟 end)，不再把 Hold/Tap 一起乱按。
-- 触发方式：fire 按钮连接(主力) + VirtualInputManager 模拟真实按键(辅助) 双保险。
local RS = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local lp = game.Players.LocalPlayer
local pg = lp:FindFirstChild("PlayerGui")

local CFG = {
    on = true,
    interval = 0.08,
    tapDuration = 0.08,  -- tap 按下到松开时长(短促点击)
    tapRepeat   = 0.26,  -- tap 重复点击间隔(秒)
}

-- 每个按钮独立配置。同一 GUI 每帧只操作"一个"按钮(Tap 排前面优先)，杜绝乱选。
-- style: "tap"  = 短促点击(begin→延迟end→再重复)，适合 Tap 按钮(点击赶走怪)
--        "hold" = 持续按住(begin 保持到界面关闭)，适合 Hold/Crank/Shine
local BTNS = {
    {gui="CrawlerDoor", btn="Tap",   style="tap",  key=Enum.KeyCode.F, vim="tap"},
    {gui="CrawlerDoor", btn="Hold",  style="hold", key=Enum.KeyCode.F, vim="hold"},
    {gui="WindowCrank", btn="Crank", style="hold", key=Enum.KeyCode.F, vim="key"},
    {gui="Flashlight",  btn="Shine", style="hold", key=nil,            vim="mouse"},
}

local stats = {fired=0, vim=0, active="none", ticks=0, events={}, taps=0}
getgenv().__QTE_STATS = stats

local function fireBtn(btn, kind, key)
    local conns = {}
    local sig = kind == "end" and btn.InputEnded or btn.InputBegan
    pcall(function() conns = getconnections(sig) end)
    local n = 0
    for _, c in ipairs(conns) do
        local fn = c.Function
        if type(fn) == "function" then
            local fake = {
                UserInputType = Enum.UserInputType.Keyboard,
                KeyCode = key or Enum.KeyCode.F,
                UserInputState = kind == "end" and Enum.UserInputState.End or Enum.UserInputState.Begin,
            }
            pcall(fn, fake)
            n = n + 1
        end
    end
    return n
end

-- 按按钮名精确匹配(不再遍历乱选)，必须是对话框按钮
local function findBtn(gui, name)
    local g = pg and pg:FindFirstChild(gui)
    if not g then return nil end
    for _, d in ipairs(g:GetDescendants()) do
        if d.Name == name and (d:IsA("TextButton") or d:IsA("ImageButton")) then return d end
    end
    return nil
end

-- 按钮"当前需要操作"：可见 + 可交互(属性读不到时退回可操作)
local function isActionable(btn)
    if not btn then return false end
    local ok, vis, act = pcall(function()
        local v = btn.Visible
        local a = btn.Interactable
        if a == nil then a = true end
        return v, a
    end)
    if not ok then return true end
    return vis ~= false and act ~= false
end

local function doVim(kind, vim, key)
    if not VIM then return end
    pcall(function()
        key = key or Enum.KeyCode.F
        if vim == "key" or vim == "hold" then
            VIM:SendKeyEvent(kind == "begin", key, false, game)
        elseif vim == "tap" then
            VIM:SendKeyEvent(true, key, false, game)
            task.delay(CFG.tapDuration, function()
                VIM:SendKeyEvent(false, key, false, game)
            end)
        elseif vim == "mouse" then
            local vs = game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.ViewportSize
            local x, y = 100, 100
            if vs then x, y = vs.X / 2, vs.Y / 2 end
            VIM:SendMouseButtonEvent(x, y, 0, kind == "begin", game, 0)
        end
    end)
    stats.vim = stats.vim + 1
end

local loopConn = nil
local acc = 0
local holdState = {}   -- [btn]=true 已按下, 防重复 begin
local lastTap = 0

local function releaseAll()
    for btn, _ in pairs(holdState) do
        if btn and btn.Parent then
            stats.fired = stats.fired + fireBtn(btn, "end", Enum.KeyCode.F)
        end
        holdState[btn] = nil
    end
end

local function tick(dt)
    stats.ticks = stats.ticks + 1
    if not CFG.on then return end
    acc = acc + dt
    if acc < CFG.interval then return end
    acc = 0

    local now = os.clock()
    local chosen = {}   -- [gui]=entry, 每个 GUI 只选一个按钮操作
    local anyActive = nil

    for _, e in ipairs(BTNS) do
        local g = pg and pg:FindFirstChild(e.gui)
        local enabled = false
        pcall(function() enabled = g and g.Enabled end)
        if enabled and not chosen[e.gui] then
            local btn = findBtn(e.gui, e.btn)
            if isActionable(btn) then
                chosen[e.gui] = e
                anyActive = e.gui .. "." .. e.btn
                if e.style == "tap" then
                    -- 短促点击：每 tapRepeat 点一次，绝不与其它按钮同时乱按
                    if now - lastTap >= CFG.tapRepeat then
                        stats.fired = stats.fired + fireBtn(btn, "begin", e.key)
                        stats.taps = stats.taps + 1
                        task.delay(CFG.tapDuration, function()
                            stats.fired = stats.fired + fireBtn(btn, "end", e.key)
                        end)
                        doVim("begin", e.vim, e.key)
                        stats.events[e.gui .. "." .. e.btn] = (stats.events[e.gui .. "." .. e.btn] or 0) + 1
                        lastTap = now
                    end
                else
                    -- 长按：只 begin 一次后保持
                    if not holdState[btn] then
                        stats.fired = stats.fired + fireBtn(btn, "begin", e.key)
                        doVim("begin", e.vim, e.key)
                        holdState[btn] = true
                        stats.events[e.gui .. "." .. e.btn] = (stats.events[e.gui .. "." .. e.btn] or 0) + 1
                    end
                end
            end
        end
    end

    -- 界面已关闭/切换的按钮：松开，避免残留按住
    for btn, _ in pairs(holdState) do
        local stillNeed = false
        for _, e in pairs(chosen) do
            if findBtn(e.gui, e.btn) == btn then stillNeed = true end
        end
        if not stillNeed then
            stats.fired = stats.fired + fireBtn(btn, "end", Enum.KeyCode.F)
            doVim("end", "key", Enum.KeyCode.F)
            holdState[btn] = nil
        end
    end

    stats.active = anyActive or "none"
end

if getgenv().__QTE_CONN then pcall(function() getgenv().__QTE_CONN:Disconnect() end) end
loopConn = RS.Heartbeat:Connect(tick)
getgenv().__QTE_CONN = loopConn

getgenv()._QTE_ON = function() CFG.on = true return "QTE auto ON" end
getgenv()._QTE_OFF = function() CFG.on = false; releaseAll() return "QTE auto OFF" end
getgenv()._QTE_STATUS = function()
    local ev = {}
    for k, v in pairs(stats.events) do ev[#ev+1] = k .. "=" .. v end
    table.sort(ev)
    return string.format("QTE on=%s active=%s fired=%d taps=%d vim=%d ticks=%d events=%s",
        tostring(CFG.on), stats.active, stats.fired, stats.taps, stats.vim, stats.ticks,
        #ev > 0 and table.concat(ev, ",") or "none")
end
-- return removed for loadstring
]=]


getgenv().__SRC_EX = [=[
--[[
  ExtraFeatures v2 — 纯画面/叠加功能包（无角色能力类）
  设计原则：本游戏是驾驶游戏，玩家坐在 DriverSeat 里，角色不可控。
  因此删除全部"角色能力"功能(超级跳/无限跳/低重力/疾跑/隐身/高亮/防坠落)
  ——它们改的是 Humanoid/Character，驾驶时无效或干扰车辆物理。
  只保留改 Lighting/Camera/Sound 的功能，这些与驾驶视角直接相关、可见有效。
  全部默认关闭 / pcall 保护，关掉即还原游戏默认。
  全局接口：_EX_SET(key,on) _EX_GET(key) _EX_ALL_OFF() _EX_STATUS() _EX_LEAVE()
]]
local PS  = game:GetService("Players")
local LP  = PS.LocalPlayer
local WS  = game:GetService("Workspace")
local LIG = game:GetService("Lighting")
local RS  = game:GetService("RunService")
local CAM = WS.CurrentCamera

local function safe(fn, ...) local ok, e = pcall(fn, ...) return ok, e end

-- 【v3修复】默认快照只采样一次并缓存：重注入时沿用第一次的干净默认，绝不重新采样
-- （否则被 hq bug 改过的 Technology=Future 会被误当成"默认"，关掉功能再也回不去）。
-- 首次采样时若发现 Technology 已被旧版残留成 Future，矫正回该游戏默认 Voxel。
-- 版本号：v2 缓存的 DEF 没有 technology 字段或已被污染，遇到就强制重采样
local DEF = getgenv().__EX_DEF
if DEF and (not DEF.technology or DEF.__ver ~= 3) then
    if Enum and Enum.Technology and LIG.Technology == Enum.Technology.Future then
        pcall(function() LIG.Technology = Enum.Technology.Voxel end)  -- 矫正旧版残留
    end
    DEF = nil
    getgenv().__EX_DEF = nil
end
if not DEF then
    DEF = {
        brightness = LIG.Brightness, ambient = LIG.Ambient,
        fogEnd = LIG.FogEnd, fogStart = LIG.FogStart,
        clock = LIG.ClockTime, shadow = LIG.GlobalShadows,
        fov = CAM and CAM.FieldOfView or 70,
        technology = LIG.Technology,
        __ver = 3,
    }
    getgenv().__EX_DEF = DEF
end

local ON = {}
local function isOn(k) return ON[k] and true or false end

-- ===== 画面类（改 Lighting/Camera，驾驶视角可见）=====
local function resetLight()
    safe(function()
        LIG.Brightness = DEF.brightness
        LIG.Ambient = DEF.ambient
        LIG.FogEnd = DEF.fogEnd
        LIG.FogStart = DEF.fogStart
        LIG.ClockTime = DEF.clock
        LIG.GlobalShadows = DEF.shadow
        if DEF.technology then pcall(function() LIG.Technology = DEF.technology end) end  -- 【v3修复】还原渲染技术
        if CAM then CAM.FieldOfView = DEF.fov end
    end)
end
local function applyLight()
    resetLight()
    if isOn("nightvision") then
        safe(function()
            LIG.Brightness = math.max(DEF.brightness, 2.6)
            LIG.Ambient = Color3.new(0.72, 0.78, 0.95)
        end)
    end
    -- 【v3修复】默认 FogEnd 可能已是 100000，硬设 9000 会拉近视距(效果反转)。
    -- 改为"只增不减"：取默认值与目标的较大者，确保视距一定变远。
    if isOn("farview") then safe(function()
        LIG.FogEnd = math.max(DEF.fogEnd, 15000)
        LIG.FogStart = math.max(DEF.fogStart, 6000)
    end) end
    if isOn("nofog") then safe(function()
        LIG.FogEnd = math.max(DEF.fogEnd, 1e7)
        LIG.FogStart = math.max(DEF.fogStart, 5e6)
    end) end
    -- 时间锁定由下方常驻 Heartbeat 循环持续写回（一次性设置会被游戏昼夜循环每帧覆盖）
    if isOn("noshadow") then safe(function() LIG.GlobalShadows = false end) end
    if isOn("hq") then safe(function() pcall(function() LIG.Technology = Enum.Technology.Future end) end) end
    if isOn("fov") then safe(function() if CAM then CAM.FieldOfView = 110 end end) end
end

local function applyMute()
    if isOn("mute") then
        safe(function()
            for _, s in ipairs(WS:GetDescendants()) do
                if s:IsA("Sound") then pcall(function() s.Volume = 0 end) end
            end
        end)
    end
end

local function applyFpsUnlock()
    if isOn("fpsunlock") then
        safe(function() if type(setfpscap) == "function" then setfpscap(0) end end)
    end
end

-- ===== 自建叠加 HUD（FPS / 坐标 / 准星）=====
local hud, fpsLbl, coordLbl, cross
local function hrp()
    local c = LP.Character
    if not c then return nil end
    local h = c:FindFirstChildOfClass("Humanoid")
    return h and h.RootPart or nil
end
local function ensureHUD()
    if hud then return end
    safe(function()
        hud = Instance.new("ScreenGui")
        hud.Name = "EX_HUD"
        hud.ResetOnSpawn = false
        hud.IgnoreGuiInset = true
        hud.Parent = LP:WaitForChild("PlayerGui")
        fpsLbl = Instance.new("TextLabel")
        fpsLbl.Size = UDim2.new(0, 150, 0, 28)
        fpsLbl.Position = UDim2.new(0, 12, 0, 60)
        fpsLbl.BackgroundTransparency = 0.55
        fpsLbl.BackgroundColor3 = Color3.new(0, 0, 0)
        fpsLbl.TextColor3 = Color3.new(0, 1, 0.6)
        fpsLbl.Font = Enum.Font.Code
        fpsLbl.TextSize = 16
        fpsLbl.Text = "FPS 0"
        fpsLbl.Parent = hud
        coordLbl = Instance.new("TextLabel")
        coordLbl.Size = UDim2.new(0, 260, 0, 28)
        coordLbl.Position = UDim2.new(0, 12, 0, 92)
        coordLbl.BackgroundTransparency = 0.55
        coordLbl.BackgroundColor3 = Color3.new(0, 0, 0)
        coordLbl.TextColor3 = Color3.new(1, 0.85, 0.2)
        coordLbl.Font = Enum.Font.Code
        coordLbl.TextSize = 16
        coordLbl.Text = "X 0  Y 0  Z 0"
        coordLbl.Parent = hud
        cross = Instance.new("TextLabel")
        cross.Size = UDim2.new(0, 30, 0, 30)
        cross.Position = UDim2.new(0.5, -15, 0.5, -15)
        cross.BackgroundTransparency = 1
        cross.TextColor3 = Color3.new(1, 1, 1)
        cross.Font = Enum.Font.Code
        cross.TextSize = 22
        cross.Text = "+"
        cross.Parent = hud
    end)
end

-- 【v4修复】时间锁定：游戏每帧用 TimeOfDay 覆盖 ClockTime，一次性设置必被还原。
-- 抽成函数，Heartbeat + Stepped 双循环写回，压住游戏昼夜循环（单循环偶发被抢先一帧）。
local function lockClock()
    if isOn("day") or isOn("dusk") then
        local target = isOn("dusk") and 18.6 or 13
        safe(function()
            LIG.ClockTime = target
            LIG.TimeOfDay = string.format("%02d:%02d:00",
                math.floor(target), math.floor((target % 1) * 60))
        end)
    end
end
local frames, tAcc = 0, 0
-- 【v4b】用 BindToRenderStep 最高优先级(9999)在渲染前最后写回，压住游戏昼夜循环。
-- 数字越大越晚执行，越晚写越能保证是玩家看到的值。
pcall(function()
    RS:BindToRenderStep("EX_ClockLock", 9999, lockClock)
end)
RS.Stepped:Connect(lockClock)  -- 物理步后写回，双保险
RS.Heartbeat:Connect(function(dt)
    lockClock()
    local showFps, showCoord, showCross = isOn("fpscounter"), isOn("coord"), isOn("crosshair")
    local hide = isOn("hidehud")
    if showFps or showCoord or showCross then ensureHUD() end
    if hud then
        safe(function()
            hud.Enabled = not hide and (showFps or showCoord or showCross)
            if fpsLbl then fpsLbl.Visible = showFps end
            if coordLbl then coordLbl.Visible = showCoord end
            if cross then cross.Visible = showCross end
        end)
    end
    frames = frames + 1
    tAcc = tAcc + dt
    if tAcc >= 1 then
        if showFps and fpsLbl then safe(function() fpsLbl.Text = string.format("FPS %d", math.floor(frames / tAcc)) end) end
        frames, tAcc = 0, 0
    end
    if showCoord and coordLbl then
        local r = hrp()
        if r then safe(function() coordLbl.Text = string.format("X %.0f  Y %.0f  Z %.0f", r.Position.X, r.Position.Y, r.Position.Z) end) end
    end
end)

-- ===== 接口 =====
local LIGHT_KEYS = { nightvision=1, farview=1, nofog=1, day=1, dusk=1, noshadow=1, hq=1, fov=1 }
local function apply(key)
    if LIGHT_KEYS[key] then applyLight()
    elseif key == "mute" then applyMute()
    elseif key == "fpsunlock" then applyFpsUnlock() end
end

local VALID = { nightvision=1, farview=1, nofog=1, day=1, dusk=1, noshadow=1, hq=1, fov=1,
    fpsunlock=1, fpscounter=1, coord=1, crosshair=1, hidehud=1, mute=1 }
getgenv()._EX_SET = function(key, on)
    if not VALID[key] then return "BAD_KEY:" .. tostring(key) end
    ON[key] = on and true or false
    pcall(apply, key, ON[key])
    return tostring(key) .. "=" .. tostring(ON[key])
end
getgenv()._EX_GET = function(key) return isOn(key) end
getgenv()._EX_TOGGLE = function(key) return getgenv()._EX_SET(key, not isOn(key)) end
getgenv()._EX_ALL_OFF = function()
    for k in pairs(ON) do ON[k] = false end
    pcall(resetLight)
    safe(function() if hud then hud.Enabled = false end end)
    return "全部附加功能已关闭"
end

local ORDER = { "nightvision", "farview", "nofog", "day", "dusk", "noshadow", "hq", "fov",
    "fpsunlock", "fpscounter", "coord", "crosshair", "hidehud", "mute" }
getgenv()._EX_STATUS = function()
    local parts = {}
    for _, k in ipairs(ORDER) do parts[#parts + 1] = k .. (isOn(k) and ":开" or ":关") end
    return table.concat(parts, " ")
end
getgenv()._EX_LEAVE = function()
    getgenv()._EX_ALL_OFF()
    local ok = safe(function() game:Shutdown() end)
    return ok and "已请求离开游戏" or "已关闭全部功能(此环境不允许直接关游戏)"
end

print("[ExtraFeatures v2] 已注入 14 项纯画面/叠加功能(已删除全部无效角色能力功能)。")
]=]


local function RUN(tag)
  local src=getgenv()["__SRC_"..tag]; local fn,err=loadstring(src)
  if not fn then warn("[1KEY] "..tag.." compile err: "..tostring(err)); return false end
  local ok,e=pcall(fn); if not ok then warn("[1KEY] "..tag.." run err: "..tostring(e)); return false end
  return true
end
RUN("TUNE"); RUN("EX"); RUN("TP"); RUN("AUTO"); RUN("ESP"); RUN("QTE")
local on=getgenv()._ESPA_ALL_ON; if type(on)=="function" then pcall(on) end
local st=getgenv()._AUTOPILOT_V2_START; if type(st)=="function" then print("[1KEY] AUTO:",tostring(pcall(st))) end
print("[1KEY] v22 一键注入完成：回中辅助/车辆联动/穿墙(默认开,可关)/保守传送")
