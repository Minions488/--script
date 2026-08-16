--[[
  Lua Shield Ultra — Protected Script
  Thoi gian tao: 14:30:40 16/8/2026
  Cong cu: Lua Shield Ultra v3.0
]]--

--[[
  Generated: 2026-08-16T06:30:40.779Z
]]--

local _VM = {}
_VM._VERSION = "LuaShieldUltra/3.0"
_VM._FINGERPRINT = "LSU-" .. tostring(math.random(100000,999999)) .. "-" .. tostring(os.time())
_VM.consts = {
  [0] = "print",
  [1] = "[巫 script] 启动",
  [2] = "pcall",
  [3] = "function(",
  [4] = "true -- 设为 false 可临时关闭白名单",
  [5] = "game:GetService(\"Players\").LocalPlayer",
  [6] = "lp.UserId",
  [7] = "string.lower(tostring(lp.Name))",
  [8] = "string.lower(tostring(lp.DisplayName or \"\"))",
  [9] = "string.lower(tostring(n))",
  [10] = "false",
  [11] = "(#WuWhitelistUserIds == 0 and #WuWhitelistNames == 0)",
  [12] = "warn",
  [13] = "[巫 script] 白名单为空：请填写 WuWhitelistUserIds，否则任何人都能进卡密",
  [14] = "3600136747",
  [15] = "setclipboard",
  [16] = "toclipboard",
  [17] = "WuScript_SavedKey.txt",
  [18] = "WuScript_ForceKeyEntry.txt",
  [19] = "by wu",
  [20] = "tostring(pass):gsub(\"%s+\", \"\"):lower()",
  [21] = "tostring(CURRENT_KEY):gsub(\"%s+\", \"\"):lower()",
  [22] = "normalized == expected and normalized ~= \"\"",
  [23] = "tostring(f):lower()",
  [24] = "writefile",
  [25] = "FORCE_KEY_FILE, \"1\"",
  [26] = "(gethui and gethui()) or game:GetService(\"CoreGui\")",
  [27] = "hui:FindFirstChild(n)",
  [28] = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/SyndromeXph/Patriot-Key-System-Ui-Library/refs/heads/main/PatriotUi.luau\"))()",
  [29] = "resP",
  [30] = "Patriot",
  [31] = "\"[巫 script] Patriot 失败，简易卡密\", resP",
  [32] = "",
  [33] = "Instance.new(\"ScreenGui\")",
  [34] = "function() sg.Parent = game:GetService(\"CoreGui\") end",
  [35] = "Instance.new(\"Frame\", sg)",
  [36] = "Instance.new(\"TextLabel\", f)",
  [37] = "Instance.new(\"TextBox\", f)",
  [38] = "Instance.new(\"TextButton\", f)",
  [39] = "function() if writefile then writefile(KEY_FILE, CURRENT_KEY) end end",
  [40] = "true",
  [41] = "done",
  [42] = "sg",
  [43] = "Destroy",
  [44] = "keyOk",
  [45] = "KEY_FILE, CURRENT_KEY",
  [46] = "delfile",
  [47] = "FORCE_KEY_FILE, \"0\"",
  [48] = "{",
  [49] = "false,",
  [50] = "valid",
  [51] = "\"INVALID_KEY\",",
  [52] = "error",
  [53] = "卡密错误",
  [54] = "message",
  [55] = "\"巫 script\",",
  [56] = "Title",
  [57] = "\"输入卡密以继续\",",
  [58] = "Subtitle",
  [59] = "\"rbxassetid://98373426403561\",",
  [60] = "Icon",
  [61] = "UDim2.new(0, 30, 0, 30)",
  [62] = "IconSize",
  [63] = "\"\",",
  [64] = "GetKey",
  [65] = "Discord",
  [66] = "forceKey",
  [67] = "\"WuScript_SavedKey\",",
  [68] = "FileName",
  [69] = "not forceKey,",
  [70] = "Remember",
  [71] = "not forceKey",
  [72] = "AutoLoad",
  [73] = "Keyless",
  [74] = "true,",
  [75] = "Blur",
  [76] = "Draggable",
  [77] = "Color3.fromRGB(0, 170, 255),",
  [78] = "Accent",
  [79] = "Color3.fromRGB(40, 190, 255),",
  [80] = "AccentHover",
  [81] = "Color3.fromRGB(0, 0, 0),",
  [82] = "Background",
  [83] = "Color3.fromRGB(12, 16, 22),",
  [84] = "Header",
  [85] = "Color3.fromRGB(20, 24, 30),",
  [86] = "Input",
  [87] = "Color3.fromRGB(255, 255, 255),",
  [88] = "Text",
  [89] = "Color3.fromRGB(150, 160, 170),",
  [90] = "TextDim",
  [91] = "Color3.fromRGB(50, 220, 120),",
  [92] = "Success",
  [93] = "Color3.fromRGB(255, 60, 80),",
  [94] = "Error",
  [95] = "Color3.fromRGB(255, 200, 60),",
  [96] = "Warning",
  [97] = "Color3.fromRGB(0, 140, 200),",
  [98] = "StatusIdle",
  [99] = "DiscordHover",
  [100] = "Color3.fromRGB(30, 35, 45),",
  [101] = "Divider",
  [102] = "Color3.fromRGB(35, 40, 50)",
  [103] = "Pending",
  [104] = "keyClosed",
  [105] = "Launch",
  [106] = "Enabled",
  [107] = "AntiKickEnabled",
  [108] = "[Universal Pro] Anti-Kick / Adonis Bypass 启动中...",
  [109] = "game:GetService(\"Players\")",
  [110] = "players.LocalPlayer",
  [111] = "lp.Kick",
  [112] = "softAntiKick",
  [113] = "[Universal Pro] ✅ Anti-Kick 已启用",
  [114] = "game:GetService(\"ReplicatedStorage\")",
  [115] = "AdonisDetected",
  [116] = "ReplicatedStorage:FindFirstChild(remoteName)",
  [117] = "[Universal Pro] Adonis Anti-Cheat detectado! Aplicando bypass...",
  [118] = "getrawmetatable(game)",
  [119] = "mt.__namecall",
  [120] = "setreadonly",
  [121] = "mt, false",
  [122] = "getnamecallmethod()",
  [123] = "nil",
  [124] = "string.lower(tostring(self))",
  [125] = "oldNamecall(self, ...)",
  [126] = "mt, true",
  [127] = "game:GetService(\"LogService\")",
  [128] = "logService:GetLogHistory()",
  [129] = "function() log.message = \"\" end",
  [130] = "[Universal Pro] ✅ Bypass do Adonis aplicado com sucesso!",
  [131] = "[Universal Pro] Adonis 未检测到，仅启用基础 Anti-Kick namecall",
  [132] = "BypassAdonis",
  [133] = "WuApplyAntiCheat",
  [134] = "game:GetService(\"TweenService\")",
  [135] = "player:WaitForChild(\"PlayerGui\")",
  [136] = "Color3.fromRGB(72, 253, 0)      -- #48fd00",
  [137] = "Color3.fromRGB(101, 252, 13)    -- #65fc0d",
  [138] = "function() screenGui.Parent = game:GetService(\"CoreGui\") end",
  [139] = "Instance.new(\"Frame\")",
  [140] = 0,
  [141] = "BackgroundTransparency",
  [142] = "Instance.new(\"TextLabel\")",
  [143] = 36,
  [144] = "Instance.new(\"Sound\")",
  [145] = "s",
  [146] = "Play",
  [147] = "function() s:Destroy() end",
  [148] = 1,
  [149] = "codeLines[((i - 1) % #codeLines) + 1]",
  [150] = "i + 1",
  [151] = "i",
  [152] = "Instance.new(\"UIListLayout\")",
  [153] = "delayIndex + 1",
  [154] = "delayIndex",
  [155] = "Instance.new(\"UIStroke\")",
  [156] = "tip,",
  [157] = "label",
  [158] = "stroke,",
  [159] = "stroke",
  [160] = "(delayIndex - 1) * 0.05",
  [161] = "delay",
  [162] = "TextTransparency",
  [163] = "TweenService",
  [164] = "Create",
  [165] = 0.9,
  [166] = "Instance.new(\"TextButton\")",
  [167] = "skipLoading",
  [168] = "running",
  [169] = "codeRunning",
  [170] = "os.clock()",
  [171] = "TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)",
  [172] = "workspace.CurrentCamera",
  [173] = "(cam and cam.ViewportSize) or Vector2.new(800, 600)",
  [174] = 48,
  [175] = "math.max(8, math.ceil(vp.X / cellPx))",
  [176] = "math.max(12, math.ceil(vp.Y / cellPx))",
  [177] = "Color3.fromRGB(72, 253, 0)",
  [178] = "Color3.fromRGB(40, 180, 60)",
  [179] = "Instance.new(\"UICorner\")",
  [180] = "math.sqrt((c - cx) ^ 2 + (r - cy) ^ 2)",
  [181] = "cell,",
  [182] = "frame",
  [183] = "dist * 0.022,",
  [184] = "dist,",
  [185] = "dist",
  [186] = "UDim2.new(1 / COLS + 0.002, 0, 1 / ROWS + 0.002, 0), -- 略重叠，消灭缝隙",
  [187] = "fullSize",
  [188] = "s2",
  [189] = "function() s2:Destroy() end",
  [190] = "math.max(maxDelay, info.delay)",
  [191] = "maxDelay",
  [192] = "info.frame",
  [193] = 0.08,
  [194] = "info.fullSize,",
  [195] = "Size",
  [196] = "playDoneDing",
  [197] = "UDim2.new((1 / COLS) * 0.15, 0, (1 / ROWS) * 0.15, 0),",
  [198] = "TweenService:Create(black, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {",
  [199] = "fb",
  [200] = "function() screenGui:Destroy() end",
  [201] = "[巫 script] 加载 Vita UI...",
  [202] = "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/ArchIsDead/vita-ui-modified/refs/heads/main/source.lua\"))()",
  [203] = "\"[巫 script] Vita UI 失败:\", Library",
  [204] = "\"巫 script\", Text = \"Vita UI 加载失败\", Duration = 8",
  [205] = "Library:Window({",
  [206] = "\"by wu\",",
  [207] = "SubTitle",
  [208] = "Enum.KeyCode.RightControl,",
  [209] = "ToggleKey",
  [210] = "Scale",
  [211] = "AutoScale",
  [212] = "inst",
  [213] = 25,
  [214] = "r.Parent",
  [215] = "r",
  [216] = "us",
  [217] = "tostring(title or \"提示\"),",
  [218] = "tostring(desc or \"\"),",
  [219] = "Desc",
  [220] = "tonumber(dur) or 2,",
  [221] = "Duration",
  [222] = "t or {}",
  [223] = "t",
  [224] = "t.Name or t.Title or \"按钮\",",
  [225] = "\"执行\",",
  [226] = "t.Callback or function() end,",
  [227] = "Callback",
  [228] = "t.Name or t.Title or \"开关\",",
  [229] = "(t.Default == true) or (t.Value == true),",
  [230] = "Value",
  [231] = "t.Name or t.Title or \"滑条\",",
  [232] = "t.Min or 0,",
  [233] = "Min",
  [234] = "t.Max or 100,",
  [235] = "Max",
  [236] = "t.Default or t.Value or t.Min or 0,",
  [237] = "Rounding",
  [238] = "t.Suffix or \"\",",
  [239] = "Suffix",
  [240] = "page:Input({",
  [241] = "box",
  [242] = "t.Name or t.Title or \"输入\",",
  [243] = "t.PlaceholderText or t.Placeholder or \"\",",
  [244] = "Placeholder",
  [245] = "t.Default or \"\",",
  [246] = "ClearOnSubmit",
  [247] = "t.Name or t.Title or \"下拉\",",
  [248] = "t.Options or t.List or {},",
  [249] = "List",
  [250] = "t.Default or t.Value,",
  [251] = "t.Name or t.Title or \"按键\",",
  [252] = "t.Default or t.Value or Enum.KeyCode.RightControl,",
  [253] = "type(t) == \"string\" and t or ((t and (t.Name or t.Text)) or \"\")",
  [254] = "function() page:Label({ Title = text }) end",
  [255] = "Window.NewPage",
  [256] = "_NewPage(self, { Title = tostring(name), Desc = \"\", Icon = \"plus\" })",
  [257] = "\"[巫] NewPage失败\", name, page",
  [258] = "_NewPage(self, { Title = tostring(name) })",
  [259] = "page",
  [260] = "function() page:Section(tostring(title or \"\")) end",
  [261] = "bindSection(page)",
  [262] = "s[method](s, opts)",
  [263] = "notify",
  [264] = "opts.Title, opts.Content or opts.Desc, opts.Duration",
  [265] = 20,
  [266] = "tostring(d.Text)",
  [267] = "btn.Size",
  [268] = 18,
  [269] = "Window:AddTab(\"通用功能\")",
  [270] = "MainTab:AddSection(\"角色属性\")",
  [271] = "\"行走速度 (WalkSpeed)\",",
  [272] = "Name",
  [273] = 16,
  [274] = 250,
  [275] = "Default",
  [276] = "Increment",
  [277] = "Notifications",
  [278] = "function(value)",
  [279] = "\"跳跃高度 (JumpPower)\",",
  [280] = 50,
  [281] = 300,
  [282] = "\"重力 (Gravity)\",",
  [283] = 500,
  [284] = 196.2,
  [285] = "\"视野 (FOV)\",",
  [286] = 30,
  [287] = 120,
  [288] = 70,
  [289] = "\"物理加速速度 (Velocity)\",",
  [290] = 520,
  [291] = "value",
  [292] = "VelocitySpeed",
  [293] = "\"物理加速开关 (覆盖WalkSpeed)\",",
  [294] = "function(state)",
  [295] = "state",
  [296] = "VelocityEnabled",
  [297] = "game:GetService(\"RunService\").RenderStepped:Connect(function()",
  [298] = "VelocityConnection",
  [299] = "game.Players.LocalPlayer",
  [300] = "player.Character",
  [301] = "char:FindFirstChild(\"HumanoidRootPart\")",
  [302] = "char:FindFirstChildOfClass(\"Humanoid\")",
  [303] = "hum.MoveDirection",
  [304] = "Window",
  [305] = "Notify",
  [306] = "Disconnect",
  [307] = 100,
  [308] = "\"高跳力度 (Velocity)\",",
  [309] = "HighJumpPower",
  [310] = "\"高跳开关 (Velocity驱动)\",",
  [311] = "HighJumpEnabled",
  [312] = "highJumpListener",
  [313] = "hum.Jumping:Connect(function()",
  [314] = "bindJump",
  [315] = "charAddedConn",
  [316] = "player.CharacterAdded:Connect(function(char)",
  [317] = "\"相机焦距上限 (Zoom Out)\",",
  [318] = 200000,
  [319] = "MainTab:AddSection(\"快捷操作\")",
  [320] = "\"恢复默认属性\",",
  [321] = "function()",
  [322] = "game.Players.LocalPlayer.Character",
  [323] = "\"已恢复\",",
  [324] = "\"所有属性已重置为默认值，物理加速/高跳已关闭\",",
  [325] = "Content",
  [326] = 2,
  [327] = "Window:AddTab(\"服务器信息\")",
  [328] = "SettingTab:AddSection(\"玩家信息\")",
  [329] = "\"查看用户名\",",
  [330] = "\"用户名\",",
  [331] = "game.Players.LocalPlayer.Name,",
  [332] = 3,
  [333] = "\"查看注入器\",",
  [334] = "未知",
  [335] = "identifyexecutor() or \"未知\"",
  [336] = "executor",
  [337] = "\"注入器\",",
  [338] = "executor,",
  [339] = "\"查看服务器ID\",",
  [340] = "\"GameId\",",
  [341] = "tostring(game.GameId),",
  [342] = "SettingTab:AddSection(\"反作弊\")",
  [343] = "\"防踢（默认开）\",",
  [344] = "getgenv",
  [345] = ").WuApplyAntiCheat(",
  [346] = "SettingTab:AddSection(\"卡密管理\")",
  [347] = "\"重置卡密（下次需重新输入）\",",
  [348] = "clearSavedKey",
  [349] = "\"已重置卡密\",",
  [350] = "\"请重新执行脚本，将重新弹出卡密输入\",",
  [351] = 4,
  [352] = "SettingTab:AddSection(\"服务器操作\")",
  [353] = "\"重新加入服务器\",",
  [354] = "\"离开服务器\",",
  [355] = "game",
  [356] = "Shutdown",
  [357] = "Window:AddTab(\"通用1\")",
  [358] = "Tab1:AddSection(\"视觉与移动\")",
  [359] = "\"夜视 (点击开关)\",",
  [360] = "not NightVision",
  [361] = "NightVision",
  [362] = "\"穿墙 (点击开关)\",",
  [363] = "not noclipEnabled",
  [364] = "noclipEnabled",
  [365] = "\"无限跳 (点击开关)\",",
  [366] = "not InfiniteJumpEnabled",
  [367] = "InfiniteJumpEnabled",
  [368] = "\"无限跳\",",
  [369] = "InfiniteJumpEnabled and \"已开启\" or \"已关闭\",",
  [370] = "GetService",
  [371] = "Tab1:AddSection(\"工具\")",
  [372] = "\"点击传送工具\",",
  [373] = "game.Players.LocalPlayer:GetMouse()",
  [374] = "Instance.new(\"Tool\")",
  [375] = "mouse.Hit + Vector3.new(0, 2.5, 0)",
  [376] = "\"帧率优化\",",
  [377] = "loadstring",
  [378] = "game:HttpGet(\"https://pastefy.app/OruW5AwY/raw\"))(",
  [379] = "\"帧率优化2\",",
  [380] = "https://raw.githubusercontent.com/twiceAA/ZombieHub/refs/heads/main/Zombie-hub-Optimizate-script-Boost-Fps3",
  [381] = "game:HttpGet(url))(",
  [382] = "Window:AddTab(\"范围设置\")",
  [383] = "Tab2:AddSection(\"范围调整\")",
  [384] = "v.Character.HumanoidRootPart",
  [385] = "size",
  [386] = "HitboxSize",
  [387] = "HitboxEnabled",
  [388] = "HitboxSection",
  [389] = "AddButton",
  [390] = "\"点击加载hitbox扩展器\",",
  [391] = "https://pastefy.app/ItfO0tdg/raw",
  [392] = "Window:AddTab(\"甩飞与传送\")",
  [393] = "Tab3:AddSection(\"甩飞功能\")",
  [394] = "workspace.FallenPartsDestroyHeight",
  [395] = "Name:lower()",
  [396] = "AllBool",
  [397] = "game:GetService(\"Players\"):GetPlayers()",
  [398] = "GetPlayers[math.random(#GetPlayers)]",
  [399] = "x",
  [400] = "Player.Character",
  [401] = "Character and Character:FindFirstChildOfClass(\"Humanoid\")",
  [402] = "Humanoid and Humanoid.RootPart",
  [403] = "TargetPlayer.Character",
  [404] = "TCharacter:FindFirstChildOfClass(\"Humanoid\")",
  [405] = "THumanoid and THumanoid.RootPart",
  [406] = "TCharacter:FindFirstChild(\"Head\")",
  [407] = "TCharacter:FindFirstChildOfClass(\"Accessory\")",
  [408] = "Accessory and Accessory:FindFirstChild(\"Handle\")",
  [409] = "RootPart.CFrame",
  [410] = "OldPos",
  [411] = "function(BasePart, Pos, Ang)",
  [412] = "Character",
  [413] = "SetPrimaryPartCFrame",
  [414] = "function(BasePart)",
  [415] = "tick()",
  [416] = "Angle + 100",
  [417] = "Angle",
  [418] = "FPos",
  [419] = "BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)",
  [420] = "BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)",
  [421] = "BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)",
  [422] = "BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0)",
  [423] = "BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0)",
  [424] = "BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0)",
  [425] = "BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0)",
  [426] = "BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0)",
  [427] = "BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0)",
  [428] = "BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0)",
  [429] = "BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0)",
  [430] = "BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0)",
  [431] = "BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0)",
  [432] = "Instance.new(\"BodyVelocity\")",
  [433] = "Humanoid",
  [434] = "SetStateEnabled",
  [435] = "SFBasePart",
  [436] = "BV",
  [437] = "ChangeState",
  [438] = "GettingUp",
  [439] = "\"甩飞全部人\",",
  [440] = "Players.LocalPlayer",
  [441] = "GetPlayer",
  [442] = "SkidFling",
  [443] = "GetPlayer(x)",
  [444] = "{}",
  [445] = "playerList",
  [446] = "FlingSection:AddDropdown({",
  [447] = "\"选择玩家\",",
  [448] = "refreshPlayerList(),",
  [449] = "Options",
  [450] = "function(option)",
  [451] = "option",
  [452] = "selectedPlayer",
  [453] = "\"刷新玩家列表\",",
  [454] = "dropdown",
  [455] = "SetOptions",
  [456] = "\"甩飞选中玩家\",",
  [457] = "game:GetService(\"Players\"):FindFirstChild(selectedPlayer)",
  [458] = "DisableCollide",
  [459] = "part",
  [460] = "char.ChildAdded:Connect(DisableCollide)",
  [461] = "game:GetService(\"RunService\").Stepped:Connect(function()",
  [462] = "conn",
  [463] = "CollisionAntiFlingConnections",
  [464] = "SetupCharacterCollision",
  [465] = "\"防甩飞 (禁用碰撞)\",",
  [466] = "CollisionAntiFlingEnabled",
  [467] = "ApplyCollisionAntiFling",
  [468] = "\"防甩飞\",",
  [469] = "state and \"已开启 (作用于所有其他玩家)\" or \"已关闭\",",
  [470] = "Tab3:AddSection(\"传送与查看\")",
  [471] = "\"传送到玩家旁边\",",
  [472] = "getSelectedTarget()",
  [473] = "game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild(\"HumanoidRootPart\")",
  [474] = "\"锁定传送（循环到玩家）\",",
  [475] = "LoopTpToPlayer",
  [476] = "\"把玩家传送过来\",",
  [477] = "\"循环传送玩家过来\",",
  [478] = "LoopBringPlayer",
  [479] = "\"查看玩家（观战）\",",
  [480] = "Spectating",
  [481] = "target.Character:FindFirstChildOfClass(\"Humanoid\")",
  [482] = "Window:AddTab(\"工具\")",
  [483] = "Tab4:AddSection(\"视觉\")",
  [484] = "\"帧率与Ping显示\",",
  [485] = "game:GetService(\"RunService\")",
  [486] = "game:GetService(\"Stats\")",
  [487] = "function() ScreenGui.Parent = game:GetService(\"CoreGui\") end",
  [488] = "math.floor(1 / RunService.RenderStepped:Wait())",
  [489] = "math.floor(Stats.Network.ServerStatsItem[\"Data Ping\"]:GetValue())",
  [490] = "ping",
  [491] = "(fps > 60 and \"Excellent\") or (fps >= 30 and \"Playable\") or \"Choppy\"",
  [492] = "(ping <= 50 and \"Good\") or (ping <= 100 and \"Decent\") or \"Bad\"",
  [493] = "\"显示时间\",",
  [494] = "\"锁定视角\",",
  [495] = "game:HttpGet(\"https://rawscripts.net/raw/Universal-Script-Mobile-Shiftlock-217580\"))(",
  [496] = "Tab4:AddSection(\"实用工具\")",
  [497] = "\"聊天框中进行图画\",",
  [498] = "game:HttpGet(\"https://raw.githubusercontent.com/ocfi/Draw-To-Chat-Obfuscated/refs/heads/main/Draw%20to%20Chat\"))(",
  [499] = "\"假卡顿 (走路跳跃变卡)\",",
  [500] = "game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Fe%20Fake%20Lag%20Obfuscator'))(",
  [501] = "\"玩家进出服务器提示\",",
  [502] = "game:HttpGet(\"https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua\"))(",
  [503] = "\"防挂机\",",
  [504] = "https://raw.githubusercontent.com/Proxylol/roblox-scripts/refs/heads/main/AntiAFK.lua",
  [505] = "\"自动互动\",",
  [506] = "autoInteractEnabled",
  [507] = "autoInteractLoop",
  [508] = "game:GetService(\"RunService\").Heartbeat:Connect(function()",
  [509] = "fireproximityprompt",
  [510] = "descendant",
  [511] = "\"快速互动 (无需长按)\",",
  [512] = "quickInteractConnection",
  [513] = "game:GetService(\"ProximityPromptService\").PromptButtonHoldBegan:Connect(function(prompt)",
  [514] = "Window:AddTab(\"趣味\")",
  [515] = "Tab5:AddSection(\"移动\")",
  [516] = "\"飞行\",",
  [517] = "game:HttpGet(\"https://obfuscatorhub.onrender.com/api/nycq09p0\"))(",
  [518] = "\"隐身\",",
  [519] = "game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))(",
  [520] = "\"爬墙\",",
  [521] = "game:HttpGet(\"https://pastebin.com/raw/zXk4Rq2r\"))(",
  [522] = "Tab5:AddSection(\"旋转与动作\")",
  [523] = "\"快速旋转\",",
  [524] = "spawn",
  [525] = "Instance.new(\"Animation\")",
  [526] = "game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(Anim)",
  [527] = "bruh",
  [528] = "AdjustSpeed",
  [529] = "hi",
  [530] = "wait",
  [531] = 1.5,
  [532] = "Instance.new(\"BodyAngularVelocity\")",
  [533] = "\"极速旋转\",",
  [534] = "game:HttpGet(\"https://pastebin.com/raw/ckiGL34v\"))(",
  [535] = "\"滚动\",",
  [536] = "game:HttpGet(\"https://raw.githubusercontent.com/BOOSBS/111/refs/heads/main/192\"))(",
  [537] = "Tab5:AddSection(\"杂项工具\")",
  [538] = "\"血量设置 (只能自己看)\",",
  [539] = 10000,
  [540] = "\"重开 (删除头部)\",",
  [541] = "\"上头定在原地\",",
  [542] = "lp.Character",
  [543] = "char:Clone()",
  [544] = 0.1,
  [545] = "char:FindFirstChildWhichIsA(\"Humanoid\")",
  [546] = "oldhum:Clone()",
  [547] = "new",
  [548] = "newhum",
  [549] = "GetPropertyChangedSignal",
  [550] = "oldhum",
  [551] = "\"阿尔宙斯注入器\",",
  [552] = "game:HttpGet(\"https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3\"))(",
  [553] = "\"刷道具\",",
  [554] = "game:HttpGet(\"https://pastebin.com/raw/wT1aKD4B\"))(",
  [555] = "\"位置查看\",",
  [556] = "game:HttpGet(\"https://pastebin.com/raw/ZJeTvyzG\"))(",
  [557] = "\"物体起飞 (Q键使用)\",",
  [558] = "game:HttpGet(\"https://raw.githubusercontent.com/BOOSBS/ajduoxc/refs/heads/main/ajduoxcz\"))(",
  [559] = "\"虚拟键盘 (第1种)\",",
  [560] = "game:HttpGet(\"https://gist.githubusercontent.com/RedZenXYZ/4d80bfd70ee27000660e4bfa7509c667/raw/da903c570249ab3c0c1a74f3467260972c3d87e6/KeyBoard%2520From%2520Ohio%2520Fr%2520Fr\"))(",
  [561] = "\"虚拟键盘 (第2种)\",",
  [562] = "game:HttpGet(\"https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt\", true))(",
  [563] = "\"飞车\",",
  [564] = "game:HttpGet(\"https://pastebin.com/raw/gNqZiexm\"))(",
  [565] = "\"FE变身中心\",",
  [566] = "game:HttpGet(\"https://you.whimper.xyz/UFE.lua\"))(",
  [567] = "\"动画中心\",",
  [568] = "game:HttpGet(\"https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/BundleAnimations.lua\"))(",
  [569] = "\"巫墙跳\",",
  [570] = "game:GetService(\"UserInputService\")",
  [571] = "Instance.new(\"UICorner\"); fc.CornerRadius = UDim.new(0, 8); fc.Parent = frame",
  [572] = "dragging",
  [573] = "input.Position",
  [574] = "dragStart",
  [575] = "frame.Position",
  [576] = "startPos",
  [577] = "input.Position - dragStart",
  [578] = "Instance.new(\"UICorner\"); sc.CornerRadius = UDim.new(0, 8); sc.Parent = statusLabel",
  [579] = "Instance.new(\"UICorner\"); c.CornerRadius = UDim.new(0, 6); c.Parent = b",
  [580] = "makeBtn(\"开启\", 40, Color3.fromRGB(0, 180, 80))",
  [581] = "makeBtn(\"关闭\", 72, Color3.fromRGB(200, 60, 60))",
  [582] = "makeBtn(\"自动：关\", 104, Color3.fromRGB(200, 60, 60))",
  [583] = "makeBtn(\"自动跳：关\", 136, Color3.fromRGB(200, 60, 60))",
  [584] = "makeBtn(\"下压力：关\", 168, Color3.fromRGB(200, 60, 60))",
  [585] = "makeBtn(\"销毁界面\", 380, Color3.fromRGB(80, 80, 90))",
  [586] = "Instance.new(\"UICorner\"); bc.CornerRadius = UDim.new(0, 4); bc.Parent = bg",
  [587] = "(default - minV) / (maxV - minV)",
  [588] = "Instance.new(\"UICorner\"); kc.CornerRadius = UDim.new(0, 4); kc.Parent = knob",
  [589] = "default",
  [590] = "math.clamp((i.Position.X - ax) / aw, 0, 1)",
  [591] = "minV + s * (maxV - minV)",
  [592] = "function() return value end",
  [593] = "makeSlider(\"Flick\", 205, 0.45, 0.1, 0.8, \"弹跳速度: %.2f\")",
  [594] = "makeSlider(\"DF\", 250, 0.45, 0, 1, \"下压力倍数: %.2f\")",
  [595] = "makeSlider(\"Angle\", 295, 50, 0, 180, \"弹跳角度: %d°\")",
  [596] = "RaycastParams.new()",
  [597] = "inst and inst:FindFirstAncestorOfClass(\"Model\")",
  [598] = "m and m:FindFirstChildOfClass(\"Humanoid\")",
  [599] = 7,
  [600] = "(hrp.CFrame * CFrame.Angles(0, math.rad(i * 45), 0)).LookVector",
  [601] = "workspace:Raycast(hrp.Position, dir * 2.5, rayParams)",
  [602] = "closest",
  [603] = "char and char:FindFirstChildOfClass(\"Humanoid\")",
  [604] = "char and char:FindFirstChild(\"HumanoidRootPart\")",
  [605] = "hit.Normal",
  [606] = "Vector3.new(n.X, 0, n.Z)",
  [607] = "away.Magnitude > 0.1 and away.Unit or Vector3.new(0,0,1)",
  [608] = "away",
  [609] = "Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)",
  [610] = "look.Magnitude > 0.1 and look.Unit or away",
  [611] = "look",
  [612] = "math.rad(getAngle())",
  [613] = "math.clamp(away:Dot(look), -1, 1)",
  [614] = "math.acos(dot)",
  [615] = "away:Cross(look)",
  [616] = "-math.sign(cross.Y)",
  [617] = "(sign ~= 0) and math.min(ang, maxA) or 0",
  [618] = "CFrame.Angles(0, infl * sign, 0) * away",
  [619] = "hum",
  [620] = "UIS.JumpRequest:Connect(function()",
  [621] = "jumpConn",
  [622] = "RunService.Heartbeat:Connect(function()",
  [623] = "autoConn",
  [624] = "doJump",
  [625] = "getWall()",
  [626] = "start",
  [627] = "stop",
  [628] = "screenGui",
  [629] = "name,",
  [630] = "addToolButton",
  [631] = "防止摔落伤害\", \"https://raw.githubusercontent.com/cytj777i/Fall-injury/main/%E9%98%B2%E6%AD%A2%E6%91%94%E8%90%BD%E4%BC%A4%E5%AE%B3\", \"防摔已加载",
  [632] = "物理磁铁\", \"https://raw.githubusercontent.com/cytj777i/6669178/main/%E5%8D%95%E4%B8%80%E7%89%A9%E4%BD%93%E9%A3%9E%E8%A1%8C%E8%BD%BD%E8%87%AA%E5%B7%B1%E6%9C%80%E7%BB%88%E4%BC%98%E5%8C%96%E7%89%88\", \"磁铁已加载",
  [633] = "无敌少侠飞行\", \"https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414\", \"飞行模式已加载",
  [634] = "黑洞特效\", \"https://rawscripts.net/raw/Universal-Script-Super-ring-Parts-V6-28581\", \"黑洞已加载",
  [635] = "Window:AddTab(\"各类服务器脚本\")",
  [636] = "Tab6:AddSection(\"服务器脚本\")",
  [637] = "\"翻译脚本\",",
  [638] = "TX Script",
  [639] = "TX",
  [640] = "全自动翻译",
  [641] = "Script",
  [642] = "game:HttpGet(\"https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language\"))(",
  [643] = "\"1. tsb脚本\",",
  [644] = "https://raw.githubusercontent.com/ATrainz/Phantasm/refs/heads/main/Games/TSB.lua",
  [645] = "\"2. 内脏与黑火药4.1\",",
  [646] = "https://raw.githubusercontent.com/wzhxll/Invincible-Willow-Leaf/refs/heads/main/Skin%20HUB%204.1.lua",
  [647] = "\"3. doors最佳剧本\",",
  [648] = "https://raw.githubusercontent.com/bocaj111004/Abysall/refs/heads/main/Loader.luau",
  [649] = "\"4. 被遗弃\",",
  [650] = "https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua",
  [651] = "\"5. 动物医院\",",
  [652] = "https://api.jnkie.com/api/v1/luascripts/public/41ab9a9e551bf53a0d4f1b9a9ee06c3f3a63270cf961c9d25e9ec6de1e941809/download",
  [653] = "动物医院",
  [654] = "\"6. 储存猎人:开发世界\",",
  [655] = "储存猎人:开发世界",
  [656] = "\"7. 彩虹朋友\",",
  [657] = "https://wilonity.xyz/script-hub.lua",
  [658] = "彩虹朋友",
  [659] = "\"8. 暴力区\",",
  [660] = "暴力区",
  [661] = "\"9. 竞争对手\",",
  [662] = "https://raw.githubusercontent.com/imshrak/rivals/refs/heads/main/main",
  [663] = "\"10. 狙击竞技场\",",
  [664] = "https://raw.githubusercontent.com/imshrak/sniperarena/main/menu",
  [665] = "\"11. 出售柠檬\",",
  [666] = "https://raw.githubusercontent.com/tempvoxels-web/Sell-Lemons/refs/heads/main/unobfus-sell-lemons-v1.lua",
  [667] = "\"12. 养鸡场\",",
  [668] = "https://pastefy.app/qBmAubwR/raw",
  [669] = "\"13. the mimic\",",
  [670] = "the mimic",
  [671] = "\"14. 已追捕\",",
  [672] = "https://raw.githubusercontent.com/ATGFAIL/ATGHub/main/Dark-Deception-Hunted.lua",
  [673] = "\"15. 一键点击\",",
  [674] = "https://raw.githubusercontent.com/ishakkakosik/FluxX/refs/heads/main/FluxX.lua",
  [675] = "\"16. 驾驶帝国\",",
  [676] = "https://raw.githubusercontent.com/Kenniel123/Axonic-Driving-Empire/refs/heads/main/Axonic%20Driving%20Empire",
  [677] = "\"17. 刀战竞技场\",",
  [678] = "https://pastefy.app/iizD2kA3/raw",
  [679] = "\"18. 军火库\",",
  [680] = "https://trace-host.vercel.app/trace.lua",
  [681] = "\"19. 进击泰坦革命\",",
  [682] = "https://raw.githubusercontent.com/TITANIC-HUB/THUB/main/Loader.lua",
  [683] = "\"20. 吃播游戏\",",
  [684] = "吃播游戏",
  [685] = "\"21. 方块旋转（无限钱）\",",
  [686] = "方块旋转",
  [687] = "game:HttpGet(\"https://api.sasware.dev/script/Blockspin.luau\"))(",
  [688] = "\"22. +1速度逃离键盘\",",
  [689] = "https://pastebin.com/raw/JML4K8L8",
  [690] = "\"23. 学乱\",",
  [691] = "学乱",
  [692] = "\"24. nico的下一个机器人\",",
  [693] = "https://gist.githubusercontent.com/olivernodex/e77feda9ee5cafac0a0a26d63ecbad5e/raw/NicosMenu.lua",
  [694] = "\"25. 方块侏罗纪自动刷\",",
  [695] = "https://obfuscatorhub.onrender.com/api/8ea6z3xd",
  [696] = "\"26. 破坏者谜团\",",
  [697] = "https://cdn.cdnpastebin.com/api/paste/XejZw89q/raw",
  [698] = "\"27. 墨水游戏\",",
  [699] = "墨水游戏",
  [700] = "\"28. blox fruit\",",
  [701] = "https://raw.githubusercontent.com/Kenniel123/BloxFruits/refs/heads/main/BloxFruits",
  [702] = "\"29. 监狱人生强力剧本\",",
  [703] = "https://raw.githubusercontent.com/idkazul/b/main/script.lua",
  [704] = "\"30. 柔术战场\",",
  [705] = "https://raw.githubusercontent.com/elopz-dev/Elopez/refs/heads/main/leakd_obfuscated.lua%20(2).txt",
  [706] = "\"31. 成长斗兽鸡\",",
  [707] = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua",
  [708] = "成长斗兽鸡",
  [709] = "\"32. 挖掘和清洗\",",
  [710] = "挖掘和清洗",
  [711] = "\"33. 刀波球\",",
  [712] = "https://raw.githubusercontent.com/joshhhie/rise/refs/heads/main/loader.lua",
  [713] = "\"34. 圣地亚哥角色扮演\",",
  [714] = "https://raw.githubusercontent.com/Floysy/Roblox-scripts/refs/heads/main/SanDiegoBorderRP.lua",
  [715] = "\"35. 贪婪的种植者\",",
  [716] = "贪婪的种植者",
  [717] = "\"36. 在山上采矿\",",
  [718] = "在山上采矿",
  [719] = "\"37. 蓝锁：竞争对手\",",
  [720] = "蓝锁：竞争对手",
  [721] = "\"38. 实用篮球\",",
  [722] = "https://gist.githubusercontent.com/Lua-Hemisphere/fce3025e29f51cae9285dbffa436199c/raw/gistfile1.txt",
  [723] = "\"39. the rake\",",
  [724] = "https://raw.githubusercontent.com/unrexl/Scripts/refs/heads/main/TheRakev2",
  [725] = "\"40. 森林中的 99 夜\",",
  [726] = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua",
  [727] = "\"41. Blox Strike\",",
  [728] = "https://api.jnkie.com/api/v1/luascripts/public/604034a335c161140a71b2aba35d61e3df97b9f3721c2a7e01e99d015222f069/download",
  [729] = "\"42. 战斗砖块\",",
  [730] = "战斗砖块",
  [731] = "game:HttpGet(\"https://pastebin.com/raw/GqJWbktX\"))(",
  [732] = "\"43. 一次尘土飞扬的旅行\",",
  [733] = "https://raw.githubusercontent.com/xelorascripts/aDustyTrip/main/script.lua",
  [734] = "\"44. 独自在家\",",
  [735] = "https://rawscripts.net/raw/Home-Alone-HORROR-WIP-gui-v1-27061",
  [736] = "\"45. 刀战\",",
  [737] = "https://raw.githubusercontent.com/AAPVdev/scripts/refs/heads/main/UI_LimbExtender.lua",
  [738] = "\"46. 偷走一颗蛋\",",
  [739] = "偷走一颗蛋",
  [740] = "\"47. 魔法战利品\",",
  [741] = "魔法战利品",
  [742] = "\"48. 怪物跑者\",",
  [743] = "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/MonsterRunners.lua",
  [744] = "怪物跑者",
  [745] = "\"49. 兵工厂\",",
  [746] = "https://raw.githubusercontent.com/codexvsberserkerxylo/scripts/refs/heads/main/arsenal.luau",
  [747] = "兵工厂",
  [748] = "\"50. 合并核弹\",",
  [749] = "https://raw.githubusercontent.com/genduuu/Merge-A-Nuke/refs/heads/main/obfuscated_firebutton_mergenuke.lua",
  [750] = "\"51. +1龙卷风逃脱\",",
  [751] = "+1龙卷风逃脱",
  [752] = "\"52. 钓鱼\",",
  [753] = "https://api.jnkie.com/api/v1/luascripts/public/4fa5547b587b1f3110ad121fd9650a8256ed00c0c73ae49ecf07d2130a206125/download",
  [754] = "\"53. 离家同盟\",",
  [755] = "离家同盟",
  [756] = "game:HttpGet(\"https://raw.githubusercontent.com/SrzStarOG/Script/main/RUNAWAYS\"))(",
  [757] = "Window:AddTab(\"ESP\")",
  [758] = "EspTab:AddSection(\"主控开关\")",
  [759] = "\"启用 Neuro ESP\",",
  [760] = "ESPEnabled",
  [761] = "\"加载 Neuro ESP 模块\",",
  [762] = "EspTab:AddSection(\"方框设置\")",
  [763] = "\"方框 ESP\",",
  [764] = "\"方框样式\",",
  [765] = "{\"Full\", \"Corner\"},",
  [766] = "\"Corner\",",
  [767] = "\"边框厚度\",",
  [768] = 5,
  [769] = "\"填充方框\",",
  [770] = "\"填充透明度\",",
  [771] = 15,
  [772] = "\"边角长度\",",
  [773] = "EspTab:AddSection(\"轨迹线\")",
  [774] = "\"轨迹线 ESP\",",
  [775] = "\"轨迹起点\",",
  [776] = "{\"Bottom\", \"Top\", \"Mouse\"},",
  [777] = "\"Bottom\",",
  [778] = "EspTab:AddSection(\"血条\")",
  [779] = "\"血条 ESP\",",
  [780] = "\"血条样式\",",
  [781] = "{\"Bar\", \"Text\", \"Both\"},",
  [782] = "\"Bar\",",
  [783] = "EspTab:AddSection(\"信息显示\")",
  [784] = "\"显示名称\",",
  [785] = "\"显示距离\",",
  [786] = "\"文字大小\",",
  [787] = 10,
  [788] = 14,
  [789] = "EspTab:AddSection(\"透体 (Chams)\")",
  [790] = "\"启用透体\",",
  [791] = "\"透体透明度\",",
  [792] = "EspTab:AddSection(\"队伍与距离\")",
  [793] = "\"队伍检测\",",
  [794] = "\"显示队友\",",
  [795] = "\"最大显示距离\",",
  [796] = 9999,
  [797] = 1000,
  [798] = "EspTab:AddSection(\"NPC ESP\")",
  [799] = "ESPHighlight_NPC",
  [800] = "Instance.new(\"Highlight\")",
  [801] = "function() v:Destroy() end",
  [802] = "ApplyNPCESP",
  [803] = "v",
  [804] = "\"启用 NPC ESP (绿色高亮)\",",
  [805] = "NPCESPEnabled",
  [806] = "ScanAndApplyNPCESP",
  [807] = "function() task.cancel(NPCESPThread) end",
  [808] = "NPCESPThread",
  [809] = "task.spawn(function()",
  [810] = "ClearAllNPCESP",
  [811] = "\"立即刷新 NPC ESP\",",
  [812] = "\"清除所有 NPC 高亮\",",
  [813] = "Window:AddTab(\"额外功能\")",
  [814] = "ExtraTab:AddSection(\"战斗相关\")",
  [815] = "\"靠近自动攻击 (需拿起武器)\",",
  [816] = "AutoAttackEnabled",
  [817] = "AutoAttackConnection",
  [818] = "char:FindFirstChildOfClass(\"Tool\")",
  [819] = "tool:FindFirstChild(\"Handle\") or tool:FindFirstChildWhichIsA(\"BasePart\")",
  [820] = "tool:FindFirstChildWhichIsA(\"TouchTransmitter\", true)",
  [821] = "OverlapParams.new()",
  [822] = "workspace:GetPartBoundsInBox(handle.CFrame, handle.Size + Vector3.new(12, 12, 12), params)",
  [823] = "part:FindFirstAncestorWhichIsA(\"Model\")",
  [824] = "model:FindFirstChildOfClass(\"Humanoid\")",
  [825] = "tool",
  [826] = "Activate",
  [827] = "firetouchinterest",
  [828] = "handle, part, 1",
  [829] = "handle, part, 0",
  [830] = "\"无后坐快速射击\",",
  [831] = "game:HttpGet(\"https://pastefy.app/Vbnh3Ycg/raw\"))(",
  [832] = "\"无限子弹\",",
  [833] = "game:HttpGet(\"https://pastefy.app/bYg3smqm/raw\"))(",
  [834] = "\"弹人 (实体)\",",
  [835] = "game:HttpGet(\"https://pastefy.app/4r9e4F3p/raw\"))(",
  [836] = "\"弹人 (半实体)\",",
  [837] = "game:HttpGet(\"https://pastebin.com/raw/UTWcDtzj\"))(",
  [838] = "ExtraTab:AddSection(\"角色相关\")",
  [839] = "\"替身\",",
  [840] = "game:HttpGet(\"https://raw.githubusercontent.com/SkrillexMe/SkrillexLoader/main/SkrillexLoadMain\"))(",
  [841] = "ExtraTab:AddSection(\"道具管理\")",
  [842] = "\"获取当前道具\",",
  [843] = "game:HttpGet(\"https://pastefy.app/3FU05Dyt/raw\"))(",
  [844] = "\"装备全部道具\",",
  [845] = "game:HttpGet(\"https://pastefy.app/uBqVR9JC/raw\"))(",
  [846] = "\"删除道具\",",
  [847] = "game:HttpGet(\"https://pastefy.app/r4LHK4p0/raw\"))(",
  [848] = "\"删除所有道具\",",
  [849] = "game:HttpGet(\"https://pastefy.app/8HB71Lbj/raw\"))(",
  [850] = "\"获取所有玩家背包\",",
  [851] = "StealBackpackEnabled",
  [852] = "function() task.cancel(StealBackpackThread) end",
  [853] = "StealBackpackThread",
  [854] = "ExtraTab:AddSection(\"实用工具\")",
  [855] = "\"F3X 建造工具\",",
  [856] = "game:GetObjects(\"rbxassetid://6695644299\")[1].Source)(",
  [857] = "\"保存游戏 (saveinstance)\",",
  [858] = "saveinstance",
  [859] = "\"死亡笔记\",",
  [860] = "game:HttpGet(\"https://raw.githubusercontent.com/dingding123hhh/tt/main/%E6%AD%BB%E4%BA%A1%E7%AC%94%E8%AE%B0%20(1).txt\"))(",
  [861] = "\"聊天气泡美化\",",
  [862] = "game:HttpGet(\"https://pastefy.app/lCEPuiQO/raw\"))(",
  [863] = "Window.ScreenGui",
  [864] = "ScreenGui:FindFirstChild(\"Main\")",
  [865] = "Main:FindFirstChild(\"TabList\")",
  [866] = "Instance.new(\"ScrollingFrame\")",
  [867] = "getgenv().Neuro",
  [868] = "BoxESP",
  [869] = "BoxStyle",
  [870] = "BoxThickness",
  [871] = "BoxFilled",
  [872] = 0.15,
  [873] = "BoxFillTransparency",
  [874] = 0.25,
  [875] = "CornerLength",
  [876] = "TracerESP",
  [877] = "TracerOrigin",
  [878] = "HealthESP",
  [879] = "HealthStyle",
  [880] = "NameESP",
  [881] = "ShowDistance",
  [882] = "TextSize",
  [883] = "ChamsEnabled",
  [884] = "Color3.fromRGB(255, 50, 50),",
  [885] = "ChamsFillColor",
  [886] = 0.5,
  [887] = "ChamsTransparency",
  [888] = "ChamsOutlineColor",
  [889] = "ChamsOutlineTransparency",
  [890] = "TeamCheck",
  [891] = "ShowTeam",
  [892] = "MaxDistance",
  [893] = "Color3.fromRGB(0, 255, 130),",
  [894] = "AllyColor",
  [895] = "EnemyColor",
  [896] = "RefreshRate",
  [897] = "RawRenderAPI",
  [898] = "Environment.ESP",
  [899] = "setmetatable({}, { __mode = \"k\" })",
  [900] = "lastProps[obj]",
  [901] = "c1.R + (c2.R - c1.R) * t",
  [902] = "c1.G + (c2.G - c1.G) * t",
  [903] = "c1.B + (c2.B - c1.B) * t",
  [904] = "Color3.fromRGB(math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))",
  [905] = "LerpColor(Color3.fromRGB(255, 220, 0), Color3.fromRGB(0, 255, 80), (pct - 0.5) * 2)",
  [906] = "LerpColor(Color3.fromRGB(255, 85, 85), Color3.fromRGB(255, 220, 0), pct * 2)",
  [907] = "ESP.AllyColor",
  [908] = "ESP.EnemyColor",
  [909] = "LocalPlayer.Team == player.Team",
  [910] = "LocalPlayer.TeamColor == player.TeamColor",
  [911] = "Drawing.new(\"Line\")",
  [912] = "SafeSet",
  [913] = "line, \"Visible\", false",
  [914] = "line, \"Color\", color or Color3.fromRGB(255, 255, 255)",
  [915] = "line, \"Thickness\", thickness or 1",
  [916] = "line, \"Transparency\", transparency or 1",
  [917] = "Drawing.new(\"Square\")",
  [918] = "sq, \"Visible\", false",
  [919] = "sq, \"Color\", color or Color3.fromRGB(255, 255, 255)",
  [920] = "sq, \"Filled\", filled or false",
  [921] = "sq, \"Thickness\", thickness or 0",
  [922] = "sq, \"Transparency\", transparency or 1",
  [923] = "Drawing.new(\"Text\")",
  [924] = "txt, \"Visible\", false",
  [925] = "txt, \"Font\", font or 2",
  [926] = "txt, \"Size\", size or 14",
  [927] = "txt, \"Color\", color or Color3.fromRGB(255, 255, 255)",
  [928] = "txt, \"Outline\", true",
  [929] = "txt, \"Center\", true",
  [930] = "txt, \"OutlineColor\", Color3.fromRGB(0, 0, 0)",
  [931] = "MakeLine(Color3.fromRGB(255,255,255), 1, 0.85)",
  [932] = "MakeLine(Color3.fromRGB(0,0,0), 3, 0.35)",
  [933] = "MakeSquare(Color3.fromRGB(20,20,20), true, 0, 0.65),",
  [934] = "MakeSquare(Color3.fromRGB(150,150,150), true, 0, 0.85),",
  [935] = "Delay",
  [936] = "MakeSquare(Color3.fromRGB(70,70,70), false, 1, 1),",
  [937] = "Outline",
  [938] = "MakeSquare(Color3.fromRGB(0,255,80), true, 0, 1),",
  [939] = "Fill",
  [940] = "MakeSquare(Color3.fromRGB(255,255,255), true, 0, 0.35),",
  [941] = "Glow",
  [942] = "MakeText(2, 11, Color3.fromRGB(255,255,255)),",
  [943] = "MakeText(2, 14, Color3.fromRGB(255,255,255)),",
  [944] = "MakeText(2, 12, Color3.fromRGB(150,150,150)),",
  [945] = "Distance",
  [946] = "MakeText(2, 12, Color3.fromRGB(200,200,200)),",
  [947] = "Weapon",
  [948] = "box, BoxOutline = boxOutline, Tracer = tracer,",
  [949] = "Box",
  [950] = "tracerOutline, HealthBar = healthBar, Info = info",
  [951] = "TracerOutline",
  [952] = "Drawings.ESP[player]",
  [953] = "function() esp.Tracer:Remove() end",
  [954] = "function() esp.TracerOutline:Remove() end",
  [955] = "function() Drawings.Highlights[player]:Destroy() end",
  [956] = "esp.Tracer, \"Visible\", false",
  [957] = "esp.TracerOutline, \"Visible\", false",
  [958] = "function() Drawings.Highlights[player].Enabled = false end",
  [959] = "(root.Position - Camera.CFrame.Position).Magnitude",
  [960] = "HideAll",
  [961] = "esp, player",
  [962] = "GetPlayerColor(player)",
  [963] = "hum.Health / hum.MaxHealth",
  [964] = "HealthColor(hpPct)",
  [965] = "sizeCache[player]",
  [966] = "{ Char = char, Size = char:GetExtentsSize() }",
  [967] = "root.CFrame",
  [968] = "Camera:WorldToViewportPoint((cf * CFrame.new(0, size.Size.Y / 2, 0)).Position)",
  [969] = "Camera:WorldToViewportPoint((cf * CFrame.new(0, -size.Size.Y / 2, 0)).Position)",
  [970] = "bottom.Y - top.Y",
  [971] = "h * 0.6",
  [972] = "top.X - w / 2",
  [973] = "top.Y",
  [974] = "ESP.BoxThickness or 1",
  [975] = "Vector2.new(bx, by)",
  [976] = "Vector2.new(bx + bw, by)",
  [977] = "Vector2.new(bx, by + bh)",
  [978] = "Vector2.new(bx + bw, by + bh)",
  [979] = "math.min(math.max(bw * 0.25, 4), bw * 0.35)",
  [980] = "math.min(math.max(bh * 0.25, 4), bh * 0.35)",
  [981] = "math.max(thick, math.min(thick + 2, h * 0.12))",
  [982] = "line, \"From\", f",
  [983] = "line, \"To\", t",
  [984] = "line, \"Color\", col",
  [985] = "line, \"Thickness\", th",
  [986] = "line, \"Transparency\", al or 1",
  [987] = "line, \"Visible\", true",
  [988] = "dL",
  [989] = "esp.BoxOutline.TL, TL, Vector2.new(bx + cLen, by), Color3.fromRGB(0,0,0), oThick, 0.35",
  [990] = "esp.BoxOutline.TR, TR, Vector2.new(bx + bw - cLen, by), Color3.fromRGB(0,0,0), oThick, 0.35",
  [991] = "esp.BoxOutline.BL, BL, Vector2.new(bx + cLen, by + bh), Color3.fromRGB(0,0,0), oThick, 0.35",
  [992] = "esp.BoxOutline.BR, BR, Vector2.new(bx + bw - cLen, by + bh), Color3.fromRGB(0,0,0), oThick, 0.35",
  [993] = "esp.BoxOutline.L, TL, Vector2.new(bx, by + cH), Color3.fromRGB(0,0,0), oThick, 0.35",
  [994] = "esp.BoxOutline.R, TR, Vector2.new(bx + bw, by + cH), Color3.fromRGB(0,0,0), oThick, 0.35",
  [995] = "esp.BoxOutline.T, BL, Vector2.new(bx, by + bh - cH), Color3.fromRGB(0,0,0), oThick, 0.35",
  [996] = "esp.BoxOutline.B, BR, Vector2.new(bx + bw, by + bh - cH), Color3.fromRGB(0,0,0), oThick, 0.35",
  [997] = "esp.Box.TL, TL, Vector2.new(bx + cLen, by), color, thick",
  [998] = "esp.Box.TR, TR, Vector2.new(bx + bw - cLen, by), color, thick",
  [999] = "esp.Box.BL, BL, Vector2.new(bx + cLen, by + bh), color, thick",
  [1000] = "esp.Box.BR, BR, Vector2.new(bx + bw - cLen, by + bh), color, thick",
  [1001] = "esp.Box.L, TL, Vector2.new(bx, by + cH), color, thick",
  [1002] = "esp.Box.R, TR, Vector2.new(bx + bw, by + cH), color, thick",
  [1003] = "esp.Box.T, BL, Vector2.new(bx, by + bh - cH), color, thick",
  [1004] = "esp.Box.B, BR, Vector2.new(bx + bw, by + bh - cH), color, thick",
  [1005] = "esp.BoxOutline.L, TL, BL, Color3.fromRGB(0,0,0), oThick, 0.35",
  [1006] = "esp.BoxOutline.R, TR, BR, Color3.fromRGB(0,0,0), oThick, 0.35",
  [1007] = "esp.BoxOutline.T, TL, TR, Color3.fromRGB(0,0,0), oThick, 0.35",
  [1008] = "esp.BoxOutline.B, BL, BR, Color3.fromRGB(0,0,0), oThick, 0.35",
  [1009] = "esp.Box.L, TL, BL, color, thick",
  [1010] = "esp.Box.R, TR, BR, color, thick",
  [1011] = "esp.Box.T, TL, TR, color, thick",
  [1012] = "esp.Box.B, BL, BR, color, thick",
  [1013] = "esp.Box.Fill, \"Position\", Vector2.new(bx, by)",
  [1014] = "esp.Box.Fill, \"Size\", Vector2.new(bw, bh)",
  [1015] = "esp.Box.Fill, \"Color\", color",
  [1016] = "esp.Box.Fill, \"Transparency\", ESP.BoxFillTransparency or 0.15",
  [1017] = "esp.Box.Fill, \"Visible\", true",
  [1018] = "esp.Box.Fill, \"Visible\", false",
  [1019] = "Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)",
  [1020] = "Vector2.new(posVec.X, posVec.Y)",
  [1021] = "esp.TracerOutline, \"From\", from",
  [1022] = "esp.TracerOutline, \"To\", to",
  [1023] = "esp.TracerOutline, \"Color\", Color3.fromRGB(0,0,0)",
  [1024] = "esp.TracerOutline, \"Thickness\", 2",
  [1025] = "esp.TracerOutline, \"Transparency\", 0.3",
  [1026] = "esp.TracerOutline, \"Visible\", true",
  [1027] = "esp.Tracer, \"From\", from",
  [1028] = "esp.Tracer, \"To\", to",
  [1029] = "esp.Tracer, \"Color\", color",
  [1030] = "esp.Tracer, \"Thickness\", 1",
  [1031] = "esp.Tracer, \"Transparency\", 0.85",
  [1032] = "esp.Tracer, \"Visible\", true",
  [1033] = "bx - barW - 5",
  [1034] = "math.max(barH * hpPct, 1)",
  [1035] = "barY + barH - fillH",
  [1036] = "esp.HealthBar.Background, \"Position\", Vector2.new(barX - 1, barY - 1)",
  [1037] = "esp.HealthBar.Background, \"Size\", Vector2.new(barW + 2, barH + 2)",
  [1038] = "esp.HealthBar.Background, \"Visible\", true",
  [1039] = "esp.HealthBar.Outline, \"Position\", Vector2.new(barX - 1, barY - 1)",
  [1040] = "esp.HealthBar.Outline, \"Size\", Vector2.new(barW + 2, barH + 2)",
  [1041] = "esp.HealthBar.Outline, \"Color\", Color3.fromRGB(70,70,70)",
  [1042] = "esp.HealthBar.Outline, \"Visible\", true",
  [1043] = "esp.HealthBar.Fill, \"Position\", Vector2.new(barX, fillTopY)",
  [1044] = "esp.HealthBar.Fill, \"Size\", Vector2.new(barW, fillH)",
  [1045] = "esp.HealthBar.Fill, \"Color\", hpColor",
  [1046] = "esp.HealthBar.Fill, \"Visible\", true",
  [1047] = "esp.HealthBar.Glow, \"Position\", Vector2.new(barX, fillTopY)",
  [1048] = "esp.HealthBar.Glow, \"Size\", Vector2.new(barW, math.min(fillH, 2))",
  [1049] = "esp.HealthBar.Glow, \"Color\", hpColor",
  [1050] = "esp.HealthBar.Glow, \"Transparency\", 0.5",
  [1051] = "esp.HealthBar.Glow, \"Visible\", true",
  [1052] = "esp.HealthBar.Text, \"Text\", math.floor(hum.Health) .. \"/\" .. math.floor(hum.MaxHealth)",
  [1053] = "esp.HealthBar.Text, \"Position\", Vector2.new(barX - 5, fillTopY - 4)",
  [1054] = "esp.HealthBar.Text, \"Size\", 11",
  [1055] = "esp.HealthBar.Text, \"Color\", hpColor",
  [1056] = "esp.HealthBar.Text, \"Center\", false",
  [1057] = "esp.HealthBar.Text, \"Visible\", true",
  [1058] = "esp.HealthBar.Text, \"Visible\", false",
  [1059] = "bx + bw / 2",
  [1060] = "ESP.TextSize or 14",
  [1061] = "esp.Info.Name, \"Text\", player.DisplayName",
  [1062] = "esp.Info.Name, \"Position\", Vector2.new(centerX, by - fs - 6)",
  [1063] = "esp.Info.Name, \"Size\", fs",
  [1064] = "esp.Info.Name, \"Color\", color",
  [1065] = "esp.Info.Name, \"Visible\", true",
  [1066] = "esp.Info.Distance, \"Text\", \"[\" .. math.floor(dist * 0.28) .. \"m]\"",
  [1067] = "esp.Info.Distance, \"Position\", Vector2.new(centerX, by - 6)",
  [1068] = "esp.Info.Distance, \"Size\", math.max(fs - 2, 10)",
  [1069] = "esp.Info.Distance, \"Color\", Color3.fromRGB(150,150,150)",
  [1070] = "esp.Info.Distance, \"Visible\", true",
  [1071] = "esp.Info.Distance, \"Visible\", false",
  [1072] = "child.Name",
  [1073] = "wep",
  [1074] = "esp.Info.Weapon, \"Text\", wep",
  [1075] = "esp.Info.Weapon, \"Position\", Vector2.new(centerX, by + bh + 6)",
  [1076] = "esp.Info.Weapon, \"Size\", math.max(fs - 2, 10)",
  [1077] = "esp.Info.Weapon, \"Color\", Color3.fromRGB(200,200,200)",
  [1078] = "esp.Info.Weapon, \"Visible\", true",
  [1079] = "esp.Info.Weapon, \"Visible\", false",
  [1080] = "esp.Info.Name, \"Visible\", false",
  [1081] = "Drawings.Highlights[player]",
  [1082] = "Camera",
  [1083] = "ESP.Enabled",
  [1084] = "wasEnabled",
  [1085] = "lastUpdate",
  [1086] = "CreateESP",
  [1087] = "UpdateESP",
  [1088] = "RemoveESP",
  [1089] = "Environment",
  [1090] = "ESPConnect",
  [1091] = "[Neuro.lua] ESP module loaded successfully!",
  [1092] = "ShowPlayers",
  [1093] = "ShowNPCs",
  [1094] = "true,           -- ✅ NOVO: Dead Check no ESP",
  [1095] = "DeadCheck",
  [1096] = 2500,
  [1097] = "NameTextSize",
  [1098] = "DistanceTextSize",
  [1099] = 13,
  [1100] = "InventoryTextSize",
  [1101] = 60,
  [1102] = "HPBarWidth",
  [1103] = 6,
  [1104] = "HPBarHeight",
  [1105] = "ShowBox",
  [1106] = "ShowLine",
  [1107] = "ShowStick",
  [1108] = "ShowName",
  [1109] = "ShowHPBar",
  [1110] = "ShowEquippedItem",
  [1111] = "ShowInventory",
  [1112] = "UseTeamColor",
  [1113] = "Color3.fromRGB(255, 80, 80),",
  [1114] = "Color3.fromRGB(80, 255, 80),",
  [1115] = "Color3.fromRGB(255, 255, 0),",
  [1116] = "LineColor",
  [1117] = "Color3.fromRGB(255, 255, 255)",
  [1118] = "StickColor",
  [1119] = "game:GetService(\"ReplicatedStorage\"):FindFirstChild(remoteName)",
  [1120] = "function(self, ...)",
  [1121] = "original(self, ...)",
  [1122] = "original(self, unpack(args))",
  [1123] = "game:GetService(\"HttpService\")",
  [1124] = "game:GetService(\"CollectionService\")",
  [1125] = "LocalPlayer:GetMouse()",
  [1126] = "Drawing.new(\"Circle\")",
  [1127] = "character:FindFirstChildOfClass(\"Humanoid\")",
  [1128] = "character:FindFirstChild(\"BodyEffects\")",
  [1129] = "character:FindFirstChild(\"K.O\") or character:FindFirstChild(\"KO\")",
  [1130] = "LocalPlayer:IsFriendsWith(player.UserId)",
  [1131] = "LocalPlayer.FriendSystem:IsFriend(player)",
  [1132] = "target.Destroying:Connect(function()",
  [1133] = "HighlightConnection",
  [1134] = "math.sin(tick() * 3) * 0.2 + 0.8",
  [1135] = "nil; TargetPart = nil; TargetInRange = false; NPCCache = {}; PlayerCache = {}",
  [1136] = "CurrentTarget",
  [1137] = "\"[NPC DEBUG] Detectado:\", character.Name, \"| Razão:\", reason",
  [1138] = "Players:GetPlayerFromCharacter(character)",
  [1139] = "player ~= nil",
  [1140] = "character:FindFirstChild(\"Head\")",
  [1141] = "character:FindFirstChild(\"HumanoidRootPart\")",
  [1142] = "DebugNPCDetection",
  [1143] = "character, \"Modo Agressivo - Estrutura de Humanoid\"",
  [1144] = "character.Name:lower()",
  [1145] = "workspace:FindFirstChild(folderName)",
  [1146] = "character:FindFirstChild(indicator)",
  [1147] = "value.Value:lower()",
  [1148] = "child.Name:lower()",
  [1149] = "true; break",
  [1150] = "hasAIBehavior",
  [1151] = "CollectionService:GetTags(character)",
  [1152] = "tag:lower()",
  [1153] = "character, \"Estrutura de humanoid não-player (Genérico)\"",
  [1154] = "FindNPCsInWorkspaceRecursive(child)",
  [1155] = "LocalPlayer.Team ~= player.Team",
  [1156] = "npcModel:FindFirstChild(\"Team\")",
  [1157] = "npcTeamValue.Value",
  [1158] = "LocalPlayer.Team and LocalPlayer.Team.Name or \"\"",
  [1159] = "npcModel:FindFirstChild(\"IsEnemy\")",
  [1160] = "character:FindFirstChild(\"UpperTorso\") or character:FindFirstChild(\"Torso\") or character:FindFirstChild(\"HumanoidRootPart\")",
  [1161] = "character:FindFirstChild(\"HumanoidRootPart\") or character:FindFirstChild(\"Head\")",
  [1162] = "LastCacheUpdate",
  [1163] = "workspace:GetChildren()",
  [1164] = "FindNPCsInWorkspaceRecursive(folder)",
  [1165] = "workspace:GetDescendants()",
  [1166] = "counter + 1",
  [1167] = "counter",
  [1168] = "processCounter + 1",
  [1169] = "processCounter",
  [1170] = "model:FindFirstChild(\"HumanoidRootPart\")",
  [1171] = "NPCCache",
  [1172] = "PlayerCache",
  [1173] = "CurrentTarget:FindFirstChildOfClass(\"Humanoid\")",
  [1174] = "CurrentTarget:FindFirstChild(\"HumanoidRootPart\")",
  [1175] = "LocalPlayer.Character.HumanoidRootPart.Position",
  [1176] = "TargetPart.Position",
  [1177] = "(targetPos - localPos).Magnitude",
  [1178] = "Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)",
  [1179] = "Vector2.new(screenPos.X, screenPos.Y)",
  [1180] = "(screenPoint - screenCenter).Magnitude",
  [1181] = "Camera.CFrame.Position",
  [1182] = "(targetPos - origin).Unit * (targetPos - origin).Magnitude",
  [1183] = "workspace:Raycast(origin, direction, raycastParams)",
  [1184] = "ray.Instance",
  [1185] = "false; TargetPart = nil; return nil",
  [1186] = "TargetInRange",
  [1187] = "UpdateCaches",
  [1188] = "math.huge",
  [1189] = "LocalPlayer.Character",
  [1190] = "localChar:FindFirstChild(\"HumanoidRootPart\")",
  [1191] = "false; TargetPart = nil",
  [1192] = "data.HRP",
  [1193] = "data.Humanoid",
  [1194] = "(hrp.Position - localRoot.Position).Magnitude",
  [1195] = "-- Ignorar alvos muito distantes",
  [1196] = "GetTargetPart(data.Model)",
  [1197] = "targetPart.Position",
  [1198] = "bestScore",
  [1199] = "closestPart",
  [1200] = "data.Model",
  [1201] = "closestTarget",
  [1202] = "TargetPart",
  [1203] = "math.random(1, 100)",
  [1204] = "randomNumber <= _G.HitChance",
  [1205] = "_G.HitChance",
  [1206] = "baseChance * distanceFactor * fovFactor",
  [1207] = "math.random(-5, 5)",
  [1208] = "math.floor(math.clamp(finalChance + randomVariation, 1, 100))",
  [1209] = "_G.ShowHitChance and _G.HitChance > 0",
  [1210] = "CurrentTarget.Name",
  [1211] = "NPC",
  [1212] = "string.format(\"%.1f\", (TargetPart.Position - localPos).Magnitude)",
  [1213] = "Drawing.new(t)",
  [1214] = "model:FindFirstChild(\"HumanoidRootPart\") or model:FindFirstChild(\"Torso\")",
  [1215] = "hum, root",
  [1216] = "Players:GetPlayerFromCharacter(model)",
  [1217] = "getPlayerFromCharacterESP(model)",
  [1218] = "table.concat(items, \"\\n\")",
  [1219] = "model:FindFirstChild(\"Team\") or model:FindFirstChild(\"TeamColor\")",
  [1220] = "Vector2.new(v.X, v.Y), onScreen, v.Z",
  [1221] = "setDrawingVisibility",
  [1222] = "parts, false",
  [1223] = "(getPlayerFromCharacterESP(model) ~= nil)",
  [1224] = "(root.Position - cameraPos).Magnitude",
  [1225] = "isAlly(model)",
  [1226] = "ESP_Config.EnemyColor",
  [1227] = "getTeamColor(model)",
  [1228] = "model:GetExtentsSize()",
  [1229] = "root.Position + Vector3.new(0, size.Y / 2, 0)",
  [1230] = "root.Position - Vector3.new(0, size.Y / 2, 0)",
  [1231] = "math.abs(topV2.Y - bottomV2.Y)",
  [1232] = "height / 2",
  [1233] = "model:FindFirstChild(\"Head\") or root",
  [1234] = "rootPos.Y + 25",
  [1235] = "ESP_Config.HPBarHeight",
  [1236] = "math.clamp(hum.Health / hum.MaxHealth, 0, 1)",
  [1237] = "barYFinal",
  [1238] = "getEquippedToolName(model)",
  [1239] = "getInventoryItems(model)",
  [1240] = "getPlayerFromCharacterESP(obj)",
  [1241] = "(targetPart.CFrame * CFrame.new(0, 0, 1)).p",
  [1242] = "hookmetamethod(game, \"__namecall\", function(self, ...)",
  [1243] = "oldNamecall",
  [1244] = "self.Name:lower()",
  [1245] = "modified",
  [1246] = "arg.Position",
  [1247] = "arg.Origin",
  [1248] = "applyBulletTeleport(origin, TargetPart)",
  [1249] = "args[1]",
  [1250] = "args[2]",
  [1251] = "newOrigin",
  [1252] = "(TargetPart.Position - newOrigin).Unit * direction.Magnitude",
  [1253] = "oldNamecall(self, newOrigin, newDir, args[3], args[4])",
  [1254] = "hookmetamethod(game, \"__index\", function(self, key)",
  [1255] = "oldIndex",
  [1256] = "string.lower(key)",
  [1257] = "CFrame.new(applyBulletTeleport(self.Origin, TargetPart))",
  [1258] = "CFrame.new(TargetPart.Position)",
  [1259] = "oldIndex(self, key)",
  [1260] = "UpdateTargetInfo",
  [1261] = "UpdateHighlight",
  [1262] = "scanWorkspace",
  [1263] = "[巫 script] 静默自瞄引擎 v4.3 已加载（原版逻辑）",
  [1264] = "\"[巫 script] 静默自瞄引擎加载失败:\", err",
  [1265] = "Window:AddTab(\"自瞄\")",
  [1266] = "AimTab:AddSection(\"内部静默自瞄 (Universal Pro v4.3)\")",
  [1267] = "\"启用静默自瞄\",",
  [1268] = "function(v)",
  [1269] = "\"FOV\",",
  [1270] = "rawget(_G, \"Circle\") or getgenv().WuSA_Circle",
  [1271] = "\"预判\",",
  [1272] = "function(v) _G.Prediction = v end",
  [1273] = "\"命中率\",",
  [1274] = "function(v) _G.HitChance = v end",
  [1275] = "\"更新间隔\",",
  [1276] = "function(v) _G.UpdateRate = v end",
  [1277] = "\"优先模式\",",
  [1278] = "{\"Crosshair\", \"Distance\", \"LowestHP\"},",
  [1279] = "\"Distance\",",
  [1280] = "function(v) _G.TargetPriority = v end",
  [1281] = "\"粘性瞄准\",",
  [1282] = "function(v) _G.StickyAim = v end",
  [1283] = "\"目标类型\",",
  [1284] = "{\"NPCs\", \"Players\", \"Both\"},",
  [1285] = "\"NPCs\",",
  [1286] = "function(v) _G.TargetMode = v end",
  [1287] = "\"瞄准部位\",",
  [1288] = "{\"Head\", \"Torso\", \"Both\", \"Random\"},",
  [1289] = "\"Head\",",
  [1290] = "function(v) _G.AimPart = v end",
  [1291] = "\"墙壁检测\",",
  [1292] = "function(v) _G.VisibleCheck = v end",
  [1293] = "\"忽略死亡\",",
  [1294] = "function(v) _G.DeadCheck = v end",
  [1295] = "\"距离限制\",",
  [1296] = "function(v) _G.EnableDistanceLimit = v end",
  [1297] = "\"最大瞄准距离\",",
  [1298] = "function(v) _G.MaxAimDistance = v end",
  [1299] = "\"忽略好友\",",
  [1300] = "function(v) _G.FriendCheck = v end",
  [1301] = "\"NPC激进检测\",",
  [1302] = "function(v) _G.AggressiveNPCDetection = v end",
  [1303] = "\"子弹传送\",",
  [1304] = "function(v) _G.BulletTP = v end",
  [1305] = "\"目标高亮\",",
  [1306] = "function(v) _G.HighlightTarget = v end",
  [1307] = "\"显示目标信息\",",
  [1308] = "function(v) _G.ShowTarget = v end",
  [1309] = "\"队友检测(玩家)\",",
  [1310] = "function(v) _G.TeamCheck = v end",
  [1311] = "\"队友检测(NPC)\",",
  [1312] = "function(v) _G.TeamCheckForNPCs = v end",
  [1313] = "AimTab:AddSection(\"外部自瞄脚本\")",
  [1314] = "\"通用静默自瞄\",",
  [1315] = "game:HttpGet(\"https://raw.githubusercontent.com/hm5650/HBSS/refs/heads/main/HBSS.lua\"))(",
  [1316] = "\"npc瞄准\",",
  [1317] = "game:HttpGet(\"https://raw.githubusercontent.com/freedom-gun/V3/main/Script.lua\"))(",
  [1318] = "Window:AddTab(\"玩家管理\")",
  [1319] = "PlayerManageTab:AddSection(\"自动离开\")",
  [1320] = "WuScript_WatchPlayers.txt",
  [1321] = "nil -- 清空输入框用",
  [1322] = "WATCH_FILE, table.concat(WatchPlayerList, \"\\n\")",
  [1323] = "readfile(WATCH_FILE)",
  [1324] = "WatchPlayerList",
  [1325] = "line:gsub(\"^%s+\", \"\"):gsub(\"%s+$\", \"\")",
  [1326] = "line",
  [1327] = "string.lower(line)",
  [1328] = "loadWatchList",
  [1329] = "string.lower(tostring(playerName or \"\"))",
  [1330] = "tostring(raw or \"\"):gsub(\"^%s+\", \"\"):gsub(\"%s+$\", \"\")",
  [1331] = "raw",
  [1332] = "string.lower(raw)",
  [1333] = "false, \"已在名单中\"",
  [1334] = "saveWatchList",
  [1335] = "true, lower",
  [1336] = "WatchSection:AddTextbox({",
  [1337] = "\"添加监控玩家\",",
  [1338] = "\"输入一个名字后按回车保存\",",
  [1339] = "PlaceholderText",
  [1340] = "function(text)",
  [1341] = "tostring(text or \"\"):gsub(\"^%s+\", \"\"):gsub(\"%s+$\", \"\")",
  [1342] = "text",
  [1343] = "nameBoxAPI",
  [1344] = "Set",
  [1345] = "\"查看已保存名单\",",
  [1346] = "\"一键清除已知名单\",",
  [1347] = "WATCH_FILE, \"\"",
  [1348] = "\"指定玩家进入时自动离开\",",
  [1349] = "WatchPlayerEnabled",
  [1350] = "doLeaveServer",
  [1351] = "\"人数上限\",",
  [1352] = "WatchCountLimit",
  [1353] = "\"人数达到上限时自动离开\",",
  [1354] = "WatchCountEnabled",
  [1355] = "#game:GetService(\"Players\"):GetPlayers()",
  [1356] = "Window:AddTab(\"更多脚本\")",
  [1357] = "MoreScriptsTab:AddSection(\"脚本合集\")",
  [1358] = "key or url",
  [1359] = "addMoreScript",
  [1360] = "叶脚本\", \"https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua",
  [1361] = "黑白脚本\", \"https://raw.githubusercontent.com/tfcygvunbind/Apple/main/黑白脚本加载器\", \"黑白脚本",
  [1362] = "\"[巫 script] 功能失败:\", errFeat",
  [1363] = "function() notify(\"错误\", tostring(errFeat), 8) end",
  [1364] = "[巫 script] 完成",
  [1365] = "function() notify(\"巫 script\", \"已加载\", 3) end",
  [1366] = "(gethui and gethui()) or nil",
  [1367] = "function() table.insert(hosts, game:GetService(\"CoreGui\")) end",
  [1368] = "game:GetService(\"Players\").LocalPlayer:FindFirstChild(\"PlayerGui\")",
  [1369] = "SetAttribute",
  [1370] = "sf:FindFirstChildOfClass(\"UIListLayout\")",
  [1371] = "layout.AbsoluteContentSize.Y + 40",
  [1372] = "_NP(Window, {",
  [1373] = "\"设置\",",
  [1374] = "\"界面 · 主题 · 字体\",",
  [1375] = "\"settings\",",
  [1376] = "SettingsPage",
  [1377] = "Section",
  [1378] = "界面",
  [1379] = "math.clamp(tonumber(scale) or 1, 0.5, 1.5)",
  [1380] = "scale",
  [1381] = "root",
  [1382] = "root:FindFirstChildWhichIsA(\"Frame\", false)",
  [1383] = "ch",
  [1384] = "main",
  [1385] = "main or root",
  [1386] = "target:FindFirstChild(\"WuOnlyUIScale\")",
  [1387] = "Instance.new(\"UIScale\")",
  [1388] = "\"界面缩放(%)\",",
  [1389] = 150,
  [1390] = "math.floor((getgenv().WuUIScale or 1) * 100 + 0.5),",
  [1391] = "\"%\",",
  [1392] = "WuApplyScale",
  [1393] = "(tonumber(v) or 100) / 100",
  [1394] = "字体大小",
  [1395] = "\"字体大小(%)\",",
  [1396] = 80,
  [1397] = 140,
  [1398] = "hasWu",
  [1399] = "inst:GetAttribute(\"WuBaseTextSize\")",
  [1400] = "inst.TextSize",
  [1401] = "origin",
  [1402] = "主题颜色",
  [1403] = "Color3.fromRGB(100, 149, 237),",
  [1404] = "Color3.fromRGB(16, 16, 18),",
  [1405] = "Color3.fromRGB(235, 235, 235),",
  [1406] = "Color3.fromRGB(12, 14, 18),",
  [1407] = "Color3.fromRGB(235, 240, 255),",
  [1408] = "Color3.fromRGB(0, 220, 140),",
  [1409] = "Color3.fromRGB(12, 16, 14),",
  [1410] = "Color3.fromRGB(230, 255, 240),",
  [1411] = "Color3.fromRGB(170, 90, 255),",
  [1412] = "Color3.fromRGB(16, 12, 20),",
  [1413] = "Color3.fromRGB(240, 230, 255),",
  [1414] = "Color3.fromRGB(255, 70, 70),",
  [1415] = "Color3.fromRGB(18, 12, 12),",
  [1416] = "Color3.fromRGB(255, 235, 235),",
  [1417] = "Color3.fromRGB(255, 150, 40),",
  [1418] = "Color3.fromRGB(18, 14, 10),",
  [1419] = "Color3.fromRGB(255, 245, 230),",
  [1420] = "Color3.fromRGB(255, 110, 180),",
  [1421] = "Color3.fromRGB(18, 12, 16),",
  [1422] = "Color3.fromRGB(255, 235, 245),",
  [1423] = "Color3.fromRGB(180, 180, 190),",
  [1424] = "Color3.fromRGB(8, 8, 10),",
  [1425] = "Color3.fromRGB(220, 220, 225),",
  [1426] = "\"主题预设\",",
  [1427] = "names,",
  [1428] = "\"冰蓝\",",
  [1429] = "function(name)",
  [1430] = "themes[name]",
  [1431] = "Library",
  [1432] = "SetTheme",
  [1433] = "th.Accent",
  [1434] = "th.Background",
  [1435] = "\"主题\", \"已切换: \" .. tostring(name), 2",
  [1436] = "其它",
  [1437] = "\"重置\",",
  [1438] = "WuScript_ForceKeyEntry.txt\", \"1",
  [1439] = "\"卡密\", \"已清除，下次执行需重新输入\", 3",
  [1440] = "\"复制作者联系方式\",",
  [1441] = "\"复制\",",
  [1442] = "\"联系\", CONTACT, 2",
  [1443] = "\"菜单快捷键提示\",",
  [1444] = "function(key)",
  [1445] = "\"快捷键\", \"当前: \" .. tostring(key and key.Name), 2",
  [1446] = "[巫 script] 设置板块已创建",
  [1447] = "layout",
  [1448] = "layout.AbsoluteContentSize.Y + 50",
  [1449] = "\"[巫 script] 设置板块失败:\", err",
}

_VM.locals = {
  [0] = "WuWhitelistEnabled",
  [1] = "WuWhitelistUserIds",
  [2] = "WuWhitelistNames",
  [3] = "lp",
  [4] = "uid",
  [5] = "name",
  [6] = "dname",
  [7] = "ln",
  [8] = "listEmpty",
  [9] = "contact",
  [10] = "KEY_FILE",
  [11] = "FORCE_KEY_FILE",
  [12] = "CURRENT_KEY",
  [13] = "normalized",
  [14] = "expected",
  [15] = "names",
  [16] = "low",
  [17] = "hui",
  [18] = "g",
  [19] = "Patriot",
  [20] = "saved",
  [21] = "done",
  [22] = "sg",
  [23] = "f",
  [24] = "title",
  [25] = "tb",
  [26] = "btn",
  [27] = "_tmp_obj_9611",
  [28] = "keyOk",
  [29] = "valid",
  [30] = "error",
  [31] = "message",
  [32] = "Title",
  [33] = "Subtitle",
  [34] = "Icon",
  [35] = "IconSize",
  [36] = "GetKey",
  [37] = "Discord",
  [38] = "forceKey",
  [39] = "FileName",
  [40] = "Remember",
  [41] = "AutoLoad",
  [42] = "Keyless",
  [43] = "Blur",
  [44] = "Draggable",
  [45] = "Accent",
  [46] = "AccentHover",
  [47] = "Background",
  [48] = "Header",
  [49] = "Input",
  [50] = "Text",
  [51] = "TextDim",
  [52] = "Success",
  [53] = "Error",
  [54] = "Warning",
  [55] = "StatusIdle",
  [56] = "DiscordHover",
  [57] = "Divider",
  [58] = "Pending",
  [59] = "keyClosed",
  [60] = "_tmp_obj_424",
  [61] = "Enabled",
  [62] = "AntiKickEnabled",
  [63] = "players",
  [64] = "oldKick",
  [65] = "ReplicatedStorage",
  [66] = "AdonisDetected",
  [67] = "remotes",
  [68] = "remote",
  [69] = "mt",
  [70] = "oldNamecall",
  [71] = "method",
  [72] = "selfName",
  [73] = "logService",
  [74] = "logs",
  [75] = "TweenService",
  [76] = "player",
  [77] = "playerGui",
  [78] = "NEON",
  [79] = "GLOW",
  [80] = "screenGui",
  [81] = "black",
  [82] = "BackgroundTransparency",
  [83] = "codeLines",
  [84] = "codePanel",
  [85] = "codeLabel",
  [86] = "maxVisible",
  [87] = "shown",
  [88] = "codeRunning",
  [89] = "s",
  [90] = "_tmp_obj_6005",
  [91] = "i",
  [92] = "line",
  [93] = "stage",
  [94] = "grid",
  [95] = "list",
  [96] = "tips",
  [97] = "rows",
  [98] = "delayIndex",
  [99] = "strip",
  [100] = "hlist",
  [101] = "tip",
  [102] = "stroke",
  [103] = "label",
  [104] = "delay",
  [105] = "sub",
  [106] = "running",
  [107] = "TextTransparency",
  [108] = "_tmp_obj_1771",
  [109] = "_tmp_obj_5679",
  [110] = "_tmp_obj_9523",
  [111] = "_tmp_obj_5569",
  [112] = "skipBtn",
  [113] = "skipLoading",
  [114] = "_tmp_obj_9511",
  [115] = "_tmp_obj_5729",
  [116] = "t0",
  [117] = "softFade",
  [118] = "_tmp_obj_807",
  [119] = "_tmp_obj_9980",
  [120] = "_tmp_obj_7567",
  [121] = "mosaic",
  [122] = "cam",
  [123] = "vp",
  [124] = "cellPx",
  [125] = "COLS",
  [126] = "ROWS",
  [127] = "cells",
  [128] = "NEON_A",
  [129] = "NEON_B",
  [130] = "cell",
  [131] = "corner",
  [132] = "dist",
  [133] = "frame",
  [134] = "fullSize",
  [135] = "_tmp_obj_5332",
  [136] = "s2",
  [137] = "_tmp_obj_4781",
  [138] = "maxDelay",
  [139] = "Size",
  [140] = "doneLabel",
  [141] = "_tmp_obj_9278",
  [142] = "_tmp_obj_336",
  [143] = "fb",
  [144] = "_tmp_obj_3784",
  [145] = "Window",
  [146] = "SubTitle",
  [147] = "ToggleKey",
  [148] = "Scale",
  [149] = "AutoScale",
  [150] = "r",
  [151] = "_",
  [152] = "host",
  [153] = "_tmp_obj_3771",
  [154] = "Desc",
  [155] = "Duration",
  [156] = "sec",
  [157] = "t",
  [158] = "Callback",
  [159] = "Value",
  [160] = "Min",
  [161] = "Max",
  [162] = "Rounding",
  [163] = "Suffix",
  [164] = "box",
  [165] = "Placeholder",
  [166] = "ClearOnSubmit",
  [167] = "List",
  [168] = "text",
  [169] = "_NewPage",
  [170] = "page",
  [171] = "proxy",
  [172] = "tx",
  [173] = "sz",
  [174] = "w",
  [175] = "h",
  [176] = "MainTab",
  [177] = "SpeedSection",
  [178] = "Name",
  [179] = "Default",
  [180] = "Increment",
  [181] = "Notifications",
  [182] = "VelocitySpeed",
  [183] = "VelocityEnabled",
  [184] = "VelocityConnection",
  [185] = "char",
  [186] = "root",
  [187] = "hum",
  [188] = "moveDir",
  [189] = "_tmp_obj_7017",
  [190] = "_tmp_obj_891",
  [191] = "_tmp_obj_3532",
  [192] = "HighJumpPower",
  [193] = "HighJumpEnabled",
  [194] = "highJumpListener",
  [195] = "charAddedConn",
  [196] = "_tmp_obj_2227",
  [197] = "_tmp_obj_3555",
  [198] = "_tmp_obj_7314",
  [199] = "_tmp_obj_1010",
  [200] = "_tmp_obj_8988",
  [201] = "_tmp_obj_459",
  [202] = "_tmp_obj_8744",
  [203] = "ResetSection",
  [204] = "_tmp_obj_6599",
  [205] = "_tmp_obj_6572",
  [206] = "_tmp_obj_2916",
  [207] = "Content",
  [208] = "SettingTab",
  [209] = "InfoSection",
  [210] = "executor",
  [211] = "ACSection",
  [212] = "_tmp_obj_1420",
  [213] = "_tmp_obj_1360",
  [214] = "KeySection",
  [215] = "UtilitySection",
  [216] = "_tmp_obj_3684",
  [217] = "Tab1",
  [218] = "VisualSection",
  [219] = "NightVision",
  [220] = "_tmp_obj_8145",
  [221] = "noclipEnabled",
  [222] = "_tmp_obj_8562",
  [223] = "_tmp_obj_467",
  [224] = "InfiniteJumpEnabled",
  [225] = "_tmp_obj_6898",
  [226] = "ToolSection",
  [227] = "mouse",
  [228] = "tool",
  [229] = "pos",
  [230] = "_tmp_obj_8524",
  [231] = "url",
  [232] = "_tmp_obj_7803",
  [233] = "_tmp_obj_1655",
  [234] = "Tab2",
  [235] = "HitboxSection",
  [236] = "HitboxSize",
  [237] = "HitboxEnabled",
  [238] = "_tmp_obj_6707",
  [239] = "_tmp_obj_5671",
  [240] = "_tmp_obj_6142",
  [241] = "_tmp_obj_313",
  [242] = "_tmp_obj_2775",
  [243] = "_tmp_obj_4898",
  [244] = "_tmp_obj_9039",
  [245] = "_tmp_obj_2028",
  [246] = "_tmp_obj_8783",
  [247] = "_tmp_obj_2844",
  [248] = "_tmp_obj_8719",
  [249] = "Tab3",
  [250] = "FlingSection",
  [251] = "AllBool",
  [252] = "OldPos",
  [253] = "FPDH",
  [254] = "GetPlayers",
  [255] = "Player",
  [256] = "Character",
  [257] = "Humanoid",
  [258] = "RootPart",
  [259] = "TCharacter",
  [260] = "THumanoid",
  [261] = "TRootPart",
  [262] = "THead",
  [263] = "Accessory",
  [264] = "Handle",
  [265] = "FPos",
  [266] = "_tmp_obj_711",
  [267] = "SFBasePart",
  [268] = "TimeToWait",
  [269] = "Time",
  [270] = "Angle",
  [271] = "BV",
  [272] = "_tmp_obj_3073",
  [273] = "_tmp_obj_9584",
  [274] = "_tmp_obj_9606",
  [275] = "_tmp_obj_1729",
  [276] = "_tmp_obj_2311",
  [277] = "Players",
  [278] = "Targets",
  [279] = "TPlayer",
  [280] = "_tmp_obj_426",
  [281] = "_tmp_obj_8896",
  [282] = "selectedPlayer",
  [283] = "playerList",
  [284] = "dropdown",
  [285] = "Options",
  [286] = "_tmp_obj_8486",
  [287] = "_tmp_obj_2007",
  [288] = "_tmp_obj_5646",
  [289] = "target",
  [290] = "_tmp_obj_5390",
  [291] = "_tmp_obj_5069",
  [292] = "CollisionAntiFlingEnabled",
  [293] = "CollisionAntiFlingConnections",
  [294] = "childAddedConn",
  [295] = "steppedConn",
  [296] = "_tmp_obj_1674",
  [297] = "_tmp_obj_5611",
  [298] = "_tmp_obj_6091",
  [299] = "TpSection",
  [300] = "LoopTpToPlayer",
  [301] = "LoopBringPlayer",
  [302] = "Spectating",
  [303] = "myRoot",
  [304] = "_tmp_obj_185",
  [305] = "_tmp_obj_8068",
  [306] = "_tmp_obj_2515",
  [307] = "_tmp_obj_2172",
  [308] = "_tmp_obj_4929",
  [309] = "_tmp_obj_6304",
  [310] = "_tmp_obj_385",
  [311] = "_tmp_obj_4690",
  [312] = "_tmp_obj_7330",
  [313] = "_tmp_obj_1568",
  [314] = "_tmp_obj_1783",
  [315] = "Tab4",
  [316] = "VisSection",
  [317] = "_tmp_obj_6643",
  [318] = "RunService",
  [319] = "Stats",
  [320] = "LocalPlayer",
  [321] = "ScreenGui",
  [322] = "Frame",
  [323] = "TitleLabel",
  [324] = "FPSText",
  [325] = "PingText",
  [326] = "fps",
  [327] = "ping",
  [328] = "fpsRating",
  [329] = "pingRating",
  [330] = "_tmp_obj_8021",
  [331] = "LBLG",
  [332] = "LBL",
  [333] = "_tmp_obj_8260",
  [334] = "_tmp_obj_6891",
  [335] = "UtilSection2",
  [336] = "_tmp_obj_5861",
  [337] = "_tmp_obj_1961",
  [338] = "autoInteractEnabled",
  [339] = "autoInteractLoop",
  [340] = "_tmp_obj_6756",
  [341] = "_tmp_obj_5294",
  [342] = "_tmp_obj_2347",
  [343] = "quickInteractConnection",
  [344] = "_tmp_obj_8091",
  [345] = "_tmp_obj_4319",
  [346] = "Tab5",
  [347] = "MoveSection",
  [348] = "SpinSection",
  [349] = "speaker",
  [350] = "Anim",
  [351] = "bruh",
  [352] = "_tmp_obj_3258",
  [353] = "_tmp_obj_3249",
  [354] = "hi",
  [355] = "_tmp_obj_2023",
  [356] = "spinSpeed",
  [357] = "Spin",
  [358] = "_tmp_obj_7450",
  [359] = "_tmp_obj_8165",
  [360] = "_tmp_obj_415",
  [361] = "_tmp_obj_3411",
  [362] = "MiscSection",
  [363] = "new",
  [364] = "oldhum",
  [365] = "newhum",
  [366] = "_tmp_obj_8595",
  [367] = "_tmp_obj_7986",
  [368] = "_tmp_obj_1883",
  [369] = "_tmp_obj_4931",
  [370] = "_tmp_obj_4687",
  [371] = "_tmp_obj_5623",
  [372] = "_tmp_obj_5962",
  [373] = "UIS",
  [374] = "fc",
  [375] = "dragging",
  [376] = "dragStart",
  [377] = "startPos",
  [378] = "d",
  [379] = "statusLabel",
  [380] = "sc",
  [381] = "b",
  [382] = "c",
  [383] = "onBtn",
  [384] = "offBtn",
  [385] = "autoBtn",
  [386] = "autoJumpBtn",
  [387] = "dfBtn",
  [388] = "destroyBtn",
  [389] = "lab",
  [390] = "bg",
  [391] = "bc",
  [392] = "knob",
  [393] = "scale0",
  [394] = "kc",
  [395] = "value",
  [396] = "active",
  [397] = "getFlickSpeed",
  [398] = "getDfMult",
  [399] = "getAngle",
  [400] = "state",
  [401] = "rayParams",
  [402] = "hrp",
  [403] = "m",
  [404] = "dir",
  [405] = "n",
  [406] = "away",
  [407] = "look",
  [408] = "maxA",
  [409] = "dot",
  [410] = "ang",
  [411] = "cross",
  [412] = "sign",
  [413] = "infl",
  [414] = "_tmp_obj_2559",
  [415] = "jumpConn",
  [416] = "autoConn",
  [417] = "_tmp_obj_1578",
  [418] = "_tmp_obj_6476",
  [419] = "_tmp_obj_7036",
  [420] = "_tmp_obj_9854",
  [421] = "Tab6",
  [422] = "TsbSection",
  [423] = "TX",
  [424] = "Script",
  [425] = "_tmp_obj_38",
  [426] = "_tmp_obj_2156",
  [427] = "_tmp_obj_3423",
  [428] = "_tmp_obj_6247",
  [429] = "_tmp_obj_6632",
  [430] = "_tmp_obj_5077",
  [431] = "_tmp_obj_3066",
  [432] = "_tmp_obj_8866",
  [433] = "key",
  [434] = "_tmp_obj_4528",
  [435] = "_tmp_obj_9857",
  [436] = "_tmp_obj_3067",
  [437] = "_tmp_obj_428",
  [438] = "_tmp_obj_4143",
  [439] = "_tmp_obj_8007",
  [440] = "_tmp_obj_6432",
  [441] = "_tmp_obj_2607",
  [442] = "_tmp_obj_9726",
  [443] = "_tmp_obj_8881",
  [444] = "_tmp_obj_3010",
  [445] = "_tmp_obj_3380",
  [446] = "_tmp_obj_999",
  [447] = "_tmp_obj_9786",
  [448] = "_tmp_obj_8572",
  [449] = "_tmp_obj_750",
  [450] = "_tmp_obj_4273",
  [451] = "_tmp_obj_5999",
  [452] = "_tmp_obj_5316",
  [453] = "_tmp_obj_4863",
  [454] = "_tmp_obj_1632",
  [455] = "_tmp_obj_9294",
  [456] = "_tmp_obj_9731",
  [457] = "_tmp_obj_458",
  [458] = "_tmp_obj_2278",
  [459] = "_tmp_obj_898",
  [460] = "_tmp_obj_159",
  [461] = "_tmp_obj_9645",
  [462] = "_tmp_obj_9354",
  [463] = "_tmp_obj_7853",
  [464] = "_tmp_obj_1864",
  [465] = "_tmp_obj_2398",
  [466] = "_tmp_obj_8054",
  [467] = "_tmp_obj_4396",
  [468] = "_tmp_obj_2252",
  [469] = "_tmp_obj_6688",
  [470] = "_tmp_obj_923",
  [471] = "_tmp_obj_5363",
  [472] = "_tmp_obj_8709",
  [473] = "_tmp_obj_8784",
  [474] = "_tmp_obj_3928",
  [475] = "_tmp_obj_7490",
  [476] = "_tmp_obj_5497",
  [477] = "_tmp_obj_4027",
  [478] = "_tmp_obj_2093",
  [479] = "_tmp_obj_7055",
  [480] = "_tmp_obj_7202",
  [481] = "_tmp_obj_26",
  [482] = "_tmp_obj_230",
  [483] = "_tmp_obj_5156",
  [484] = "_tmp_obj_4667",
  [485] = "_tmp_obj_8671",
  [486] = "_tmp_obj_5858",
  [487] = "_tmp_obj_434",
  [488] = "_tmp_obj_9064",
  [489] = "_tmp_obj_8322",
  [490] = "_tmp_obj_5720",
  [491] = "_tmp_obj_7340",
  [492] = "_tmp_obj_7525",
  [493] = "_tmp_obj_9546",
  [494] = "_tmp_obj_1379",
  [495] = "_tmp_obj_945",
  [496] = "_tmp_obj_1842",
  [497] = "_tmp_obj_6627",
  [498] = "_tmp_obj_6775",
  [499] = "_tmp_obj_6063",
  [500] = "_tmp_obj_3454",
  [501] = "_tmp_obj_4072",
  [502] = "_tmp_obj_5086",
  [503] = "_tmp_obj_7451",
  [504] = "_tmp_obj_4290",
  [505] = "_tmp_obj_7872",
  [506] = "_tmp_obj_5876",
  [507] = "_tmp_obj_7159",
  [508] = "_tmp_obj_3197",
  [509] = "_tmp_obj_3920",
  [510] = "_tmp_obj_8886",
  [511] = "_tmp_obj_2430",
  [512] = "_tmp_obj_3481",
  [513] = "_tmp_obj_5405",
  [514] = "_tmp_obj_6072",
  [515] = "_tmp_obj_8794",
  [516] = "args",
  [517] = "_tmp_obj_8460",
  [518] = "_tmp_obj_6689",
  [519] = "_tmp_obj_1548",
  [520] = "_tmp_obj_5860",
  [521] = "_tmp_obj_8379",
  [522] = "_tmp_obj_3883",
  [523] = "_tmp_obj_8676",
  [524] = "_tmp_obj_8725",
  [525] = "_tmp_obj_8668",
  [526] = "_tmp_obj_480",
  [527] = "_tmp_obj_8207",
  [528] = "_tmp_obj_4507",
  [529] = "_tmp_obj_3408",
  [530] = "_tmp_obj_2595",
  [531] = "EspTab",
  [532] = "MasterSection",
  [533] = "ESPEnabled",
  [534] = "_tmp_obj_8004",
  [535] = "_tmp_obj_782",
  [536] = "_tmp_obj_7929",
  [537] = "_tmp_obj_4427",
  [538] = "BoxSection",
  [539] = "TracerSection",
  [540] = "HealthSection",
  [541] = "InfoSection2",
  [542] = "ChamsSection",
  [543] = "TeamSection",
  [544] = "NpcSection",
  [545] = "NPCESPEnabled",
  [546] = "NPCESPThread",
  [547] = "NPCHighlightName",
  [548] = "highlight",
  [549] = "_tmp_obj_3834",
  [550] = "_tmp_obj_5279",
  [551] = "_tmp_obj_8014",
  [552] = "_tmp_obj_9088",
  [553] = "_tmp_obj_9341",
  [554] = "ExtraTab",
  [555] = "CombatSection",
  [556] = "AutoAttackEnabled",
  [557] = "AutoAttackConnection",
  [558] = "_tmp_obj_6126",
  [559] = "handle",
  [560] = "touch",
  [561] = "otherChars",
  [562] = "params",
  [563] = "parts",
  [564] = "model",
  [565] = "thum",
  [566] = "_tmp_obj_8879",
  [567] = "_tmp_obj_4286",
  [568] = "_tmp_obj_3111",
  [569] = "_tmp_obj_9194",
  [570] = "_tmp_obj_636",
  [571] = "_tmp_obj_6262",
  [572] = "_tmp_obj_9081",
  [573] = "_tmp_obj_2514",
  [574] = "CharSection",
  [575] = "_tmp_obj_138",
  [576] = "ToolSection2",
  [577] = "_tmp_obj_658",
  [578] = "_tmp_obj_3753",
  [579] = "_tmp_obj_508",
  [580] = "_tmp_obj_1848",
  [581] = "StealBackpackEnabled",
  [582] = "StealBackpackThread",
  [583] = "_tmp_obj_8871",
  [584] = "_tmp_obj_9057",
  [585] = "UtilSection3",
  [586] = "_tmp_obj_8018",
  [587] = "_tmp_obj_7827",
  [588] = "_tmp_obj_2793",
  [589] = "_tmp_obj_4670",
  [590] = "Main",
  [591] = "TabList",
  [592] = "Scroll",
  [593] = "_tmp_obj_7430",
  [594] = "Environment",
  [595] = "BoxESP",
  [596] = "BoxStyle",
  [597] = "BoxThickness",
  [598] = "BoxFilled",
  [599] = "BoxFillTransparency",
  [600] = "CornerLength",
  [601] = "TracerESP",
  [602] = "TracerOrigin",
  [603] = "HealthESP",
  [604] = "HealthStyle",
  [605] = "NameESP",
  [606] = "ShowDistance",
  [607] = "TextSize",
  [608] = "ChamsEnabled",
  [609] = "ChamsFillColor",
  [610] = "ChamsTransparency",
  [611] = "ChamsOutlineColor",
  [612] = "ChamsOutlineTransparency",
  [613] = "TeamCheck",
  [614] = "ShowTeam",
  [615] = "MaxDistance",
  [616] = "AllyColor",
  [617] = "EnemyColor",
  [618] = "RefreshRate",
  [619] = "RawRenderAPI",
  [620] = "ESP",
  [621] = "Camera",
  [622] = "Drawings",
  [623] = "sizeCache",
  [624] = "weaponCache",
  [625] = "hpAnim",
  [626] = "retryAt",
  [627] = "lastProps",
  [628] = "sq",
  [629] = "txt",
  [630] = "boxKeys",
  [631] = "tracer",
  [632] = "tracerOutline",
  [633] = "healthBar",
  [634] = "Delay",
  [635] = "Outline",
  [636] = "Fill",
  [637] = "Glow",
  [638] = "info",
  [639] = "Distance",
  [640] = "Weapon",
  [641] = "Box",
  [642] = "TracerOutline",
  [643] = "esp",
  [644] = "color",
  [645] = "hpPct",
  [646] = "hpColor",
  [647] = "size",
  [648] = "cf",
  [649] = "top",
  [650] = "bottom",
  [651] = "bx",
  [652] = "by",
  [653] = "bw",
  [654] = "bh",
  [655] = "thick",
  [656] = "TL",
  [657] = "TR",
  [658] = "BL",
  [659] = "BR",
  [660] = "cLen",
  [661] = "cH",
  [662] = "oThick",
  [663] = "from",
  [664] = "to",
  [665] = "barW",
  [666] = "barX",
  [667] = "barY",
  [668] = "barH",
  [669] = "fillH",
  [670] = "fillTopY",
  [671] = "centerX",
  [672] = "fs",
  [673] = "wep",
  [674] = "hl",
  [675] = "lastUpdate",
  [676] = "wasEnabled",
  [677] = "enabled",
  [678] = "now",
  [679] = "_tmp_obj_6879",
  [680] = "ShowPlayers",
  [681] = "ShowNPCs",
  [682] = "DeadCheck",
  [683] = "NameTextSize",
  [684] = "DistanceTextSize",
  [685] = "InventoryTextSize",
  [686] = "HPBarWidth",
  [687] = "HPBarHeight",
  [688] = "ShowBox",
  [689] = "ShowLine",
  [690] = "ShowStick",
  [691] = "ShowName",
  [692] = "ShowHPBar",
  [693] = "ShowEquippedItem",
  [694] = "ShowInventory",
  [695] = "UseTeamColor",
  [696] = "LineColor",
  [697] = "StickColor",
  [698] = "UserInputService",
  [699] = "HttpService",
  [700] = "CollectionService",
  [701] = "Mouse",
  [702] = "Circle",
  [703] = "TargetInfo",
  [704] = "TargetHighlight",
  [705] = "HighlightConnection",
  [706] = "CurrentTarget",
  [707] = "TargetPart",
  [708] = "TargetInRange",
  [709] = "NPCCache",
  [710] = "PlayerCache",
  [711] = "LastCacheUpdate",
  [712] = "CacheUpdateInterval",
  [713] = "oldIndex",
  [714] = "ESP_Objects",
  [715] = "humanoid",
  [716] = "bodyEffects",
  [717] = "ko",
  [718] = "isPlayer",
  [719] = "pulse",
  [720] = "NPCTags",
  [721] = "head",
  [722] = "charName",
  [723] = "npcFolders",
  [724] = "folder",
  [725] = "possibleNPCIndicators",
  [726] = "valLower",
  [727] = "hasAIBehavior",
  [728] = "childName",
  [729] = "tags",
  [730] = "tagLower",
  [731] = "npcAbilities",
  [732] = "namePatterns",
  [733] = "foundNPCs",
  [734] = "subNPCs",
  [735] = "npcTeamValue",
  [736] = "npcTeam",
  [737] = "localTeam",
  [738] = "isEnemy",
  [739] = "torso",
  [740] = "currentTime",
  [741] = "tempNPCCache",
  [742] = "tempPlayerCache",
  [743] = "allModels",
  [744] = "wsChildren",
  [745] = "npcsInFolder",
  [746] = "counter",
  [747] = "descendants",
  [748] = "processCounter",
  [749] = "localPos",
  [750] = "targetPos",
  [751] = "distance",
  [752] = "screenCenter",
  [753] = "screenPoint",
  [754] = "raycastParams",
  [755] = "origin",
  [756] = "direction",
  [757] = "ray",
  [758] = "hitPart",
  [759] = "bestScore",
  [760] = "closestPart",
  [761] = "closestTarget",
  [762] = "localChar",
  [763] = "localRoot",
  [764] = "targetPart",
  [765] = "distFromCenter",
  [766] = "isVisible",
  [767] = "currentScore",
  [768] = "randomNumber",
  [769] = "baseChance",
  [770] = "distanceFactor",
  [771] = "fovFactor",
  [772] = "finalChance",
  [773] = "randomVariation",
  [774] = "shouldShowHitChance",
  [775] = "infoLines",
  [776] = "targetName",
  [777] = "targetType",
  [778] = "obj",
  [779] = "items",
  [780] = "plr",
  [781] = "teamValue",
  [782] = "cameraPos",
  [783] = "isModelAlly",
  [784] = "tc",
  [785] = "height",
  [786] = "width",
  [787] = "barYFinal",
  [788] = "barHFinal",
  [789] = "hpPercent",
  [790] = "itemName",
  [791] = "invText",
  [792] = "owner",
  [793] = "newArgs",
  [794] = "modified",
  [795] = "newOrigin",
  [796] = "newDir",
  [797] = "keyLower",
  [798] = "isPlayerTarget",
  [799] = "_tmp_obj_5324",
  [800] = "AimTab",
  [801] = "SASection",
  [802] = "_tmp_obj_554",
  [803] = "ExtAim",
  [804] = "_tmp_obj_1902",
  [805] = "_tmp_obj_7452",
  [806] = "PlayerManageTab",
  [807] = "WatchSection",
  [808] = "WATCH_FILE",
  [809] = "WatchPlayerList",
  [810] = "WatchPlayerEnabled",
  [811] = "WatchCountLimit",
  [812] = "WatchCountEnabled",
  [813] = "clearNameBox",
  [814] = "_tmp_obj_1836",
  [815] = "lower",
  [816] = "exists",
  [817] = "raw",
  [818] = "nameBoxAPI",
  [819] = "PlaceholderText",
  [820] = "_tmp_obj_7161",
  [821] = "_tmp_obj_290",
  [822] = "_tmp_obj_1797",
  [823] = "_tmp_obj_3790",
  [824] = "_tmp_obj_7690",
  [825] = "_tmp_obj_5074",
  [826] = "_tmp_obj_4599",
  [827] = "_tmp_obj_7049",
  [828] = "_tmp_obj_8915",
  [829] = "_tmp_obj_3734",
  [830] = "_tmp_obj_725",
  [831] = "_tmp_obj_1267",
  [832] = "count",
  [833] = "_tmp_obj_423",
  [834] = "_tmp_obj_9016",
  [835] = "_tmp_obj_5753",
  [836] = "_tmp_obj_7651",
  [837] = "_tmp_obj_9891",
  [838] = "MoreScriptsTab",
  [839] = "MoreSection",
  [840] = "k",
  [841] = "_tmp_obj_9228",
  [842] = "_tmp_obj_5519",
  [843] = "hosts",
  [844] = "pg",
  [845] = "seen",
  [846] = "_tmp_obj_5274",
  [847] = "layout",
  [848] = "y",
  [849] = "_NP",
  [850] = "SettingsPage",
  [851] = "_tmp_obj_5785",
  [852] = "scale",
  [853] = "roots",
  [854] = "_tmp_obj_9517",
  [855] = "main",
  [856] = "us",
  [857] = "_tmp_obj_865",
  [858] = "_tmp_obj_3757",
  [859] = "mul",
  [860] = "hasWu",
  [861] = "_tmp_obj_2551",
  [862] = "_tmp_obj_7543",
  [863] = "themes",
  [864] = "th",
  [865] = "_tmp_obj_906",
  [866] = "ac",
  [867] = "_tmp_obj_9359",
  [868] = "CONTACT",
  [869] = "_tmp_obj_9312",
}

_VM.upvals = {
}

_VM.bytecode = {
  -- --[[ 巫 script · Vita UI · 完整功能移植 ]]
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=1},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: if getgenv().WuScript_GUI then getgenv().WuScript_GUI:Destroy() end
  -- RAW: end)
  -- RAW: getgenv().WuScript_Running = true
  -- RAW: _G.LoadedScripts = _G.LoadedScripts or {}
  -- 
  -- -- 白名单门禁：只有名单内才能进入卡密界面，否则踢出
  -- -- 请把你的 UserId 填进 WuWhitelistUserIds
  -- -- 用户名可选填 WuWhitelistNames（不区分大小写）
  -- -------------------------------------------------
  {op=1,a=0,bx=4},
  {op=9,a=1,b=0,c=0},
  -- -- 可选：UserId（更稳，改名也不影响）
  -- -- 123456789,
  -- RAW: }
  {op=9,a=2,b=0,c=0},
  -- RAW: "AK91_JB",
  -- RAW: "GOTUXT",
  -- RAW: }
  -- 
  -- RAW: local function WuIsWhitelisted()
  -- RAW: if not WuWhitelistEnabled then return true end
  {op=1,a=3,bx=5},
  -- RAW: if not lp then return false end
  {op=1,a=4,bx=6},
  -- RAW: for _, id in ipairs(WuWhitelistUserIds) do
  -- RAW: if tonumber(id) == uid then return true end
  {op=29,a=0,b=1},
  {op=1,a=5,bx=7},
  {op=1,a=6,bx=8},
  -- RAW: for _, n in ipairs(WuWhitelistNames) do
  {op=1,a=7,bx=9},
  -- RAW: if ln == name or ln == dname then return true end
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- -- 名单为空时：避免把自己锁死，仅提示并放行（请尽快填入 UserId）
  {op=1,a=8,bx=11},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=12},
  {op=1,a=1,bx=13},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  -- -- 不在白名单：先复制作者联系方式到剪切板，再官方踢出
  {op=1,a=9,bx=14},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=15},
  {op=0,a=1,b=9},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=16},
  {op=0,a=1,b=9},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  -- RAW: Clipboard.set(contact)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: game:GetService("Players").LocalPlayer:Kick(
  -- RAW: "错误代码：277\n你不在白名单内，无法使用此脚本。\n作者联系方式已复制到剪贴板：" .. contact
  -- RAW: )
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- -------------------------------------------------
  -- -- Patriot 卡密 UI + 记住系统
  -- -- 换卡密：只改下面 CURRENT_KEY
  -- -------------------------------------------------
  {op=1,a=10,bx=17},
  {op=1,a=11,bx=18},
  -- -- 卡密：by wu（Patriot 会去掉空格，所以输入 by wu 或 bywu 都可以）
  {op=1,a=12,bx=19},
  -- 
  -- RAW: local function isValidPass(pass)
  -- RAW: if not pass or pass == "" then return false end
  -- -- Patriot 提交前会 gsub("%s+", "")，必须按去空格后比较
  {op=1,a=13,bx=20},
  {op=1,a=14,bx=21},
  {op=1,a=0,bx=22},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function clearSavedKey()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=9,a=15,b=0,c=0},
  -- RAW: KEY_FILE,
  -- RAW: "WuScript_SavedKey",
  -- RAW: "WuScript_SavedKey.txt",
  -- RAW: "Patriot_Key",
  -- RAW: "Patriot_Key.txt",
  -- RAW: "PatriotKey",
  -- RAW: "PatriotKey.txt",
  -- RAW: "patriot_key",
  -- RAW: "patriot_key.txt",
  -- RAW: "script_key",
  -- RAW: "script_key.txt",
  -- RAW: "SavedKey",
  -- RAW: "SavedKey.txt",
  -- RAW: }
  -- RAW: for _, name in ipairs(names) do
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if delfile then delfile(name) else writefile(name, "") end
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- -- 扫工作区里名字带 key 的文件（尽量清干净）
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, f in ipairs(listfiles("")) do
  {op=1,a=16,bx=23},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if delfile then pcall(delfile, f) end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- -- 下次强制弹出卡密框
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=24},
  {op=1,a=1,bx=25},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: getgenv().WuForceKeyEntry = true
  -- RAW: getgenv().SCRIPT_KEY = nil
  -- RAW: getgenv().PatriotSavedKey = nil
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- -- 允许重复执行时重新加载 Patriot
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: getgenv().PatriotLoaded = nil
  -- RAW: getgenv().SCRIPT_KEY = nil
  {op=1,a=17,bx=26},
  -- RAW: for _, n in ipairs({ "PatriotKeySystem", "PatriotKeylessSystem" }) do
  {op=1,a=18,bx=27},
  -- RAW: if g then g:Destroy() end
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- RAW: local Patriot
  -- RAW: do
  -- RAW: local okP, resP = pcall(function()
  {op=1,a=0,bx=28},
  {op=29,a=0,b=2},
  -- RAW: end)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=19,bx=29},
  {op=6,a=19,bx=30},
  {op=21,sbx=0},
  {op=5,a=0,bx=12},
  {op=1,a=1,bx=31},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- -- 简易卡密
  {op=1,a=20,bx=32},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: if isfile and isfile(KEY_FILE) then saved = readfile(KEY_FILE) or "" end
  -- RAW: end)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=2,a=21,b=0,c=0},
  {op=1,a=22,bx=33},
  -- RAW: sg.ResetOnSpawn = false
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=34},
  {op=27,a=0,b=2,c=1},
  -- RAW: if not sg.Parent then sg.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end
  {op=1,a=23,bx=35},
  -- RAW: f.Size, f.Position, f.AnchorPoint = UDim2.fromOffset(320, 150), UDim2.fromScale(0.5, 0.5), Vector2.new(0.5, 0.5)
  -- RAW: f.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
  -- RAW: Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
  {op=1,a=24,bx=36},
  -- RAW: title.Size, title.Position, title.BackgroundTransparency = UDim2.new(1, -20, 0, 28), UDim2.fromOffset(10, 10), 1
  -- RAW: title.Text, title.TextColor3, title.Font, title.TextSize = "巫 script · 输入卡密", Color3.new(1,1,1), Enum.Font.GothamBold, 16
  {op=1,a=25,bx=37},
  -- RAW: tb.Size, tb.Position = UDim2.new(1, -20, 0, 34), UDim2.fromOffset(10, 48)
  -- RAW: tb.PlaceholderText, tb.Text = "by wu", ""
  -- RAW: tb.BackgroundColor3, tb.TextColor3 = Color3.fromRGB(35, 38, 45), Color3.new(1,1,1)
  -- RAW: Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 6)
  {op=1,a=26,bx=38},
  -- RAW: btn.Size, btn.Position, btn.Text = UDim2.new(1, -20, 0, 34), UDim2.fromOffset(10, 100), "确认进入"
  -- RAW: btn.BackgroundColor3, btn.TextColor3 = Color3.fromRGB(0, 170, 255), Color3.new(1,1,1)
  -- RAW: Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
  -- RAW: local function try()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=39},
  {op=27,a=0,b=2,c=1},
  {op=1,a=21,bx=40},
  {op=6,a=21,bx=41},
  {op=5,a=27,bx=42},
  {op=10,a=27,b=27,c=43},
  {op=27,a=27,b=2,c=1},
  {op=21,sbx=0},
  -- RAW: tb.Text = ""
  -- RAW: tb.PlaceholderText = "卡密错误"
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: btn.MouseButton1Click:Connect(try)
  -- RAW: tb.FocusLost:Connect(function(e) if e then try() end end)
  -- RAW: while not done do task.wait(0.1) end
  {op=29,a=0,b=1},
  {op=1,a=28,bx=40},
  {op=6,a=28,bx=44},
  {op=21,sbx=0},
  -- 
  -- 
  -- RAW: Patriot.Callbacks.OnVerify = function(key)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=24},
  {op=1,a=1,bx=45},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- -- 验证成功：取消强制输入标记
  -- RAW: getgenv().WuForceKeyEntry = nil
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=46},
  {op=0,a=1,b=11},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=24},
  {op=1,a=1,bx=47},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=48},
  {op=29,a=0,b=2},
  {op=1,a=29,bx=49},
  {op=6,a=29,bx=50},
  {op=1,a=30,bx=51},
  {op=6,a=30,bx=52},
  {op=1,a=31,bx=53},
  {op=6,a=31,bx=54},
  -- RAW: }
  {op=29,a=0,b=1},
  -- 
  -- RAW: Patriot.Appearance = {
  {op=1,a=32,bx=55},
  {op=6,a=32,bx=56},
  {op=1,a=33,bx=57},
  {op=6,a=33,bx=58},
  {op=1,a=34,bx=59},
  {op=6,a=34,bx=60},
  {op=1,a=35,bx=61},
  {op=6,a=35,bx=62},
  -- RAW: }
  -- 
  -- RAW: Patriot.Links = {
  {op=1,a=36,bx=63},
  {op=6,a=36,bx=64},
  {op=1,a=37,bx=32},
  {op=6,a=37,bx=65},
  -- RAW: }
  -- 
  -- -- 若点过「清除卡密」，禁止自动进
  {op=2,a=38,b=0,c=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=38,bx=40},
  {op=6,a=38,bx=66},
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: local ok, content = pcall(readfile, FORCE_KEY_FILE)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=38,bx=40},
  {op=6,a=38,bx=66},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: pcall(clearSavedKey) -- 再清一次，防止残留
  {op=29,a=0,b=1},
  -- 
  -- RAW: Patriot.Storage = {
  {op=1,a=39,bx=67},
  {op=6,a=39,bx=68},
  {op=1,a=40,bx=69},
  {op=6,a=40,bx=70},
  {op=1,a=41,bx=71},
  {op=6,a=41,bx=72},
  -- RAW: }
  -- 
  -- RAW: Patriot.Options = {
  {op=1,a=42,bx=49},
  {op=6,a=42,bx=73},
  {op=1,a=43,bx=74},
  {op=6,a=43,bx=75},
  {op=1,a=44,bx=40},
  {op=6,a=44,bx=76},
  -- RAW: }
  -- 
  -- RAW: Patriot.Theme = {
  {op=1,a=45,bx=77},
  {op=6,a=45,bx=78},
  {op=1,a=46,bx=79},
  {op=6,a=46,bx=80},
  {op=1,a=47,bx=81},
  {op=6,a=47,bx=82},
  {op=1,a=48,bx=83},
  {op=6,a=48,bx=84},
  {op=1,a=49,bx=85},
  {op=6,a=49,bx=86},
  {op=1,a=50,bx=87},
  {op=6,a=50,bx=88},
  {op=1,a=51,bx=89},
  {op=6,a=51,bx=90},
  {op=1,a=52,bx=91},
  {op=6,a=52,bx=92},
  {op=1,a=53,bx=93},
  {op=6,a=53,bx=94},
  {op=1,a=54,bx=95},
  {op=6,a=54,bx=96},
  {op=1,a=55,bx=97},
  {op=6,a=55,bx=98},
  {op=1,a=37,bx=77},
  {op=6,a=37,bx=65},
  {op=1,a=56,bx=79},
  {op=6,a=56,bx=99},
  {op=1,a=57,bx=100},
  {op=6,a=57,bx=101},
  {op=1,a=58,bx=102},
  {op=6,a=58,bx=103},
  -- RAW: }
  -- 
  -- RAW: Patriot.Shop = { Enabled = false }
  -- RAW: Patriot.Changelog = {}
  -- 
  {op=2,a=28,b=0,c=0},
  {op=2,a=59,b=0,c=0},
  -- RAW: Patriot.Callbacks.OnSuccess = function()
  {op=1,a=28,bx=40},
  {op=6,a=28,bx=44},
  {op=29,a=0,b=1},
  -- RAW: Patriot.Callbacks.OnFail = function() end
  -- RAW: Patriot.Callbacks.OnClose = function()
  {op=1,a=59,bx=40},
  {op=6,a=59,bx=104},
  {op=29,a=0,b=1},
  -- 
  {op=5,a=60,bx=30},
  {op=10,a=60,b=60,c=105},
  {op=27,a=60,b=2,c=1},
  -- 
  -- -- 等待验证通过；关闭窗口则直接退出
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: task.wait(0.1)
  {op=29,a=0,b=1},
  -- RAW: end -- Patriot / 简易卡密
  -- RAW: _G.AdonisBypass = true
  -- RAW: getgenv().WuAntiCheat = getgenv().WuAntiCheat or {
  {op=1,a=61,bx=74},
  {op=6,a=61,bx=106},
  {op=1,a=62,bx=74},
  {op=6,a=62,bx=107},
  -- RAW: }
  -- 
  -- RAW: local function WuApplyAntiCheat()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: getgenv().WuAntiCheat._Applied = true
  -- 
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=108},
  {op=27,a=0,b=2,c=1},
  -- 
  -- -- 1.5 ANTI-KICK（源码逻辑，立刻执行）
  -- RAW: getgenv().WuAntiCheat.AntiKickEnabled = true
  -- RAW: task.spawn(function()
  -- RAW: local function softAntiKick()
  -- RAW: if not getgenv().WuAntiCheat or not getgenv().WuAntiCheat.Enabled then return end
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=63,bx=109},
  {op=1,a=3,bx=110},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=64,bx=111},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: lp.Kick = function() return nil end
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=5,a=0,bx=112},
  {op=27,a=0,b=1,c=1},
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=113},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: task.wait(30)
  {op=5,a=0,bx=112},
  {op=27,a=0,b=1,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- -- 1.6 BYPASS ADONIS（源码逻辑）
  -- RAW: task.spawn(function()
  -- -- 几乎立刻执行，不等主界面
  -- RAW: task.wait(0.15)
  -- RAW: if not getgenv().WuAntiCheat or not getgenv().WuAntiCheat.Enabled then return end
  -- RAW: if not _G.AdonisBypass then return end
  -- 
  {op=1,a=65,bx=114},
  -- 
  -- RAW: local function BypassAdonis()
  -- RAW: if not _G.AdonisBypass then return end
  -- 
  {op=2,a=66,b=0,c=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: for _, obj in pairs(game:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=66,bx=40},
  {op=6,a=66,bx=115},
  -- RAW: break
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  {op=9,a=67,b=0,c=0},
  -- RAW: "Adonis_Remote",
  -- RAW: "Adonis_AntiCheat",
  -- RAW: "Adonis_Check",
  -- RAW: "Adonis_Validate",
  -- RAW: "Adonis_Log",
  -- RAW: "Adonis_Event"
  -- RAW: }
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, remoteName in pairs(remotes) do
  {op=1,a=68,bx=116},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=66,bx=40},
  {op=6,a=66,bx=115},
  -- RAW: break
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=117},
  {op=27,a=0,b=2,c=1},
  -- 
  -- RAW: for _, remoteName in pairs(remotes) do
  {op=1,a=68,bx=116},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: remote.OnServerEvent:Connect(function()
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=69,bx=118},
  {op=1,a=70,bx=119},
  {op=5,a=0,bx=120},
  {op=1,a=1,bx=121},
  {op=27,a=0,b=2,c=1},
  -- RAW: mt.__namecall = newcclosure(function(self, ...)
  {op=1,a=71,bx=122},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=123},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=72,bx=124},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=123},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=125},
  {op=29,a=0,b=2},
  -- RAW: end)
  {op=5,a=0,bx=120},
  {op=1,a=1,bx=126},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  -- 
  -- RAW: task.spawn(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Adonis.Detected = false
  {op=29,a=0,b=1},
  {op=1,a=73,bx=127},
  {op=1,a=74,bx=128},
  -- RAW: for _, log in pairs(logs) do
  -- RAW: if log.message and (
  -- RAW: string.find(log.message, "Universal Pro")
  -- RAW: or string.find(log.message, "Silent Aim")
  -- RAW: or string.find(log.message, "巫 script")
  -- RAW: ) then
  -- -- 源码尝试清空相关日志痕迹（能力有限）
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=129},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=130},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=131},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: if getgenv().WuAntiCheat._MTHooked then return end
  {op=1,a=69,bx=118},
  {op=1,a=70,bx=119},
  {op=5,a=0,bx=120},
  {op=1,a=1,bx=121},
  {op=27,a=0,b=2,c=1},
  -- RAW: mt.__namecall = newcclosure(function(self, ...)
  {op=1,a=71,bx=122},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=123},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=125},
  {op=29,a=0,b=2},
  -- RAW: end)
  {op=5,a=0,bx=120},
  {op=1,a=1,bx=126},
  {op=27,a=0,b=2,c=1},
  -- RAW: getgenv().WuAntiCheat._MTHooked = true
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=132},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: getgenv().WuApplyAntiCheat = WuApplyAntiCheat
  -- 
  -- -- 卡密通过后：第一优先执行反作弊（早于加载动画 / UI）
  {op=5,a=0,bx=133},
  {op=27,a=0,b=1,c=1},
  -- 
  -- -- 卡密通过后：霓虹绿三角脉冲网格（CSS tip grid 伪效果）
  -- RAW: do
  {op=1,a=75,bx=134},
  {op=1,a=76,bx=5},
  {op=1,a=77,bx=135},
  -- 
  {op=1,a=78,bx=136},
  {op=1,a=79,bx=137},
  -- 
  {op=1,a=80,bx=33},
  -- RAW: screenGui.Name = "WuLoadingScreen"
  -- RAW: screenGui.IgnoreGuiInset = true
  -- RAW: screenGui.ResetOnSpawn = false
  -- RAW: screenGui.DisplayOrder = 999
  -- RAW: screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=138},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: screenGui.Parent = playerGui
  {op=29,a=0,b=1},
  -- 
  {op=1,a=81,bx=139},
  -- RAW: black.Size = UDim2.new(1, 0, 1, 0)
  -- RAW: black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  -- RAW: black.BackgroundTransparency = 1
  -- RAW: black.BorderSizePixel = 0
  -- RAW: black.Parent = screenGui
  -- 
  -- RAW: TweenService:Create(black, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
  {op=1,a=82,bx=140},
  {op=6,a=82,bx=141},
  -- RAW: }):Play()
  -- RAW: task.wait(0.5)
  -- 
  -- -- 左侧：真实源码流（黑客打码感）
  {op=9,a=83,b=0,c=0},
  -- RAW: "-- 巫 script loader",
  -- RAW: "local KEY_FILE = \"WuScript_SavedKey.txt\"",
  -- RAW: "local CURRENT_KEY = \"by wu\"",
  -- RAW: "local function isValidPass(pass)",
  -- RAW: "    local n = tostring(pass):gsub(\"%s+\", \"\"):lower()",
  -- RAW: "    return n == \"bywu\"",
  -- RAW: "end",
  -- RAW: "local Library = loadstring([=========[]=========])()",
  -- RAW: "getgenv().Library = Library",
  -- RAW: "function Spectrum:AddWindow(opts)",
  -- RAW: "    local win = Library:Window({",
  -- RAW: "        Name = \"巫 script\",",
  -- RAW: "        SubName = \"by wu\",",
  -- RAW: "        Logo = \"98373426403561\"",
  -- RAW: "    })",
  -- RAW: "    getgenv().WuRealWindow = win",
  -- RAW: "    return WindowProxy",
  -- RAW: "end",
  -- RAW: "local Window = Spectrum:AddWindow({})",
  -- RAW: "local MainTab = Window:AddTab(\"通用功能\")",
  -- RAW: "MainTab:AddSection(\"移动\"):AddSlider({",
  -- RAW: "    Name = \"行走速度\", Min = 16, Max = 200",
  -- RAW: "})",
  -- RAW: "local Tab2 = Window:AddTab(\"范围设置\")",
  -- RAW: "local HitboxEnabled = false",
  -- RAW: "RunService.RenderStepped:Connect(function()",
  -- RAW: "    if not HitboxEnabled then return end",
  -- RAW: "    for _, v in pairs(Players:GetPlayers()) do",
  -- RAW: "        local root = v.Character and v.Character:FindFirstChild(\"HumanoidRootPart\")",
  -- RAW: "        if root then root.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize) end",
  -- RAW: "    end",
  -- RAW: "end)",
  -- RAW: "local AimTab = Window:AddTab(\"自瞄\")",
  -- RAW: "AimSection:AddButton({ Name = \"通用静默自瞄\" })",
  -- RAW: "loadstring(game:HttpGet(url))()",
  -- RAW: "Environment:ESPConnect()",
  -- RAW: "print(\"[巫 script] modules ready\")",
  -- RAW: "Window:SetOpen(true)",
  -- RAW: "getgenv().WuUILocked = false",
  -- RAW: "-- loading complete",
  -- RAW: }
  -- 
  {op=1,a=84,bx=139},
  -- RAW: codePanel.Name = "CodeStream"
  -- RAW: codePanel.Size = UDim2.new(1, 0, 1, 0) -- 全屏底层
  -- RAW: codePanel.Position = UDim2.new(0, 0, 0, 0)
  -- RAW: codePanel.BackgroundTransparency = 1
  -- RAW: codePanel.ClipsDescendants = true
  -- RAW: codePanel.ZIndex = 1
  -- RAW: codePanel.Parent = black
  -- 
  {op=1,a=85,bx=142},
  -- RAW: codeLabel.Size = UDim2.new(1, -24, 1, -24)
  -- RAW: codeLabel.Position = UDim2.new(0, 12, 0, 12)
  -- RAW: codeLabel.BackgroundTransparency = 1
  -- RAW: codeLabel.Text = ""
  -- RAW: codeLabel.TextColor3 = Color3.fromRGB(50, 200, 90)
  -- RAW: codeLabel.TextTransparency = 0.2
  -- RAW: codeLabel.Font = Enum.Font.Code
  -- RAW: codeLabel.TextSize = 14
  -- RAW: codeLabel.TextXAlignment = Enum.TextXAlignment.Left
  -- RAW: codeLabel.TextYAlignment = Enum.TextYAlignment.Top
  -- RAW: codeLabel.TextWrapped = false
  -- RAW: codeLabel.RichText = false
  -- RAW: codeLabel.ZIndex = 1
  -- RAW: codeLabel.Parent = codePanel
  -- 
  {op=1,a=86,bx=143},
  {op=9,a=87,b=0,c=0},
  {op=2,a=88,b=1,c=0},
  -- 
  -- RAW: local function playKeySound()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=89,bx=144},
  -- -- 键盘敲击
  -- RAW: s.SoundId = "rbxassetid://6895079853"
  -- RAW: s.Volume = 1.2
  -- RAW: s.PlaybackSpeed = 0.95 + math.random() * 0.35
  -- RAW: s.Parent = screenGui
  {op=5,a=90,bx=145},
  {op=10,a=90,b=90,c=146},
  {op=27,a=90,b=2,c=1},
  -- RAW: task.delay(0.8, function()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=147},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: task.spawn(function()
  {op=1,a=91,bx=148},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=92,bx=149},
  -- RAW: table.insert(shown, line)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: table.remove(shown, 1)
  {op=29,a=0,b=1},
  -- RAW: codeLabel.Text = table.concat(shown, "\n")
  -- RAW: if i % 4 == 0 then playKeySound() end
  {op=1,a=91,bx=150},
  {op=6,a=91,bx=151},
  -- RAW: task.wait(0.012) -- 极速，几乎无法辨认
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- -- 网格舞台
  {op=1,a=93,bx=139},
  -- RAW: stage.AnchorPoint = Vector2.new(0.5, 0.5)
  -- RAW: stage.Position = UDim2.new(0.5, 0, 0.42, 0)
  -- RAW: stage.Size = UDim2.fromOffset(280, 200)
  -- RAW: stage.BackgroundTransparency = 1
  -- RAW: stage.ZIndex = 5
  -- RAW: stage.Parent = black
  -- 
  {op=1,a=94,bx=139},
  -- RAW: grid.AnchorPoint = Vector2.new(0.5, 0.5)
  -- RAW: grid.Position = UDim2.new(0.5, 0, 0.5, 0)
  -- RAW: grid.Size = UDim2.fromOffset(260, 180)
  -- RAW: grid.BackgroundTransparency = 1
  -- RAW: grid.Parent = stage
  -- 
  {op=1,a=95,bx=152},
  -- RAW: list.FillDirection = Enum.FillDirection.Vertical
  -- RAW: list.HorizontalAlignment = Enum.HorizontalAlignment.Center
  -- RAW: list.VerticalAlignment = Enum.VerticalAlignment.Center
  -- RAW: list.Padding = UDim.new(0, -4)
  -- RAW: list.Parent = grid
  -- 
  {op=9,a=96,b=0,c=0},
  {op=9,a=97,b=0,c=0},
  -- RAW: { n = 3, reverse = false },
  -- RAW: { n = 5, reverse = true },
  -- RAW: { n = 7, reverse = false },
  -- RAW: { n = 9, reverse = true },
  -- RAW: { n = 7, reverse = false },
  -- RAW: { n = 5, reverse = true },
  -- RAW: { n = 3, reverse = false },
  -- RAW: }
  -- 
  {op=1,a=98,bx=140},
  -- RAW: for rowIdx, row in ipairs(rows) do
  {op=1,a=99,bx=139},
  -- RAW: strip.Size = UDim2.new(1, 0, 0, 26)
  -- RAW: strip.BackgroundTransparency = 1
  -- RAW: strip.ZIndex = 5
  -- RAW: strip.Parent = grid
  -- 
  {op=1,a=100,bx=152},
  -- RAW: hlist.FillDirection = Enum.FillDirection.Horizontal
  -- RAW: hlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
  -- RAW: hlist.VerticalAlignment = Enum.VerticalAlignment.Center
  -- RAW: hlist.Padding = UDim.new(0, -6)
  -- RAW: hlist.Parent = strip
  -- 
  -- RAW: for i = 1, row.n do
  {op=1,a=98,bx=153},
  {op=6,a=98,bx=154},
  {op=1,a=101,bx=142},
  -- RAW: tip.Size = UDim2.fromOffset(28, 26)
  -- RAW: tip.BackgroundTransparency = 1
  -- RAW: tip.Text = row.reverse and "▼" or "▲"
  -- RAW: tip.Font = Enum.Font.GothamBlack
  -- RAW: tip.TextSize = 22
  -- RAW: tip.TextColor3 = NEON
  -- RAW: tip.TextTransparency = 0.85
  -- RAW: tip.ZIndex = 5
  -- RAW: tip.Parent = strip
  -- 
  {op=1,a=102,bx=155},
  -- RAW: stroke.Color = GLOW
  -- RAW: stroke.Thickness = 1.2
  -- RAW: stroke.Transparency = 0.55
  -- RAW: stroke.Parent = tip
  -- 
  -- RAW: table.insert(tips, {
  {op=1,a=103,bx=156},
  {op=6,a=103,bx=157},
  {op=1,a=102,bx=158},
  {op=6,a=102,bx=159},
  {op=1,a=104,bx=160},
  {op=6,a=104,bx=161},
  -- RAW: })
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- -- 标题
  {op=1,a=24,bx=142},
  -- RAW: title.AnchorPoint = Vector2.new(0.5, 0)
  -- RAW: title.Position = UDim2.new(0.5, 0, 0.68, 0)
  -- RAW: title.Size = UDim2.new(1, -40, 0, 28)
  -- RAW: title.BackgroundTransparency = 1
  -- RAW: title.Text = "巫 script"
  -- RAW: title.Font = Enum.Font.GothamMedium
  -- RAW: title.TextSize = 30
  -- RAW: title.TextColor3 = Color3.fromRGB(220, 255, 200)
  -- RAW: title.ZIndex = 6
  -- RAW: title.Parent = black
  -- 
  {op=1,a=105,bx=142},
  -- RAW: sub.AnchorPoint = Vector2.new(0.5, 0)
  -- RAW: sub.Position = UDim2.new(0.5, 0, 0.68, 30)
  -- RAW: sub.Size = UDim2.new(1, -40, 0, 18)
  -- RAW: sub.BackgroundTransparency = 1
  -- RAW: sub.Text = "启动反作弊中"
  -- RAW: sub.Font = Enum.Font.GothamBold
  -- RAW: sub.TextSize = 15
  -- RAW: sub.TextColor3 = NEON
  -- RAW: sub.ZIndex = 6
  -- RAW: sub.Parent = black
  -- 
  -- -- 最初版本：错峰不断亮起
  {op=2,a=106,b=1,c=0},
  -- RAW: for _, item in ipairs(tips) do
  -- RAW: task.spawn(function()
  -- RAW: task.wait(item.delay)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: TweenService:Create(item.label, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
  {op=1,a=107,bx=140},
  {op=6,a=107,bx=162},
  -- RAW: }):Play()
  {op=5,a=108,bx=163},
  {op=10,a=108,b=108,c=164},
  {op=27,a=108,b=3,c=1},
  -- RAW: task.wait(0.3)
  -- RAW: TweenService:Create(item.label, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
  {op=1,a=107,bx=165},
  {op=6,a=107,bx=162},
  -- RAW: }):Play()
  {op=5,a=109,bx=163},
  {op=10,a=109,b=109,c=164},
  {op=27,a=109,b=3,c=1},
  -- RAW: task.wait(0.7)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: task.spawn(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=110,bx=163},
  {op=10,a=110,b=110,c=164},
  {op=27,a=110,b=3,c=1},
  -- RAW: task.wait(0.8)
  {op=5,a=111,bx=163},
  {op=10,a=111,b=111,c=164},
  {op=27,a=111,b=3,c=1},
  -- RAW: task.wait(0.8)
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- -- 右上角：若隐若现的「跳过」（无描边、白字、细体）
  {op=1,a=112,bx=166},
  -- RAW: skipBtn.Name = "WuSkipLoading"
  -- RAW: skipBtn.AnchorPoint = Vector2.new(1, 0)
  -- RAW: skipBtn.Position = UDim2.new(1, -16, 0, 14)
  -- RAW: skipBtn.Size = UDim2.fromOffset(52, 22)
  -- RAW: skipBtn.BackgroundTransparency = 1
  -- RAW: skipBtn.BorderSizePixel = 0
  -- RAW: skipBtn.AutoButtonColor = false
  -- RAW: skipBtn.Text = "跳过"
  -- RAW: skipBtn.Font = Enum.Font.Gotham
  -- RAW: skipBtn.TextSize = 13
  -- RAW: skipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
  -- RAW: skipBtn.TextTransparency = 0.55
  -- RAW: skipBtn.ZIndex = 100
  -- RAW: skipBtn.Parent = black
  -- 
  {op=2,a=113,b=0,c=0},
  -- RAW: task.spawn(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=114,bx=163},
  {op=10,a=114,b=114,c=164},
  {op=27,a=114,b=3,c=1},
  -- RAW: task.wait(1.1)
  -- RAW: if skipLoading then break end
  {op=5,a=115,bx=163},
  {op=10,a=115,b=115,c=164},
  {op=27,a=115,b=3,c=1},
  -- RAW: task.wait(1.1)
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: skipBtn.MouseButton1Click:Connect(function()
  {op=1,a=113,bx=40},
  {op=6,a=113,bx=167},
  {op=1,a=106,bx=10},
  {op=6,a=106,bx=168},
  {op=1,a=88,bx=10},
  {op=6,a=88,bx=169},
  -- RAW: skipBtn.TextTransparency = 0.2
  -- RAW: end)
  -- 
  -- -- 可被跳过的等待（约 6 秒）
  -- RAW: do
  {op=1,a=116,bx=170},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: task.wait(0.05)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=106,bx=10},
  {op=6,a=106,bx=168},
  {op=1,a=88,bx=10},
  {op=6,a=88,bx=169},
  -- 
  -- -- ========== 结束动画：仅一次 ==========
  -- -- 1) 先淡掉三角 / 代码 / 标题（保留黑底）
  {op=1,a=117,bx=171},
  -- RAW: for _, v in ipairs(black:GetDescendants()) do
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=118,bx=163},
  {op=10,a=118,b=118,c=164},
  {op=27,a=118,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=119,bx=163},
  {op=10,a=119,b=119,c=164},
  {op=27,a=119,b=3,c=1},
  {op=21,sbx=0},
  -- -- 代码面板等半透明层一起隐去
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=120,bx=163},
  {op=10,a=120,b=120,c=164},
  {op=27,a=120,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: task.wait(0.5)
  -- 
  -- -- 2) 小正方形拼图铺满屏幕（只播一次）
  {op=1,a=121,bx=139},
  -- RAW: mosaic.Name = "GreenMosaic"
  -- RAW: mosaic.Size = UDim2.new(1, 0, 1, 0)
  -- RAW: mosaic.BackgroundTransparency = 1
  -- RAW: mosaic.BorderSizePixel = 0
  -- RAW: mosaic.ZIndex = 60
  -- RAW: mosaic.Parent = black
  -- 
  -- -- 按屏幕比例自动算行列，保证铺满（含手机竖屏）
  {op=1,a=122,bx=172},
  {op=1,a=123,bx=173},
  {op=1,a=124,bx=174},
  {op=1,a=125,bx=175},
  {op=1,a=126,bx=176},
  {op=9,a=127,b=0,c=0},
  {op=1,a=128,bx=177},
  {op=1,a=129,bx=178},
  -- 
  -- RAW: for r = 0, ROWS - 1 do
  -- RAW: for c = 0, COLS - 1 do
  {op=1,a=130,bx=139},
  -- RAW: cell.BorderSizePixel = 0
  -- RAW: cell.BackgroundColor3 = NEON_A:Lerp(NEON_B, math.random())
  -- RAW: cell.BackgroundTransparency = 1
  -- -- 中心点落在格子正中，尺寸用 scale 无缝铺满
  -- RAW: cell.AnchorPoint = Vector2.new(0.5, 0.5)
  -- RAW: cell.Position = UDim2.new((c + 0.5) / COLS, 0, (r + 0.5) / ROWS, 0)
  -- RAW: cell.Size = UDim2.new((1 / COLS) * 0.2, 0, (1 / ROWS) * 0.2, 0)
  -- RAW: cell.ZIndex = 61
  -- RAW: cell.Parent = mosaic
  {op=1,a=131,bx=179},
  -- RAW: corner.CornerRadius = UDim.new(0, 1)
  -- RAW: corner.Parent = cell
  -- RAW: local cx, cy = (COLS - 1) / 2, (ROWS - 1) / 2
  {op=1,a=132,bx=180},
  -- RAW: table.insert(cells, {
  {op=1,a=133,bx=181},
  {op=6,a=133,bx=182},
  {op=1,a=104,bx=183},
  {op=6,a=104,bx=161},
  {op=1,a=132,bx=184},
  {op=6,a=132,bx=185},
  {op=1,a=134,bx=186},
  {op=6,a=134,bx=187},
  -- RAW: })
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: table.sort(cells, function(a, b) return a.delay < b.delay end)
  -- 
  -- RAW: local function playDoneDing()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=89,bx=144},
  -- RAW: s.SoundId = "rbxassetid://9114227569"
  -- RAW: s.Volume = 1.4
  -- RAW: s.PlaybackSpeed = 0.8
  -- RAW: s.Parent = screenGui
  {op=5,a=135,bx=145},
  {op=10,a=135,b=135,c=146},
  {op=27,a=135,b=2,c=1},
  -- RAW: task.delay(2.5, function()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=147},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  -- RAW: end)
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=136,bx=144},
  -- RAW: s2.SoundId = "rbxassetid://6042053626"
  -- RAW: s2.Volume = 0.85
  -- RAW: s2.PlaybackSpeed = 0.65
  -- RAW: s2.Parent = screenGui
  {op=5,a=137,bx=188},
  {op=10,a=137,b=137,c=146},
  {op=27,a=137,b=2,c=1},
  -- RAW: task.delay(2.5, function()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=189},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- -- 拼入
  {op=1,a=138,bx=140},
  -- RAW: for _, info in ipairs(cells) do
  {op=1,a=138,bx=190},
  {op=6,a=138,bx=191},
  -- RAW: task.delay(info.delay, function()
  {op=1,a=23,bx=192},
  -- RAW: if not f or not f.Parent then return end
  -- RAW: TweenService:Create(f, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
  {op=1,a=82,bx=193},
  {op=6,a=82,bx=141},
  {op=1,a=139,bx=194},
  {op=6,a=139,bx=195},
  -- RAW: }):Play()
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: task.wait(maxDelay + 0.25)
  {op=5,a=0,bx=196},
  {op=27,a=0,b=1,c=1},
  -- 
  -- -- 中央完成字（短暂）
  {op=1,a=140,bx=142},
  -- RAW: doneLabel.AnchorPoint = Vector2.new(0.5, 0.5)
  -- RAW: doneLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
  -- RAW: doneLabel.Size = UDim2.new(1, 0, 0, 40)
  -- RAW: doneLabel.BackgroundTransparency = 1
  -- RAW: doneLabel.Text = "加载完成"
  -- RAW: doneLabel.Font = Enum.Font.GothamBold
  -- RAW: doneLabel.TextSize = 28
  -- RAW: doneLabel.TextColor3 = Color3.fromRGB(10, 30, 10)
  -- RAW: doneLabel.TextTransparency = 1
  -- RAW: doneLabel.ZIndex = 70
  -- RAW: doneLabel.Parent = mosaic
  {op=5,a=141,bx=163},
  {op=10,a=141,b=141,c=164},
  {op=27,a=141,b=3,c=1},
  -- RAW: task.wait(0.55)
  {op=5,a=142,bx=163},
  {op=10,a=142,b=142,c=164},
  {op=27,a=142,b=3,c=1},
  -- RAW: task.wait(0.2)
  -- 
  -- -- 3) 方块由外向内（或随机）碎裂淡出，露出主界面
  -- RAW: table.sort(cells, function(a, b) return a.dist > b.dist end)
  -- RAW: for _, info in ipairs(cells) do
  -- RAW: task.delay((maxDelay - info.delay) * 0.35, function()
  {op=1,a=23,bx=192},
  -- RAW: if not f or not f.Parent then return end
  -- RAW: TweenService:Create(f, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
  {op=1,a=82,bx=148},
  {op=6,a=82,bx=141},
  {op=1,a=139,bx=197},
  {op=6,a=139,bx=195},
  -- RAW: }):Play()
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: task.wait(maxDelay * 0.35 + 0.4)
  -- 
  {op=1,a=143,bx=198},
  {op=1,a=82,bx=148},
  {op=6,a=82,bx=141},
  -- RAW: })
  {op=5,a=144,bx=199},
  {op=10,a=144,b=144,c=146},
  {op=27,a=144,b=2,c=1},
  -- RAW: fb.Completed:Wait()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=200},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  -- 
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=201},
  {op=27,a=0,b=2,c=1},
  -- RAW: local okLib, Library = pcall(function()
  {op=1,a=0,bx=202},
  {op=29,a=0,b=2},
  -- RAW: end)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=12},
  {op=1,a=1,bx=203},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: game:GetService("StarterGui"):SetCore("SendNotification", {
  {op=1,a=32,bx=204},
  {op=6,a=32,bx=56},
  -- RAW: })
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=145,bx=205},
  {op=1,a=32,bx=55},
  {op=6,a=32,bx=56},
  {op=1,a=146,bx=206},
  {op=6,a=146,bx=207},
  {op=1,a=147,bx=208},
  {op=6,a=147,bx=209},
  {op=1,a=148,bx=148},
  {op=6,a=148,bx=210},
  {op=1,a=149,bx=49},
  {op=6,a=149,bx=211},
  -- RAW: })
  -- 
  -- -- 保险：绝不改非巫 UI 的 UIScale；若发现误伤则还原为 1
  -- RAW: task.defer(function()
  -- RAW: task.wait(0.2)
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: local function isWu(inst)
  {op=1,a=150,bx=212},
  {op=1,a=151,bx=148},
  {op=1,a=152,bx=213},
  {op=1,a=153,bx=148},
  {op=31,a=151,sbx=0},
  -- RAW: if not r then return false end
  -- RAW: if r:GetAttribute("WuScriptUI") then return true end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, d in ipairs(r:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=150,bx=214},
  {op=6,a=150,bx=215},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=152,bx=26},
  -- RAW: for _, us in ipairs(host:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=153,bx=216},
  {op=10,a=153,b=153,c=43},
  {op=27,a=153,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: end)
  -- 
  -- RAW: local function notify(title, desc, dur)
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: Library:Notification({
  {op=1,a=32,bx=217},
  {op=6,a=32,bx=56},
  {op=1,a=154,bx=218},
  {op=6,a=154,bx=219},
  {op=1,a=155,bx=220},
  {op=6,a=155,bx=221},
  -- RAW: })
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: do
  -- RAW: local function bindSection(page)
  {op=9,a=156,b=0,c=0},
  -- RAW: function sec:AddButton(t)
  {op=1,a=157,bx=222},
  {op=6,a=157,bx=223},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: page:Button({
  {op=1,a=32,bx=224},
  {op=6,a=32,bx=56},
  {op=1,a=50,bx=225},
  {op=6,a=50,bx=88},
  {op=1,a=158,bx=226},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- RAW: end)
  {op=0,a=0,b=156},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- RAW: function sec:AddToggle(t)
  {op=1,a=157,bx=222},
  {op=6,a=157,bx=223},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: page:Toggle({
  {op=1,a=32,bx=228},
  {op=6,a=32,bx=56},
  {op=1,a=159,bx=229},
  {op=6,a=159,bx=230},
  {op=1,a=158,bx=226},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- RAW: end)
  {op=0,a=0,b=156},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- RAW: function sec:AddSlider(t)
  {op=1,a=157,bx=222},
  {op=6,a=157,bx=223},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: page:Slider({
  {op=1,a=32,bx=231},
  {op=6,a=32,bx=56},
  {op=1,a=160,bx=232},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=234},
  {op=6,a=161,bx=235},
  {op=1,a=159,bx=236},
  {op=6,a=159,bx=230},
  {op=1,a=162,bx=140},
  {op=6,a=162,bx=237},
  {op=1,a=163,bx=238},
  {op=6,a=163,bx=239},
  {op=1,a=158,bx=226},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- RAW: end)
  {op=0,a=0,b=156},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- RAW: function sec:AddTextbox(t)
  {op=1,a=157,bx=222},
  {op=6,a=157,bx=223},
  {op=9,a=164,b=0,c=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=164,bx=240},
  {op=6,a=164,bx=241},
  {op=1,a=32,bx=242},
  {op=6,a=32,bx=56},
  {op=1,a=165,bx=243},
  {op=6,a=165,bx=244},
  {op=1,a=159,bx=245},
  {op=6,a=159,bx=230},
  {op=1,a=166,bx=74},
  {op=6,a=166,bx=246},
  {op=1,a=158,bx=226},
  {op=6,a=158,bx=227},
  -- RAW: }) or {}
  -- RAW: end)
  -- RAW: if type(box) ~= "table" then box = {} end
  -- RAW: if type(box.Set) ~= "function" then function box:Set() end end
  {op=0,a=0,b=164},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- RAW: function sec:AddDropdown(t)
  {op=1,a=157,bx=222},
  {op=6,a=157,bx=223},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: page:Dropdown({
  {op=1,a=32,bx=247},
  {op=6,a=32,bx=56},
  {op=1,a=167,bx=248},
  {op=6,a=167,bx=249},
  {op=1,a=159,bx=250},
  {op=6,a=159,bx=230},
  {op=1,a=158,bx=226},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- RAW: end)
  {op=0,a=0,b=156},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- RAW: function sec:AddKeybind(t)
  {op=1,a=157,bx=222},
  {op=6,a=157,bx=223},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: page:Keybind({
  {op=1,a=32,bx=251},
  {op=6,a=32,bx=56},
  {op=1,a=159,bx=252},
  {op=6,a=159,bx=230},
  {op=1,a=158,bx=226},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- RAW: end)
  {op=0,a=0,b=156},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- RAW: function sec:AddLabel(t)
  {op=1,a=168,bx=253},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=254},
  {op=27,a=0,b=2,c=1},
  {op=0,a=0,b=156},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=0,a=0,b=156},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=169,bx=255},
  -- RAW: function Window:AddTab(name)
  -- RAW: local ok, page = pcall(function()
  {op=1,a=0,bx=256},
  {op=29,a=0,b=2},
  -- RAW: end)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=12},
  {op=1,a=1,bx=257},
  {op=27,a=0,b=2,c=1},
  {op=1,a=170,bx=258},
  {op=6,a=170,bx=259},
  {op=29,a=0,b=1},
  {op=9,a=171,b=0,c=0},
  -- RAW: function proxy:AddSection(title)
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=260},
  {op=27,a=0,b=2,c=1},
  {op=1,a=0,bx=261},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- RAW: for _, method in ipairs({"AddButton","AddToggle","AddSlider","AddTextbox","AddDropdown","AddKeybind","AddLabel"}) do
  -- RAW: proxy[method] = function(_, opts)
  {op=1,a=89,bx=261},
  {op=1,a=0,bx=262},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=0,a=0,b=171},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: function Window:Notify(opts)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=263},
  {op=1,a=1,bx=264},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: getgenv().WuRealWindow = Window
  -- -- 标记巫 UI，缩放时只动自己
  -- RAW: task.defer(function()
  -- RAW: task.wait(0.3)
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=152,bx=26},
  -- RAW: for _, g in ipairs(host:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=0,a=150,b=18},
  -- RAW: while r and not r:IsA("ScreenGui") do r = r.Parent end
  -- RAW: if r then r:SetAttribute("WuScriptUI", true) end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: end)
  -- 
  -- -- 放大窗口边缘拉伸热区（仅巫 script 窗口，绝不改 Delta 等其它 UI）
  -- RAW: task.defer(function()
  -- RAW: task.wait(0.5)
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: local function isWuRoot(inst)
  {op=1,a=150,bx=212},
  {op=1,a=151,bx=148},
  {op=1,a=152,bx=265},
  {op=1,a=153,bx=148},
  {op=31,a=151,sbx=0},
  -- RAW: if not r then return false end
  -- RAW: if r:GetAttribute("WuScriptUI") == true then return true end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, d in ipairs(r:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=172,bx=266},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=150,bx=214},
  {op=6,a=150,bx=215},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=152,bx=26},
  -- RAW: for _, btn in ipairs(host:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=173,bx=267},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=174,bx=268},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: btn.Size = UDim2.new(0, w, 1, 0)
  -- RAW: btn.Position = UDim2.new(1, -w, 0, 0)
  {op=21,sbx=0},
  -- RAW: btn.Size = UDim2.new(0, w, 1, 0)
  {op=29,a=0,b=1},
  -- RAW: btn.Active = true
  {op=21,sbx=0},
  {op=1,a=175,bx=268},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: btn.Size = UDim2.new(1, 0, 0, h)
  -- RAW: btn.Position = UDim2.new(0, 0, 1, -h)
  {op=21,sbx=0},
  -- RAW: btn.Size = UDim2.new(1, 0, 0, h)
  {op=29,a=0,b=1},
  -- RAW: btn.Active = true
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: end)
  -- 
  -- RAW: local okFeat, errFeat = pcall(function()
  {op=1,a=176,bx=269},
  {op=1,a=177,bx=270},
  -- 
  -- RAW: SpeedSection:AddSlider({
  {op=1,a=178,bx=271},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=273},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=274},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=273},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SpeedSection:AddSlider({
  {op=1,a=178,bx=279},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=280},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=281},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=280},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SpeedSection:AddSlider({
  {op=1,a=178,bx=282},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=140},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=283},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=284},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  -- RAW: workspace.Gravity = value
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SpeedSection:AddSlider({
  {op=1,a=178,bx=285},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=286},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=287},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=288},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  -- RAW: workspace.CurrentCamera.FieldOfView = value
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- ===== 物理加速（Velocity）- 修复版（只改水平，保留垂直） =====
  {op=1,a=182,bx=273},
  {op=2,a=183,b=0,c=0},
  {op=3,a=184,b=0},
  -- 
  -- RAW: SpeedSection:AddSlider({
  {op=1,a=178,bx=289},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=273},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=290},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=273},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=1,a=182,bx=291},
  {op=6,a=182,bx=292},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SpeedSection:AddToggle({
  {op=1,a=178,bx=293},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=1,a=183,bx=295},
  {op=6,a=183,bx=296},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=184,bx=297},
  {op=6,a=184,bx=298},
  -- RAW: if not VelocityEnabled then return end
  {op=1,a=76,bx=299},
  {op=1,a=185,bx=300},
  -- RAW: if not char then return end
  {op=1,a=186,bx=301},
  {op=1,a=187,bx=302},
  -- RAW: if not root or not hum or hum.Health <= 0 then return end
  {op=1,a=188,bx=303},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: root.Velocity = Vector3.new(moveDir.X * VelocitySpeed, root.Velocity.Y, moveDir.Z * VelocitySpeed)
  {op=21,sbx=0},
  -- RAW: root.Velocity = Vector3.new(root.Velocity.X * 0.1, root.Velocity.Y, root.Velocity.Z * 0.1)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=5,a=189,bx=304},
  {op=10,a=189,b=189,c=305},
  {op=27,a=189,b=3,c=1},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=190,bx=298},
  {op=10,a=190,b=190,c=306},
  {op=27,a=190,b=2,c=1},
  {op=1,a=184,bx=123},
  {op=6,a=184,bx=298},
  {op=29,a=0,b=1},
  {op=5,a=191,bx=304},
  {op=10,a=191,b=191,c=305},
  {op=27,a=191,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- ===== 高跳（Velocity 驱动） =====
  {op=1,a=192,bx=307},
  {op=2,a=193,b=0,c=0},
  {op=3,a=194,b=0},
  {op=3,a=195,b=0},
  -- 
  -- RAW: SpeedSection:AddSlider({
  {op=1,a=178,bx=308},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=280},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=283},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=307},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=1,a=192,bx=291},
  {op=6,a=192,bx=309},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SpeedSection:AddToggle({
  {op=1,a=178,bx=310},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=1,a=193,bx=295},
  {op=6,a=193,bx=311},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=76,bx=299},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=196,bx=312},
  {op=10,a=196,b=196,c=306},
  {op=27,a=196,b=2,c=1},
  {op=1,a=194,bx=123},
  {op=6,a=194,bx=312},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function bindJump(char)
  {op=1,a=187,bx=302},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=194,bx=313},
  {op=6,a=194,bx=312},
  -- RAW: if not HighJumpEnabled then return end
  {op=1,a=186,bx=301},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: root.Velocity = Vector3.new(root.Velocity.X, HighJumpPower, root.Velocity.Z)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=314},
  {op=1,a=1,bx=300},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=197,bx=315},
  {op=10,a=197,b=197,c=306},
  {op=27,a=197,b=2,c=1},
  {op=1,a=195,bx=123},
  {op=6,a=195,bx=315},
  {op=29,a=0,b=1},
  {op=1,a=195,bx=316},
  {op=6,a=195,bx=315},
  -- RAW: task.wait(0.1)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=198,bx=312},
  {op=10,a=198,b=198,c=306},
  {op=27,a=198,b=2,c=1},
  {op=1,a=194,bx=123},
  {op=6,a=194,bx=312},
  {op=29,a=0,b=1},
  {op=5,a=0,bx=314},
  {op=0,a=1,b=185},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  -- 
  {op=5,a=199,bx=304},
  {op=10,a=199,b=199,c=305},
  {op=27,a=199,b=3,c=1},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=200,bx=312},
  {op=10,a=200,b=200,c=306},
  {op=27,a=200,b=2,c=1},
  {op=1,a=194,bx=123},
  {op=6,a=194,bx=312},
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=201,bx=315},
  {op=10,a=201,b=201,c=306},
  {op=27,a=201,b=2,c=1},
  {op=1,a=195,bx=123},
  {op=6,a=195,bx=315},
  {op=29,a=0,b=1},
  {op=5,a=202,bx=304},
  {op=10,a=202,b=202,c=305},
  {op=27,a=202,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SpeedSection:AddSlider({
  {op=1,a=178,bx=317},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=140},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=318},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=265},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: game.Players.LocalPlayer.CameraMaxZoomDistance = value
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=203,bx=319},
  -- 
  -- RAW: ResetSection:AddButton({
  {op=1,a=178,bx=320},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=185,bx=322},
  -- RAW: char.Humanoid.WalkSpeed = 16
  -- RAW: char.Humanoid.JumpPower = 50
  -- RAW: workspace.Gravity = 196.2
  -- RAW: workspace.CurrentCamera.FieldOfView = 70
  -- RAW: game.Players.LocalPlayer.CameraMaxZoomDistance = 20
  {op=1,a=182,bx=273},
  {op=6,a=182,bx=292},
  {op=1,a=183,bx=10},
  {op=6,a=183,bx=296},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=204,bx=298},
  {op=10,a=204,b=204,c=306},
  {op=27,a=204,b=2,c=1},
  {op=1,a=184,bx=123},
  {op=6,a=184,bx=298},
  {op=29,a=0,b=1},
  {op=1,a=192,bx=307},
  {op=6,a=192,bx=309},
  {op=1,a=193,bx=10},
  {op=6,a=193,bx=311},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=205,bx=312},
  {op=10,a=205,b=205,c=306},
  {op=27,a=205,b=2,c=1},
  {op=1,a=194,bx=123},
  {op=6,a=194,bx=312},
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=206,bx=315},
  {op=10,a=206,b=206,c=306},
  {op=27,a=206,b=2,c=1},
  {op=1,a=195,bx=123},
  {op=6,a=195,bx=315},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: Window:Notify({
  {op=1,a=32,bx=323},
  {op=6,a=32,bx=56},
  {op=1,a=207,bx=324},
  {op=6,a=207,bx=325},
  {op=1,a=155,bx=326},
  {op=6,a=155,bx=221},
  -- RAW: })
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 标签页 2：设置
  -- -------------------------------------------------
  {op=1,a=208,bx=327},
  -- 
  {op=1,a=209,bx=328},
  -- 
  -- RAW: InfoSection:AddButton({
  {op=1,a=178,bx=329},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  -- RAW: Window:Notify({
  {op=1,a=32,bx=330},
  {op=6,a=32,bx=56},
  {op=1,a=207,bx=331},
  {op=6,a=207,bx=325},
  {op=1,a=155,bx=332},
  {op=6,a=155,bx=221},
  -- RAW: })
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: InfoSection:AddButton({
  {op=1,a=178,bx=333},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=210,bx=334},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=210,bx=335},
  {op=6,a=210,bx=336},
  -- RAW: end)
  -- RAW: Window:Notify({
  {op=1,a=32,bx=337},
  {op=6,a=32,bx=56},
  {op=1,a=207,bx=338},
  {op=6,a=207,bx=325},
  {op=1,a=155,bx=332},
  {op=6,a=155,bx=221},
  -- RAW: })
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: InfoSection:AddButton({
  {op=1,a=178,bx=339},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  -- RAW: Window:Notify({
  {op=1,a=32,bx=340},
  {op=6,a=32,bx=56},
  {op=1,a=207,bx=341},
  {op=6,a=207,bx=325},
  {op=1,a=155,bx=332},
  {op=6,a=155,bx=221},
  -- RAW: })
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 反作弊
  -- -------------------------------------------------
  {op=1,a=211,bx=342},
  -- RAW: ACSection:AddToggle({
  {op=1,a=178,bx=343},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  -- RAW: getgenv().WuAntiCheat = getgenv().WuAntiCheat or {}
  -- RAW: getgenv().WuAntiCheat.Enabled = state
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().WuAntiCheat._Applied = false
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=344},
  {op=1,a=1,bx=345},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=5,a=212,bx=304},
  {op=10,a=212,b=212,c=305},
  {op=27,a=212,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=213,bx=304},
  {op=10,a=213,b=213,c=305},
  {op=27,a=213,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 卡密管理
  -- -------------------------------------------------
  {op=1,a=214,bx=346},
  -- 
  -- RAW: KeySection:AddButton({
  {op=1,a=178,bx=347},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=348},
  {op=27,a=0,b=1,c=1},
  -- RAW: Window:Notify({
  {op=1,a=32,bx=349},
  {op=6,a=32,bx=56},
  {op=1,a=207,bx=350},
  {op=6,a=207,bx=325},
  {op=1,a=155,bx=351},
  {op=6,a=155,bx=221},
  -- RAW: })
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=215,bx=352},
  -- 
  -- RAW: UtilitySection:AddButton({
  {op=1,a=178,bx=353},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  -- RAW: game:GetService("TeleportService"):TeleportToPlaceInstance(
  -- RAW: game.PlaceId,
  -- RAW: game.JobId,
  -- RAW: game.Players.LocalPlayer
  -- RAW: )
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: UtilitySection:AddButton({
  {op=1,a=178,bx=354},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=216,bx=355},
  {op=10,a=216,b=216,c=356},
  {op=27,a=216,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 标签页 3：通用1
  -- -------------------------------------------------
  {op=1,a=217,bx=357},
  {op=1,a=218,bx=358},
  -- 
  {op=2,a=219,b=0,c=0},
  -- RAW: VisualSection:AddButton({
  {op=1,a=178,bx=359},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=219,bx=360},
  {op=6,a=219,bx=361},
  -- RAW: game.Lighting.Ambient = NightVision and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
  {op=5,a=220,bx=304},
  {op=10,a=220,b=220,c=305},
  {op=27,a=220,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- ===== 修改后的穿墙（纯点击开关，不再由跳跃关闭） =====
  {op=2,a=221,b=0,c=0},
  -- 
  -- RAW: VisualSection:AddButton({
  {op=1,a=178,bx=362},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=221,bx=363},
  {op=6,a=221,bx=364},
  {op=1,a=185,bx=322},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, part in pairs(char:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: part.CanCollide = false
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=5,a=222,bx=304},
  {op=10,a=222,b=222,c=305},
  {op=27,a=222,b=3,c=1},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, part in pairs(char:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: part.CanCollide = true
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=5,a=223,bx=304},
  {op=10,a=223,b=223,c=305},
  {op=27,a=223,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=2,a=224,b=0,c=0},
  -- RAW: VisualSection:AddButton({
  {op=1,a=178,bx=365},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=224,bx=366},
  {op=6,a=224,bx=367},
  -- RAW: Window:Notify({
  {op=1,a=32,bx=368},
  {op=6,a=32,bx=56},
  {op=1,a=207,bx=369},
  {op=6,a=207,bx=325},
  {op=1,a=155,bx=326},
  {op=6,a=155,bx=221},
  -- RAW: })
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- 跳跃监听：只负责无限跳，不再干扰穿墙
  {op=5,a=225,bx=355},
  {op=10,a=225,b=225,c=370},
  {op=27,a=225,b=3,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
  -- RAW: end)
  {op=29,a=0,b=1},
  -- -- 穿墙关闭代码已移除
  -- RAW: end)
  -- 
  {op=1,a=226,bx=371},
  -- 
  -- RAW: ToolSection:AddButton({
  {op=1,a=178,bx=372},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=227,bx=373},
  {op=1,a=228,bx=374},
  -- RAW: tool.RequiresHandle = false
  -- RAW: tool.Name = "[巫] 传送工具"
  -- RAW: tool.Activated:Connect(function()
  {op=1,a=229,bx=375},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
  -- RAW: end)
  -- RAW: end)
  -- RAW: tool.Parent = game.Players.LocalPlayer.Backpack
  {op=5,a=230,bx=304},
  {op=10,a=230,b=230,c=305},
  {op=27,a=230,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: ToolSection:AddButton({
  {op=1,a=178,bx=376},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=378},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: ToolSection:AddButton({
  {op=1,a=178,bx=379},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=380},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=232,bx=304},
  {op=10,a=232,b=232,c=305},
  {op=27,a=232,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=233,bx=304},
  {op=10,a=233,b=233,c=305},
  {op=27,a=233,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 标签页 4：范围设置
  -- -------------------------------------------------
  {op=1,a=234,bx=382},
  {op=1,a=235,bx=383},
  -- 
  {op=1,a=236,bx=140},
  {op=2,a=237,b=0,c=0},
  -- 
  {op=5,a=238,bx=355},
  {op=10,a=238,b=238,c=370},
  {op=27,a=238,b=3,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, v in pairs(game:GetService("Players"):GetPlayers()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=186,bx=384},
  -- RAW: root.Size = Vector3.new(HitboxSize, HitboxSize, HitboxSize)
  -- RAW: root.Transparency = 0.7
  -- RAW: root.BrickColor = BrickColor.new("Really red")
  -- RAW: root.Material = Enum.Material.Neon
  -- RAW: root.CanCollide = false
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- RAW: local function SetHitbox(size)
  {op=1,a=236,bx=385},
  {op=6,a=236,bx=386},
  {op=1,a=237,bx=40},
  {op=6,a=237,bx=387},
  {op=5,a=239,bx=304},
  {op=10,a=239,b=239,c=305},
  {op=27,a=239,b=3,c=1},
  {op=29,a=0,b=1},
  -- 
  {op=5,a=240,bx=388},
  {op=10,a=240,b=240,c=389},
  {op=27,a=240,b=3,c=1},
  {op=5,a=241,bx=388},
  {op=10,a=241,b=241,c=389},
  {op=27,a=241,b=3,c=1},
  {op=5,a=242,bx=388},
  {op=10,a=242,b=242,c=389},
  {op=27,a=242,b=3,c=1},
  {op=5,a=243,bx=388},
  {op=10,a=243,b=243,c=389},
  {op=27,a=243,b=3,c=1},
  {op=5,a=244,bx=388},
  {op=10,a=244,b=244,c=389},
  {op=27,a=244,b=3,c=1},
  {op=5,a=245,bx=388},
  {op=10,a=245,b=245,c=389},
  {op=27,a=245,b=3,c=1},
  {op=1,a=237,bx=10},
  {op=6,a=237,bx=387},
  {op=5,a=246,bx=304},
  {op=10,a=246,b=246,c=305},
  {op=27,a=246,b=3,c=1},
  -- RAW: end})
  -- 
  -- -- ===== 加载 hitbox 扩展器（带防重复） =====
  -- RAW: HitboxSection:AddButton({
  {op=1,a=178,bx=390},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=391},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=247,bx=304},
  {op=10,a=247,b=247,c=305},
  {op=27,a=247,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=248,bx=304},
  {op=10,a=248,b=248,c=305},
  {op=27,a=248,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 标签页 5：甩飞与传送
  -- -------------------------------------------------
  {op=1,a=249,bx=392},
  {op=1,a=250,bx=393},
  -- 
  {op=2,a=251,b=0,c=0},
  {op=3,a=252,b=0},
  {op=1,a=253,bx=394},
  -- 
  -- RAW: local function GetPlayer(Name)
  {op=1,a=178,bx=395},
  {op=6,a=178,bx=272},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=251,bx=40},
  {op=6,a=251,bx=396},
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  {op=1,a=254,bx=397},
  {op=1,a=76,bx=299},
  -- RAW: if table.find(GetPlayers, player) then table.remove(GetPlayers, table.find(GetPlayers, player)) end
  {op=1,a=0,bx=398},
  {op=29,a=0,b=2},
  {op=21,sbx=0},
  -- RAW: for _, x in next, game:GetService("Players"):GetPlayers() do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=399},
  {op=29,a=0,b=2},
  {op=21,sbx=0},
  {op=1,a=0,bx=399},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function SkidFling(TargetPlayer)
  {op=1,a=255,bx=299},
  {op=1,a=256,bx=400},
  {op=1,a=257,bx=401},
  {op=1,a=258,bx=402},
  -- 
  -- RAW: if not Character or not Humanoid or not RootPart then return end
  -- 
  {op=1,a=259,bx=403},
  -- RAW: if not TCharacter then return end
  -- 
  {op=1,a=260,bx=404},
  {op=1,a=261,bx=405},
  {op=1,a=262,bx=406},
  {op=1,a=263,bx=407},
  {op=1,a=264,bx=408},
  -- 
  -- RAW: if not TCharacter:FindFirstChildWhichIsA("BasePart") then return end
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=252,bx=409},
  {op=6,a=252,bx=410},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: workspace.CurrentCamera.CameraSubject = THead
  {op=21,sbx=0},
  -- RAW: workspace.CurrentCamera.CameraSubject = Handle
  {op=21,sbx=0},
  -- RAW: workspace.CurrentCamera.CameraSubject = THumanoid
  {op=29,a=0,b=1},
  -- 
  {op=1,a=265,bx=411},
  -- RAW: RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
  {op=5,a=266,bx=412},
  {op=10,a=266,b=266,c=413},
  {op=27,a=266,b=3,c=1},
  -- RAW: RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
  -- RAW: RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
  {op=29,a=0,b=1},
  -- 
  {op=1,a=267,bx=414},
  {op=1,a=268,bx=326},
  {op=1,a=269,bx=415},
  {op=1,a=270,bx=140},
  -- 
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=270,bx=416},
  {op=6,a=270,bx=417},
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=419},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=420},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=421},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=422},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=423},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=424},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  {op=21,sbx=0},
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=425},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=426},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=425},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=427},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=428},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=427},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=429},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=430},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=431},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  -- 
  {op=5,a=0,bx=418},
  {op=1,a=1,bx=430},
  {op=27,a=0,b=2,c=1},
  -- RAW: task.wait()
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  -- RAW: break
  {op=29,a=0,b=1},
  {op=25,a=0,c=1},
  {op=21,sbx=0},
  {op=29,a=0,b=1},
  -- 
  -- RAW: workspace.FallenPartsDestroyHeight = 0 / 0
  -- 
  {op=1,a=271,bx=432},
  -- RAW: BV.Name = "EpixVel"
  -- RAW: BV.Parent = RootPart
  -- RAW: BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
  -- RAW: BV.MaxForce = Vector3.new(1 / 0, 1 / 0, 1 / 0)
  -- 
  {op=5,a=272,bx=433},
  {op=10,a=272,b=272,c=434},
  {op=27,a=272,b=3,c=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=435},
  {op=0,a=1,b=262},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=435},
  {op=0,a=1,b=261},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=435},
  {op=0,a=1,b=261},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=435},
  {op=0,a=1,b=262},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=435},
  {op=0,a=1,b=264},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=5,a=273,bx=436},
  {op=10,a=273,b=273,c=43},
  {op=27,a=273,b=2,c=1},
  {op=5,a=274,bx=433},
  {op=10,a=274,b=274,c=434},
  {op=27,a=274,b=3,c=1},
  -- RAW: workspace.CurrentCamera.CameraSubject = Humanoid
  -- 
  {op=21,sbx=0},
  -- RAW: RootPart.CFrame = OldPos * CFrame.new(0, 0.5, 0)
  {op=5,a=275,bx=412},
  {op=10,a=275,b=275,c=413},
  {op=27,a=275,b=3,c=1},
  {op=5,a=276,bx=433},
  {op=10,a=276,b=276,c=437},
  {op=1,a=278,bx=438},
  {op=27,a=276,b=3,c=1},
  -- RAW: for _, x in next, Character:GetChildren() do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: task.wait()
  {op=25,a=0,c=1},
  {op=21,sbx=0},
  -- RAW: workspace.FallenPartsDestroyHeight = FPDH
  {op=29,a=0,b=1},
  -- 
  -- RAW: FlingSection:AddButton({
  {op=1,a=178,bx=439},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=277,bx=109},
  {op=1,a=255,bx=440},
  {op=9,a=278,b=0,c=0},
  {op=1,a=251,bx=10},
  {op=6,a=251,bx=396},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, x in next, Targets do
  {op=5,a=0,bx=441},
  {op=1,a=1,bx=399},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, x in next, Players:GetPlayers() do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=442},
  {op=1,a=1,bx=399},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: for _, x in next, Targets do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=279,bx=443},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=442},
  {op=0,a=1,b=279},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  {op=5,a=280,bx=304},
  {op=10,a=280,b=280,c=305},
  {op=27,a=280,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=5,a=281,bx=304},
  {op=10,a=281,b=281,c=305},
  {op=27,a=281,b=3,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=282,bx=32},
  {op=9,a=283,b=0,c=0},
  -- 
  -- RAW: local function refreshPlayerList()
  {op=1,a=283,bx=444},
  {op=6,a=283,bx=445},
  -- RAW: for _, player in pairs(game:GetService("Players"):GetPlayers()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: table.insert(playerList, player.Name)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=0,a=0,b=283},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=284,bx=446},
  {op=1,a=178,bx=447},
  {op=6,a=178,bx=272},
  {op=1,a=285,bx=448},
  {op=6,a=285,bx=449},
  {op=1,a=179,bx=63},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=450},
  {op=6,a=158,bx=227},
  {op=1,a=282,bx=451},
  {op=6,a=282,bx=452},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: FlingSection:AddButton({
  {op=1,a=178,bx=453},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=286,bx=454},
  {op=10,a=286,b=286,c=455},
  {op=27,a=286,b=3,c=1},
  {op=5,a=287,bx=304},
  {op=10,a=287,b=287,c=305},
  {op=27,a=287,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: FlingSection:AddButton({
  {op=1,a=178,bx=456},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=288,bx=304},
  {op=10,a=288,b=288,c=305},
  {op=27,a=288,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=289,bx=457},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=251,bx=10},
  {op=6,a=251,bx=396},
  {op=5,a=0,bx=442},
  {op=0,a=1,b=289},
  {op=27,a=0,b=2,c=1},
  {op=5,a=290,bx=304},
  {op=10,a=290,b=290,c=305},
  {op=27,a=290,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=291,bx=304},
  {op=10,a=291,b=291,c=305},
  {op=27,a=291,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- ===== 防甩飞（禁用碰撞版 - 作用于所有其他玩家） =====
  {op=2,a=292,b=0,c=0},
  {op=9,a=293,b=0,c=0},
  -- 
  -- RAW: local function SetupCharacterCollision(char)
  -- RAW: if not char then return end
  -- 
  -- RAW: local function DisableCollide(part)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: part.CanCollide = false
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: for _, part in ipairs(char:GetChildren()) do
  {op=5,a=0,bx=458},
  {op=1,a=1,bx=459},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=294,bx=460},
  -- 
  {op=1,a=295,bx=461},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, part in ipairs(char:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: part.CanCollide = false
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: CollisionAntiFlingConnections[char] = {}
  {op=29,a=0,b=1},
  -- RAW: table.insert(CollisionAntiFlingConnections[char], childAddedConn)
  -- RAW: table.insert(CollisionAntiFlingConnections[char], steppedConn)
  -- 
  -- RAW: char.Destroying:Connect(function()
  -- RAW: for _, conn in ipairs(CollisionAntiFlingConnections[char] or {}) do
  {op=5,a=296,bx=462},
  {op=10,a=296,b=296,c=306},
  {op=27,a=296,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: CollisionAntiFlingConnections[char] = nil
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function ApplyCollisionAntiFling()
  -- RAW: for _, connList in pairs(CollisionAntiFlingConnections) do
  -- RAW: for _, conn in ipairs(connList) do
  {op=5,a=297,bx=462},
  {op=10,a=297,b=297,c=306},
  {op=27,a=297,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=293,bx=444},
  {op=6,a=293,bx=463},
  -- 
  -- RAW: if not CollisionAntiFlingEnabled then return end
  -- 
  -- RAW: for _, player in pairs(game:GetService("Players"):GetPlayers()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=464},
  {op=1,a=1,bx=300},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: player.CharacterAdded:Connect(function(char)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=464},
  {op=0,a=1,b=185},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=5,a=298,bx=355},
  {op=10,a=298,b=298,c=370},
  {op=27,a=298,b=3,c=1},
  -- RAW: if player == game.Players.LocalPlayer then return end
  -- RAW: player.CharacterAdded:Connect(function(char)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=464},
  {op=0,a=1,b=185},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: end)
  -- 
  -- RAW: FlingSection:AddToggle({
  {op=1,a=178,bx=465},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=1,a=292,bx=295},
  {op=6,a=292,bx=466},
  {op=5,a=0,bx=467},
  {op=27,a=0,b=1,c=1},
  -- RAW: Window:Notify({
  {op=1,a=32,bx=468},
  {op=6,a=32,bx=56},
  {op=1,a=207,bx=469},
  {op=6,a=207,bx=325},
  {op=1,a=155,bx=326},
  {op=6,a=155,bx=221},
  -- RAW: })
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 传送与查看（来自殺脚本思路）
  -- -------------------------------------------------
  {op=1,a=299,bx=470},
  -- 
  {op=2,a=300,b=0,c=0},
  {op=2,a=301,b=0,c=0},
  {op=2,a=302,b=0,c=0},
  -- 
  -- RAW: local function getSelectedTarget()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=123},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=157,bx=457},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=0,a=0,b=157},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=123},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: TpSection:AddButton({
  {op=1,a=178,bx=471},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=289,bx=472},
  {op=1,a=303,bx=473},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: myRoot.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
  {op=5,a=304,bx=304},
  {op=10,a=304,b=304,c=305},
  {op=27,a=304,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=305,bx=304},
  {op=10,a=305,b=305,c=305},
  {op=27,a=305,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TpSection:AddToggle({
  {op=1,a=178,bx=474},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=1,a=300,bx=295},
  {op=6,a=300,bx=475},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=306,bx=304},
  {op=10,a=306,b=306,c=305},
  {op=27,a=306,b=3,c=1},
  -- RAW: task.spawn(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=289,bx=472},
  {op=1,a=303,bx=473},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: myRoot.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
  {op=29,a=0,b=1},
  -- RAW: task.wait()
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=21,sbx=0},
  {op=5,a=307,bx=304},
  {op=10,a=307,b=307,c=305},
  {op=27,a=307,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TpSection:AddButton({
  {op=1,a=178,bx=476},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=289,bx=472},
  {op=1,a=303,bx=473},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: target.Character.HumanoidRootPart.CFrame = myRoot.CFrame + Vector3.new(0, 3, 0)
  {op=5,a=308,bx=304},
  {op=10,a=308,b=308,c=305},
  {op=27,a=308,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=309,bx=304},
  {op=10,a=309,b=309,c=305},
  {op=27,a=309,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TpSection:AddToggle({
  {op=1,a=178,bx=477},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=1,a=301,bx=295},
  {op=6,a=301,bx=478},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=310,bx=304},
  {op=10,a=310,b=310,c=305},
  {op=27,a=310,b=3,c=1},
  -- RAW: task.spawn(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=289,bx=472},
  {op=1,a=303,bx=473},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: target.Character.HumanoidRootPart.CFrame = myRoot.CFrame + Vector3.new(0, 3, 0)
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: task.wait()
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=21,sbx=0},
  {op=5,a=311,bx=304},
  {op=10,a=311,b=311,c=305},
  {op=27,a=311,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TpSection:AddToggle({
  {op=1,a=178,bx=479},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=1,a=302,bx=295},
  {op=6,a=302,bx=480},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=289,bx=472},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=187,bx=481},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: workspace.CurrentCamera.CameraSubject = hum
  {op=5,a=312,bx=304},
  {op=10,a=312,b=312,c=305},
  {op=27,a=312,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=5,a=313,bx=304},
  {op=10,a=313,b=313,c=305},
  {op=27,a=313,b=3,c=1},
  {op=21,sbx=0},
  {op=1,a=3,bx=299},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: workspace.CurrentCamera.CameraSubject = lp.Character:FindFirstChildOfClass("Humanoid")
  {op=29,a=0,b=1},
  {op=5,a=314,bx=304},
  {op=10,a=314,b=314,c=305},
  {op=27,a=314,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 标签页 6：工具
  -- -------------------------------------------------
  {op=1,a=315,bx=482},
  {op=1,a=316,bx=483},
  -- 
  -- RAW: VisSection:AddButton({
  {op=1,a=178,bx=484},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=317,bx=304},
  {op=10,a=317,b=317,c=305},
  {op=27,a=317,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.WuFPSPingLoaded = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=318,bx=485},
  {op=1,a=319,bx=486},
  {op=1,a=277,bx=109},
  {op=1,a=320,bx=440},
  -- 
  {op=1,a=321,bx=33},
  -- RAW: ScreenGui.Name = "FPS_Ping_Display"
  -- RAW: ScreenGui.ResetOnSpawn = false
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=487},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
  {op=29,a=0,b=1},
  -- 
  {op=1,a=322,bx=139},
  -- RAW: Frame.Size = UDim2.new(0, 200, 0, 80)
  -- RAW: Frame.Position = UDim2.new(0.7, 0, 0.05, 0)
  -- RAW: Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
  -- RAW: Frame.BackgroundTransparency = 0.3
  -- RAW: Frame.BorderSizePixel = 2
  -- RAW: Frame.Active = true
  -- RAW: Frame.Draggable = true
  -- RAW: Frame.Parent = ScreenGui
  -- 
  {op=1,a=323,bx=142},
  -- RAW: TitleLabel.Size = UDim2.new(1, 0, 0.3, 0)
  -- RAW: TitleLabel.Position = UDim2.new(0, 0, 0, 0)
  -- RAW: TitleLabel.BackgroundTransparency = 1
  -- RAW: TitleLabel.Text = "FPS & Ping"
  -- RAW: TitleLabel.Font = Enum.Font.SourceSansBold
  -- RAW: TitleLabel.TextSize = 16
  -- RAW: TitleLabel.TextColor3 = Color3.new(1, 1, 1)
  -- RAW: TitleLabel.Parent = Frame
  -- 
  {op=1,a=324,bx=142},
  -- RAW: FPSText.Size = UDim2.new(1, 0, 0.35, 0)
  -- RAW: FPSText.Position = UDim2.new(0, 0, 0.3, 0)
  -- RAW: FPSText.BackgroundTransparency = 1
  -- RAW: FPSText.Font = Enum.Font.SourceSansBold
  -- RAW: FPSText.TextSize = 16
  -- RAW: FPSText.TextColor3 = Color3.new(1, 1, 1)
  -- RAW: FPSText.Parent = Frame
  -- 
  {op=1,a=325,bx=142},
  -- RAW: PingText.Size = UDim2.new(1, 0, 0.35, 0)
  -- RAW: PingText.Position = UDim2.new(0, 0, 0.65, 0)
  -- RAW: PingText.BackgroundTransparency = 1
  -- RAW: PingText.Font = Enum.Font.SourceSansBold
  -- RAW: PingText.TextSize = 16
  -- RAW: PingText.TextColor3 = Color3.new(1, 1, 1)
  -- RAW: PingText.Parent = Frame
  -- 
  -- RAW: task.spawn(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=326,bx=488},
  {op=1,a=327,bx=140},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=327,bx=489},
  {op=6,a=327,bx=490},
  -- RAW: end)
  {op=1,a=328,bx=491},
  {op=1,a=329,bx=492},
  -- RAW: FPSText.Text = "FPS: " .. fps .. " (" .. fpsRating .. ")"
  -- RAW: PingText.Text = "Ping: " .. ping .. "ms (" .. pingRating .. ")"
  -- RAW: task.wait(1)
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: end)
  {op=5,a=330,bx=304},
  {op=10,a=330,b=330,c=305},
  {op=27,a=330,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: VisSection:AddButton({
  {op=1,a=178,bx=493},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=331,bx=33},
  {op=1,a=332,bx=142},
  -- RAW: LBLG.Name = "LBLG"
  -- RAW: LBLG.Parent = game.CoreGui
  -- RAW: LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  -- RAW: LBLG.Enabled = true
  -- RAW: LBL.Name = "LBL"
  -- RAW: LBL.Parent = LBLG
  -- RAW: LBL.BackgroundColor3 = Color3.new(1, 1, 1)
  -- RAW: LBL.BackgroundTransparency = 1
  -- RAW: LBL.BorderColor3 = Color3.new(0, 0, 0)
  -- RAW: LBL.Position = UDim2.new(0.75, 0, 0.010, 0)
  -- RAW: LBL.Size = UDim2.new(0, 133, 0, 30)
  -- RAW: LBL.Font = Enum.Font.GothamSemibold
  -- RAW: LBL.Text = "时间"
  -- RAW: LBL.TextColor3 = Color3.new(1, 1, 1)
  -- RAW: LBL.TextScaled = true
  -- RAW: LBL.TextSize = 14
  -- RAW: LBL.TextWrapped = true
  -- RAW: LBL.Visible = true
  {op=5,a=333,bx=355},
  {op=10,a=333,b=333,c=370},
  {op=27,a=333,b=3,c=1},
  -- RAW: LBL.Text = "时间:" .. os.date("%H") .. "时" .. os.date("%M") .. "分" .. os.date("%S") .. "秒"
  -- RAW: end)
  -- RAW: end)
  {op=5,a=334,bx=304},
  {op=10,a=334,b=334,c=305},
  {op=27,a=334,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: VisSection:AddButton({
  {op=1,a=178,bx=494},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=495},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=335,bx=496},
  -- 
  -- RAW: UtilSection2:AddButton({
  {op=1,a=178,bx=497},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=498},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: UtilSection2:AddButton({
  {op=1,a=178,bx=499},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=500},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: UtilSection2:AddButton({
  {op=1,a=178,bx=501},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=502},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: UtilSection2:AddButton({
  {op=1,a=178,bx=503},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=504},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=336,bx=304},
  {op=10,a=336,b=336,c=305},
  {op=27,a=336,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=337,bx=304},
  {op=10,a=337,b=337,c=305},
  {op=27,a=337,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=2,a=338,b=0,c=0},
  {op=3,a=339,b=0},
  -- 
  -- RAW: UtilSection2:AddToggle({
  {op=1,a=178,bx=505},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=1,a=338,bx=295},
  {op=6,a=338,bx=506},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=340,bx=507},
  {op=10,a=340,b=340,c=306},
  {op=27,a=340,b=2,c=1},
  {op=1,a=339,bx=123},
  {op=6,a=339,bx=507},
  {op=29,a=0,b=1},
  {op=1,a=339,bx=508},
  {op=6,a=339,bx=507},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=341,bx=507},
  {op=10,a=341,b=341,c=306},
  {op=27,a=341,b=2,c=1},
  {op=1,a=339,bx=123},
  {op=6,a=339,bx=507},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: for _, descendant in pairs(workspace:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=509},
  {op=1,a=1,bx=510},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=342,bx=507},
  {op=10,a=342,b=342,c=306},
  {op=27,a=342,b=2,c=1},
  {op=1,a=339,bx=123},
  {op=6,a=339,bx=507},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=3,a=343,b=0},
  -- RAW: UtilSection2:AddButton({
  {op=1,a=178,bx=511},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=344,bx=512},
  {op=10,a=344,b=344,c=306},
  {op=27,a=344,b=2,c=1},
  {op=1,a=343,bx=123},
  {op=6,a=343,bx=512},
  {op=29,a=0,b=1},
  {op=1,a=343,bx=513},
  {op=6,a=343,bx=512},
  -- RAW: prompt.HoldDuration = 0
  -- RAW: end)
  {op=5,a=345,bx=304},
  {op=10,a=345,b=345,c=305},
  {op=27,a=345,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 标签页 7：趣味
  -- -------------------------------------------------
  {op=1,a=346,bx=514},
  {op=1,a=347,bx=515},
  -- 
  -- RAW: MoveSection:AddButton({
  {op=1,a=178,bx=516},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=517},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MoveSection:AddButton({
  {op=1,a=178,bx=518},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=519},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MoveSection:AddButton({
  {op=1,a=178,bx=520},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=521},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=348,bx=522},
  -- 
  -- RAW: SpinSection:AddButton({
  {op=1,a=178,bx=523},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=524},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=349,bx=299},
  {op=1,a=350,bx=525},
  -- RAW: Anim.AnimationId = "rbxassetid://27432686"
  {op=1,a=351,bx=526},
  {op=5,a=352,bx=527},
  {op=10,a=352,b=352,c=146},
  {op=27,a=352,b=2,c=1},
  {op=5,a=353,bx=527},
  {op=10,a=353,b=353,c=528},
  {op=1,a=355,bx=140},
  {op=27,a=353,b=3,c=1},
  -- RAW: speaker.Character.Animate.Disabled = true
  {op=1,a=354,bx=144},
  -- RAW: hi.Name = "Sound"
  -- RAW: hi.SoundId = "http://www.roblox.com/asset/?id=8114290584"
  -- RAW: hi.Volume = 2
  -- RAW: hi.Looped = false
  -- RAW: hi.archivable = false
  -- RAW: hi.Parent = game.Workspace
  {op=5,a=355,bx=529},
  {op=10,a=355,b=355,c=146},
  {op=27,a=355,b=2,c=1},
  {op=5,a=0,bx=530},
  {op=1,a=1,bx=531},
  {op=27,a=0,b=2,c=1},
  {op=1,a=356,bx=286},
  {op=1,a=357,bx=532},
  -- RAW: Spin.Name = "Spinning"
  -- RAW: Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
  -- RAW: Spin.MaxTorque = Vector3.new(0, math.huge, 0)
  -- RAW: Spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
  -- RAW: end)
  {op=21,sbx=0},
  {op=5,a=0,bx=524},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=349,bx=299},
  {op=1,a=350,bx=525},
  -- RAW: Anim.AnimationId = "rbxassetid://507776043"
  {op=1,a=351,bx=526},
  {op=5,a=358,bx=527},
  {op=10,a=358,b=358,c=146},
  {op=27,a=358,b=2,c=1},
  {op=5,a=359,bx=527},
  {op=10,a=359,b=359,c=528},
  {op=1,a=361,bx=140},
  {op=27,a=359,b=3,c=1},
  -- RAW: speaker.Character.Animate.Disabled = true
  {op=1,a=354,bx=144},
  -- RAW: hi.Name = "Sound"
  -- RAW: hi.SoundId = "http://www.roblox.com/asset/?id=8114290584"
  -- RAW: hi.Volume = 0
  -- RAW: hi.Looped = false
  -- RAW: hi.archivable = false
  -- RAW: hi.Parent = game.Workspace
  {op=5,a=360,bx=529},
  {op=10,a=360,b=360,c=146},
  {op=27,a=360,b=2,c=1},
  {op=5,a=0,bx=530},
  {op=27,a=0,b=1,c=1},
  {op=1,a=356,bx=286},
  {op=1,a=357,bx=532},
  -- RAW: Spin.Name = "Spinning"
  -- RAW: Spin.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
  -- RAW: Spin.MaxTorque = Vector3.new(0, math.huge, 0)
  -- RAW: Spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=361,bx=304},
  {op=10,a=361,b=361,c=305},
  {op=27,a=361,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SpinSection:AddButton({
  {op=1,a=178,bx=533},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=534},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SpinSection:AddButton({
  {op=1,a=178,bx=535},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=536},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=362,bx=537},
  -- 
  -- RAW: MiscSection:AddSlider({
  {op=1,a=178,bx=538},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=140},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=539},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=307},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: game.Players.LocalPlayer.Character.Humanoid.Health = value
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=540},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: game.Players.LocalPlayer.Character.Head:Remove()
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=541},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=3,bx=5},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=185,bx=542},
  -- RAW: char.Archivable = true
  {op=1,a=363,bx=543},
  -- RAW: new.Parent = workspace
  -- RAW: lp.Character = new
  {op=5,a=0,bx=530},
  {op=1,a=1,bx=544},
  {op=27,a=0,b=2,c=1},
  {op=1,a=364,bx=545},
  {op=1,a=365,bx=546},
  -- RAW: newhum.Parent = char
  -- RAW: newhum.RequiresNeck = false
  -- RAW: oldhum.Parent = nil
  {op=5,a=0,bx=530},
  {op=1,a=1,bx=544},
  {op=27,a=0,b=2,c=1},
  -- RAW: lp.Character = char
  {op=5,a=366,bx=547},
  {op=10,a=366,b=366,c=43},
  {op=27,a=366,b=2,c=1},
  {op=5,a=0,bx=530},
  {op=1,a=1,bx=544},
  {op=27,a=0,b=2,c=1},
  {op=5,a=367,bx=548},
  {op=10,a=367,b=367,c=549},
  {op=27,a=367,b=3,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: oldhum.Parent = lp.Character
  {op=5,a=0,bx=530},
  {op=1,a=1,bx=544},
  {op=27,a=0,b=2,c=1},
  {op=5,a=368,bx=550},
  {op=10,a=368,b=368,c=43},
  {op=27,a=368,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: workspace.CurrentCamera.CameraSubject = char
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: char.Animate.Disabled = true
  {op=5,a=0,bx=530},
  {op=1,a=1,bx=544},
  {op=27,a=0,b=2,c=1},
  -- RAW: char.Animate.Disabled = false
  {op=29,a=0,b=1},
  -- RAW: lp.Character:FindFirstChild("Head"):Destroy()
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=369,bx=304},
  {op=10,a=369,b=369,c=305},
  {op=27,a=369,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=551},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=552},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=553},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=554},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=555},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=556},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=557},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=558},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=559},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=560},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=561},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=562},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=563},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=564},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=565},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=566},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=370,bx=304},
  {op=10,a=370,b=370,c=305},
  {op=27,a=370,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=567},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=568},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=371,bx=304},
  {op=10,a=371,b=371,c=305},
  {op=27,a=371,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=569},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=372,bx=304},
  {op=10,a=372,b=372,c=305},
  {op=27,a=372,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts["WuWallHop"] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- -- 巫墙跳（中文版 WallHop）
  {op=1,a=80,bx=33},
  -- RAW: screenGui.Name = "WuWallHop"
  -- RAW: screenGui.ResetOnSpawn = false
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=138},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
  {op=29,a=0,b=1},
  -- 
  {op=1,a=373,bx=570},
  {op=1,a=277,bx=109},
  {op=1,a=318,bx=485},
  {op=1,a=76,bx=440},
  -- 
  {op=1,a=133,bx=139},
  -- RAW: frame.Parent = screenGui
  -- RAW: frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
  -- RAW: frame.Size = UDim2.new(0, 200, 0, 415)
  -- RAW: frame.Position = UDim2.new(0.5, -100, 0.5, -207)
  -- RAW: frame.Active = true
  {op=1,a=374,bx=571},
  -- 
  -- -- 拖动
  -- RAW: local dragging, dragStart, startPos
  -- RAW: frame.InputBegan:Connect(function(input)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=375,bx=40},
  {op=6,a=375,bx=572},
  {op=1,a=376,bx=573},
  {op=6,a=376,bx=574},
  {op=1,a=377,bx=575},
  {op=6,a=377,bx=576},
  -- RAW: input.Changed:Connect(function()
  -- RAW: if input.UserInputState == Enum.UserInputState.End then dragging = false end
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: UIS.InputChanged:Connect(function(input)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=378,bx=577},
  -- RAW: frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  {op=1,a=379,bx=142},
  -- RAW: statusLabel.Parent = frame
  -- RAW: statusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
  -- RAW: statusLabel.Size = UDim2.new(1, 0, 0, 28)
  -- RAW: statusLabel.Position = UDim2.new(0, 0, 0, 0)
  -- RAW: statusLabel.Text = "巫墙跳：关闭"
  -- RAW: statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
  -- RAW: statusLabel.Font = Enum.Font.GothamBold
  -- RAW: statusLabel.TextSize = 14
  {op=1,a=380,bx=578},
  -- 
  -- RAW: local function makeBtn(text, y, color)
  {op=1,a=381,bx=166},
  -- RAW: b.Parent = frame
  -- RAW: b.BackgroundColor3 = color or Color3.fromRGB(50, 50, 55)
  -- RAW: b.Size = UDim2.new(0, 160, 0, 28)
  -- RAW: b.Position = UDim2.new(0, 20, 0, y)
  -- RAW: b.Text = text
  -- RAW: b.TextColor3 = Color3.fromRGB(255, 255, 255)
  -- RAW: b.Font = Enum.Font.Gotham
  -- RAW: b.TextSize = 13
  {op=1,a=382,bx=579},
  {op=0,a=0,b=381},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=383,bx=580},
  {op=1,a=384,bx=581},
  {op=1,a=385,bx=582},
  {op=1,a=386,bx=583},
  {op=1,a=387,bx=584},
  {op=1,a=388,bx=585},
  -- 
  -- RAW: local function makeSlider(labelText, y, default, minV, maxV, fmt)
  {op=1,a=389,bx=142},
  -- RAW: lab.Parent = frame
  -- RAW: lab.BackgroundTransparency = 1
  -- RAW: lab.Size = UDim2.new(0, 160, 0, 16)
  -- RAW: lab.Position = UDim2.new(0, 20, 0, y)
  -- RAW: lab.Text = string.format(fmt, default)
  -- RAW: lab.TextColor3 = Color3.fromRGB(220, 220, 220)
  -- RAW: lab.Font = Enum.Font.Gotham
  -- RAW: lab.TextSize = 12
  -- RAW: lab.TextXAlignment = Enum.TextXAlignment.Left
  -- 
  {op=1,a=390,bx=139},
  -- RAW: bg.Parent = frame
  -- RAW: bg.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
  -- RAW: bg.Size = UDim2.new(0, 160, 0, 8)
  -- RAW: bg.Position = UDim2.new(0, 20, 0, y + 18)
  {op=1,a=391,bx=586},
  -- 
  {op=1,a=392,bx=166},
  -- RAW: knob.Parent = bg
  -- RAW: knob.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
  -- RAW: knob.Size = UDim2.new(0, 12, 0, 16)
  {op=1,a=393,bx=587},
  -- RAW: knob.Position = UDim2.new(scale0, -6, 0.5, -8)
  -- RAW: knob.Text = ""
  {op=1,a=394,bx=588},
  -- 
  {op=1,a=395,bx=589},
  {op=2,a=396,b=0,c=0},
  -- RAW: knob.InputBegan:Connect(function(i)
  -- RAW: if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then active = true end
  -- RAW: end)
  -- RAW: UIS.InputEnded:Connect(function(i)
  -- RAW: if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then active = false end
  -- RAW: end)
  -- RAW: UIS.InputChanged:Connect(function(i)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: local ax, aw = bg.AbsolutePosition.X, bg.AbsoluteSize.X
  {op=1,a=89,bx=590},
  {op=1,a=395,bx=591},
  {op=6,a=395,bx=291},
  -- RAW: knob.Position = UDim2.new(s, -6, 0.5, -8)
  -- RAW: lab.Text = string.format(fmt, value)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=1,a=0,bx=592},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=397,bx=593},
  {op=1,a=398,bx=594},
  {op=1,a=399,bx=595},
  -- 
  {op=9,a=400,b=0,c=0},
  -- RAW: local jumpConn, autoConn
  -- 
  {op=1,a=401,bx=596},
  -- RAW: rayParams.FilterType = Enum.RaycastFilterType.Blacklist
  -- 
  -- RAW: local function getWall()
  {op=1,a=185,bx=300},
  -- RAW: if not char then return nil end
  {op=1,a=402,bx=301},
  -- RAW: if not hrp then return nil end
  -- RAW: rayParams.FilterDescendantsInstances = {char}
  -- RAW: local closest, minD = nil, 3.5
  -- RAW: local function isHum(inst)
  {op=1,a=403,bx=597},
  {op=1,a=0,bx=598},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=91,bx=140},
  {op=1,a=92,bx=599},
  {op=1,a=93,bx=148},
  {op=31,a=91,sbx=0},
  {op=1,a=404,bx=600},
  {op=1,a=150,bx=601},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: minD, closest = r.Distance, r
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=602},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function doJump(hit)
  -- RAW: if not state.enabled or not state.canJump or not hit then return end
  {op=1,a=185,bx=300},
  {op=1,a=187,bx=603},
  {op=1,a=186,bx=604},
  {op=1,a=122,bx=172},
  -- RAW: if not (hum and root and cam) or hum:GetState() == Enum.HumanoidStateType.Dead then return end
  -- RAW: state.canJump = false
  -- 
  {op=1,a=405,bx=605},
  {op=1,a=406,bx=606},
  -- RAW: if away.Magnitude < 0.1 then away = -root.CFrame.LookVector * Vector3.new(1,0,1) end
  {op=1,a=406,bx=607},
  {op=6,a=406,bx=608},
  -- 
  {op=1,a=407,bx=609},
  {op=1,a=407,bx=610},
  {op=6,a=407,bx=611},
  {op=1,a=408,bx=612},
  {op=1,a=409,bx=613},
  {op=1,a=410,bx=614},
  {op=1,a=411,bx=615},
  {op=1,a=412,bx=616},
  {op=1,a=413,bx=617},
  {op=1,a=289,bx=618},
  -- RAW: root.CFrame = CFrame.lookAt(root.Position, root.Position + target)
  -- RAW: task.wait(getFlickSpeed() * 0.05)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=414,bx=619},
  {op=10,a=414,b=414,c=437},
  {op=27,a=414,b=3,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: task.spawn(function()
  -- RAW: task.wait()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, root.AssemblyLinearVelocity.Y * getDfMult(), root.AssemblyLinearVelocity.Z)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: task.delay(0.15, function() state.canJump = true end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function start()
  -- RAW: if jumpConn then jumpConn:Disconnect() end
  {op=1,a=415,bx=620},
  {op=6,a=415,bx=621},
  -- RAW: if state.enabled then doJump(getWall()) end
  -- RAW: end)
  -- RAW: if autoConn then autoConn:Disconnect() end
  {op=1,a=416,bx=622},
  {op=6,a=416,bx=623},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=624},
  {op=1,a=1,bx=625},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function stop()
  -- RAW: if jumpConn then jumpConn:Disconnect() jumpConn = nil end
  -- RAW: if autoConn then autoConn:Disconnect() autoConn = nil end
  {op=29,a=0,b=1},
  -- 
  -- RAW: onBtn.MouseButton1Click:Connect(function()
  -- RAW: state.enabled = true
  -- RAW: statusLabel.Text = "巫墙跳：开启"
  -- RAW: statusLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
  {op=5,a=0,bx=626},
  {op=27,a=0,b=1,c=1},
  -- RAW: end)
  -- RAW: offBtn.MouseButton1Click:Connect(function()
  -- RAW: state.enabled = false
  -- RAW: statusLabel.Text = "巫墙跳：关闭"
  -- RAW: statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
  {op=5,a=0,bx=627},
  {op=27,a=0,b=1,c=1},
  -- RAW: end)
  -- RAW: autoBtn.MouseButton1Click:Connect(function()
  -- RAW: state.auto = not state.auto
  -- RAW: autoBtn.Text = state.auto and "自动：开" or "自动：关"
  -- RAW: autoBtn.BackgroundColor3 = state.auto and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(200, 60, 60)
  -- RAW: end)
  -- RAW: autoJumpBtn.MouseButton1Click:Connect(function()
  -- RAW: state.autoJump = not state.autoJump
  -- RAW: autoJumpBtn.Text = state.autoJump and "自动跳：开" or "自动跳：关"
  -- RAW: autoJumpBtn.BackgroundColor3 = state.autoJump and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(200, 60, 60)
  -- RAW: end)
  -- RAW: dfBtn.MouseButton1Click:Connect(function()
  -- RAW: state.downforce = not state.downforce
  -- RAW: dfBtn.Text = state.downforce and "下压力：开" or "下压力：关"
  -- RAW: dfBtn.BackgroundColor3 = state.downforce and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(200, 60, 60)
  -- RAW: end)
  -- RAW: destroyBtn.MouseButton1Click:Connect(function()
  {op=5,a=0,bx=627},
  {op=27,a=0,b=1,c=1},
  {op=5,a=417,bx=628},
  {op=10,a=417,b=417,c=43},
  {op=27,a=417,b=2,c=1},
  -- RAW: _G.LoadedScripts["WuWallHop"] = nil
  -- RAW: end)
  -- RAW: end)
  {op=5,a=418,bx=304},
  {op=10,a=418,b=418,c=305},
  {op=27,a=418,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- ===== 新增：从「伊散全源」移植的独立工具（防重复加载） =====
  -- RAW: local function addToolButton(name, url, notifyContent)
  -- RAW: MiscSection:AddButton({
  {op=1,a=178,bx=629},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=419,bx=304},
  {op=10,a=419,b=419,c=305},
  {op=27,a=419,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=420,bx=304},
  {op=10,a=420,b=420,c=305},
  {op=27,a=420,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  {op=29,a=0,b=1},
  -- 
  {op=5,a=0,bx=630},
  {op=1,a=1,bx=631},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=630},
  {op=1,a=1,bx=632},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=630},
  {op=1,a=1,bx=633},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=630},
  {op=1,a=1,bx=634},
  {op=27,a=0,b=2,c=1},
  -- 
  -- -------------------------------------------------
  -- -- 标签页 8：服务器脚本
  -- -------------------------------------------------
  {op=1,a=421,bx=635},
  {op=1,a=422,bx=636},
  -- 
  -- -- 翻译脚本放最上面（不带编号）
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=637},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=423,bx=638},
  {op=6,a=423,bx=639},
  {op=1,a=424,bx=640},
  {op=6,a=424,bx=641},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=642},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=643},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=644},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=425,bx=304},
  {op=10,a=425,b=425,c=305},
  {op=27,a=425,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=426,bx=304},
  {op=10,a=426,b=426,c=305},
  {op=27,a=426,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=645},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=646},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=427,bx=304},
  {op=10,a=427,b=427,c=305},
  {op=27,a=427,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=428,bx=304},
  {op=10,a=428,b=428,c=305},
  {op=27,a=428,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=647},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=648},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=429,bx=304},
  {op=10,a=429,b=429,c=305},
  {op=27,a=429,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=430,bx=304},
  {op=10,a=430,b=430,c=305},
  {op=27,a=430,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=649},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=650},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=431,bx=304},
  {op=10,a=431,b=431,c=305},
  {op=27,a=431,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=432,bx=304},
  {op=10,a=432,b=432,c=305},
  {op=27,a=432,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=651},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=652},
  {op=1,a=433,bx=653},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=434,bx=304},
  {op=10,a=434,b=434,c=305},
  {op=27,a=434,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=435,bx=304},
  {op=10,a=435,b=435,c=305},
  {op=27,a=435,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=654},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=652},
  {op=1,a=433,bx=655},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=436,bx=304},
  {op=10,a=436,b=436,c=305},
  {op=27,a=436,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=437,bx=304},
  {op=10,a=437,b=437,c=305},
  {op=27,a=437,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=656},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=657},
  {op=1,a=433,bx=658},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=438,bx=304},
  {op=10,a=438,b=438,c=305},
  {op=27,a=438,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=439,bx=304},
  {op=10,a=439,b=439,c=305},
  {op=27,a=439,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=659},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=652},
  {op=1,a=433,bx=660},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=440,bx=304},
  {op=10,a=440,b=440,c=305},
  {op=27,a=440,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=441,bx=304},
  {op=10,a=441,b=441,c=305},
  {op=27,a=441,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=661},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=662},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=442,bx=304},
  {op=10,a=442,b=442,c=305},
  {op=27,a=442,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=443,bx=304},
  {op=10,a=443,b=443,c=305},
  {op=27,a=443,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=663},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=664},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=444,bx=304},
  {op=10,a=444,b=444,c=305},
  {op=27,a=444,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=445,bx=304},
  {op=10,a=445,b=445,c=305},
  {op=27,a=445,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=665},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=666},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=446,bx=304},
  {op=10,a=446,b=446,c=305},
  {op=27,a=446,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=447,bx=304},
  {op=10,a=447,b=447,c=305},
  {op=27,a=447,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=667},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=668},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=448,bx=304},
  {op=10,a=448,b=448,c=305},
  {op=27,a=448,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=449,bx=304},
  {op=10,a=449,b=449,c=305},
  {op=27,a=449,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=669},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=657},
  {op=1,a=433,bx=670},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=450,bx=304},
  {op=10,a=450,b=450,c=305},
  {op=27,a=450,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=451,bx=304},
  {op=10,a=451,b=451,c=305},
  {op=27,a=451,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=671},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=672},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=452,bx=304},
  {op=10,a=452,b=452,c=305},
  {op=27,a=452,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=453,bx=304},
  {op=10,a=453,b=453,c=305},
  {op=27,a=453,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=673},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=674},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=454,bx=304},
  {op=10,a=454,b=454,c=305},
  {op=27,a=454,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=455,bx=304},
  {op=10,a=455,b=455,c=305},
  {op=27,a=455,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=675},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=676},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=456,bx=304},
  {op=10,a=456,b=456,c=305},
  {op=27,a=456,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=457,bx=304},
  {op=10,a=457,b=457,c=305},
  {op=27,a=457,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=677},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=678},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=458,bx=304},
  {op=10,a=458,b=458,c=305},
  {op=27,a=458,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=459,bx=304},
  {op=10,a=459,b=459,c=305},
  {op=27,a=459,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=679},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=680},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=460,bx=304},
  {op=10,a=460,b=460,c=305},
  {op=27,a=460,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=461,bx=304},
  {op=10,a=461,b=461,c=305},
  {op=27,a=461,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=681},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=682},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=462,bx=304},
  {op=10,a=462,b=462,c=305},
  {op=27,a=462,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=463,bx=304},
  {op=10,a=463,b=463,c=305},
  {op=27,a=463,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=683},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=652},
  {op=1,a=433,bx=684},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=464,bx=304},
  {op=10,a=464,b=464,c=305},
  {op=27,a=464,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=465,bx=304},
  {op=10,a=465,b=465,c=305},
  {op=27,a=465,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=685},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=433,bx=686},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=466,bx=304},
  {op=10,a=466,b=466,c=305},
  {op=27,a=466,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=687},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=467,bx=304},
  {op=10,a=467,b=467,c=305},
  {op=27,a=467,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=688},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=689},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=437,bx=304},
  {op=10,a=437,b=437,c=305},
  {op=27,a=437,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=468,bx=304},
  {op=10,a=468,b=468,c=305},
  {op=27,a=468,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=690},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=652},
  {op=1,a=433,bx=691},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=469,bx=304},
  {op=10,a=469,b=469,c=305},
  {op=27,a=469,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=470,bx=304},
  {op=10,a=470,b=470,c=305},
  {op=27,a=470,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=692},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=693},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=471,bx=304},
  {op=10,a=471,b=471,c=305},
  {op=27,a=471,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=472,bx=304},
  {op=10,a=472,b=472,c=305},
  {op=27,a=472,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=694},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=695},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=473,bx=304},
  {op=10,a=473,b=473,c=305},
  {op=27,a=473,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=474,bx=304},
  {op=10,a=474,b=474,c=305},
  {op=27,a=474,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=696},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=697},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=475,bx=304},
  {op=10,a=475,b=475,c=305},
  {op=27,a=475,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=476,bx=304},
  {op=10,a=476,b=476,c=305},
  {op=27,a=476,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=698},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=657},
  {op=1,a=433,bx=699},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=477,bx=304},
  {op=10,a=477,b=477,c=305},
  {op=27,a=477,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=478,bx=304},
  {op=10,a=478,b=478,c=305},
  {op=27,a=478,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=700},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=701},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=479,bx=304},
  {op=10,a=479,b=479,c=305},
  {op=27,a=479,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=480,bx=304},
  {op=10,a=480,b=480,c=305},
  {op=27,a=480,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=702},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=703},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=481,bx=304},
  {op=10,a=481,b=481,c=305},
  {op=27,a=481,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=482,bx=304},
  {op=10,a=482,b=482,c=305},
  {op=27,a=482,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=704},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=705},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=483,bx=304},
  {op=10,a=483,b=483,c=305},
  {op=27,a=483,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=484,bx=304},
  {op=10,a=484,b=484,c=305},
  {op=27,a=484,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=706},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=707},
  {op=1,a=433,bx=708},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=118,bx=304},
  {op=10,a=118,b=118,c=305},
  {op=27,a=118,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=485,bx=304},
  {op=10,a=485,b=485,c=305},
  {op=27,a=485,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=709},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=707},
  {op=1,a=433,bx=710},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=486,bx=304},
  {op=10,a=486,b=486,c=305},
  {op=27,a=486,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=487,bx=304},
  {op=10,a=487,b=487,c=305},
  {op=27,a=487,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=711},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=712},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=488,bx=304},
  {op=10,a=488,b=488,c=305},
  {op=27,a=488,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=489,bx=304},
  {op=10,a=489,b=489,c=305},
  {op=27,a=489,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=713},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=714},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=465,bx=304},
  {op=10,a=465,b=465,c=305},
  {op=27,a=465,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=490,bx=304},
  {op=10,a=490,b=490,c=305},
  {op=27,a=490,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=715},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=707},
  {op=1,a=433,bx=716},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=491,bx=304},
  {op=10,a=491,b=491,c=305},
  {op=27,a=491,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=492,bx=304},
  {op=10,a=492,b=492,c=305},
  {op=27,a=492,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=717},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=707},
  {op=1,a=433,bx=718},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=493,bx=304},
  {op=10,a=493,b=493,c=305},
  {op=27,a=493,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=494,bx=304},
  {op=10,a=494,b=494,c=305},
  {op=27,a=494,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=719},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=657},
  {op=1,a=433,bx=720},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=495,bx=304},
  {op=10,a=495,b=495,c=305},
  {op=27,a=495,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=496,bx=304},
  {op=10,a=496,b=496,c=305},
  {op=27,a=496,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=721},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=722},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=497,bx=304},
  {op=10,a=497,b=497,c=305},
  {op=27,a=497,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=498,bx=304},
  {op=10,a=498,b=498,c=305},
  {op=27,a=498,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=723},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=724},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=499,bx=304},
  {op=10,a=499,b=499,c=305},
  {op=27,a=499,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=500,bx=304},
  {op=10,a=500,b=500,c=305},
  {op=27,a=500,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=725},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=726},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=501,bx=304},
  {op=10,a=501,b=501,c=305},
  {op=27,a=501,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=502,bx=304},
  {op=10,a=502,b=502,c=305},
  {op=27,a=502,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=727},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=728},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=503,bx=304},
  {op=10,a=503,b=503,c=305},
  {op=27,a=503,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=504,bx=304},
  {op=10,a=504,b=504,c=305},
  {op=27,a=504,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=729},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=433,bx=730},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=505,bx=304},
  {op=10,a=505,b=505,c=305},
  {op=27,a=505,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=731},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=506,bx=304},
  {op=10,a=506,b=506,c=305},
  {op=27,a=506,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=732},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=733},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=507,bx=304},
  {op=10,a=507,b=507,c=305},
  {op=27,a=507,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=508,bx=304},
  {op=10,a=508,b=508,c=305},
  {op=27,a=508,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=734},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=735},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=509,bx=304},
  {op=10,a=509,b=509,c=305},
  {op=27,a=509,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=510,bx=304},
  {op=10,a=510,b=510,c=305},
  {op=27,a=510,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=736},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=737},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=511,bx=304},
  {op=10,a=511,b=511,c=305},
  {op=27,a=511,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=512,bx=304},
  {op=10,a=512,b=512,c=305},
  {op=27,a=512,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=738},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=707},
  {op=1,a=433,bx=739},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=513,bx=304},
  {op=10,a=513,b=513,c=305},
  {op=27,a=513,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=514,bx=304},
  {op=10,a=514,b=514,c=305},
  {op=27,a=514,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=740},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=433,bx=741},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=515,bx=304},
  {op=10,a=515,b=515,c=305},
  {op=27,a=515,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  -- RAW: task.spawn(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=9,a=516,b=0,c=0},
  -- RAW: "\232\174\173\231\187\131\231\130\185\229\177\143",
  -- RAW: {}
  -- RAW: }
  {op=5,a=517,bx=355},
  {op=10,a=517,b=517,c=370},
  {op=27,a=517,b=3,c=1},
  -- RAW: end)
  -- RAW: task.wait(0.1)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=518,bx=304},
  {op=10,a=518,b=518,c=305},
  {op=27,a=518,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=742},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=743},
  {op=1,a=433,bx=744},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=519,bx=304},
  {op=10,a=519,b=519,c=305},
  {op=27,a=519,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=520,bx=304},
  {op=10,a=520,b=520,c=305},
  {op=27,a=520,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=745},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=746},
  {op=1,a=433,bx=747},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=521,bx=304},
  {op=10,a=521,b=521,c=305},
  {op=27,a=521,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=522,bx=304},
  {op=10,a=522,b=522,c=305},
  {op=27,a=522,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=748},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=749},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=523,bx=304},
  {op=10,a=523,b=523,c=305},
  {op=27,a=523,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=524,bx=304},
  {op=10,a=524,b=524,c=305},
  {op=27,a=524,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=750},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=707},
  {op=1,a=433,bx=751},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=525,bx=304},
  {op=10,a=525,b=525,c=305},
  {op=27,a=525,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=526,bx=304},
  {op=10,a=526,b=526,c=305},
  {op=27,a=526,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=752},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=231,bx=753},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=527,bx=304},
  {op=10,a=527,b=527,c=305},
  {op=27,a=527,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[url] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=528,bx=304},
  {op=10,a=528,b=528,c=305},
  {op=27,a=528,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TsbSection:AddButton({
  {op=1,a=178,bx=754},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=433,bx=755},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=529,bx=304},
  {op=10,a=529,b=529,c=305},
  {op=27,a=529,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[key] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=756},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=530,bx=304},
  {op=10,a=530,b=530,c=305},
  {op=27,a=530,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 标签页 9：ESP
  -- -------------------------------------------------
  {op=1,a=531,bx=757},
  {op=1,a=532,bx=758},
  -- 
  {op=2,a=533,b=0,c=0},
  -- RAW: MasterSection:AddToggle({
  {op=1,a=178,bx=759},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=0,a=533,b=400},
  {op=6,a=533,bx=760},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.Enabled = state
  {op=5,a=534,bx=304},
  {op=10,a=534,b=534,c=305},
  {op=27,a=534,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=535,bx=304},
  {op=10,a=535,b=535,c=305},
  {op=27,a=535,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: MasterSection:AddButton({
  {op=1,a=178,bx=761},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=536,bx=304},
  {op=10,a=536,b=536,c=305},
  {op=27,a=536,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=537,bx=304},
  {op=10,a=537,b=537,c=305},
  {op=27,a=537,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=538,bx=762},
  -- 
  -- RAW: BoxSection:AddToggle({
  {op=1,a=178,bx=763},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.BoxESP = state
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: BoxSection:AddDropdown({
  {op=1,a=178,bx=764},
  {op=6,a=178,bx=272},
  {op=1,a=285,bx=765},
  {op=6,a=285,bx=449},
  {op=1,a=179,bx=766},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=450},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.BoxStyle = option
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: BoxSection:AddSlider({
  {op=1,a=178,bx=767},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=148},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=768},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=148},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.BoxThickness = value
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: BoxSection:AddToggle({
  {op=1,a=178,bx=769},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.BoxFilled = state
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: BoxSection:AddSlider({
  {op=1,a=178,bx=770},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=140},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=307},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=771},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.BoxFillTransparency = value / 100
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: BoxSection:AddSlider({
  {op=1,a=178,bx=772},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=140},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=280},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=213},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.CornerLength = value / 100
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=539,bx=773},
  -- 
  -- RAW: TracerSection:AddToggle({
  {op=1,a=178,bx=774},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.TracerESP = state
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TracerSection:AddDropdown({
  {op=1,a=178,bx=775},
  {op=6,a=178,bx=272},
  {op=1,a=285,bx=776},
  {op=6,a=285,bx=449},
  {op=1,a=179,bx=777},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=450},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.TracerOrigin = option
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=540,bx=778},
  -- 
  -- RAW: HealthSection:AddToggle({
  {op=1,a=178,bx=779},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.HealthESP = state
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: HealthSection:AddDropdown({
  {op=1,a=178,bx=780},
  {op=6,a=178,bx=272},
  {op=1,a=285,bx=781},
  {op=6,a=285,bx=449},
  {op=1,a=179,bx=782},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=450},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.HealthStyle = option
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=541,bx=783},
  -- 
  -- RAW: InfoSection2:AddToggle({
  {op=1,a=178,bx=784},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.NameESP = state
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: InfoSection2:AddToggle({
  {op=1,a=178,bx=785},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.ShowDistance = state
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: InfoSection2:AddSlider({
  {op=1,a=178,bx=786},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=787},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=286},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=788},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.TextSize = value
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=542,bx=789},
  -- 
  -- RAW: ChamsSection:AddToggle({
  {op=1,a=178,bx=790},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.ChamsEnabled = state
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: ChamsSection:AddSlider({
  {op=1,a=178,bx=791},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=140},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=307},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=280},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.ChamsTransparency = value / 100
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=1,a=543,bx=792},
  -- 
  -- RAW: TeamSection:AddToggle({
  {op=1,a=178,bx=793},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.TeamCheck = state
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TeamSection:AddToggle({
  {op=1,a=178,bx=794},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.ShowTeam = state
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: TeamSection:AddSlider({
  {op=1,a=178,bx=795},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=307},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=796},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=797},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=280},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Neuro.ESP.MaxDistance = value
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- NPC ESP 板块（优化版）
  -- -------------------------------------------------
  {op=1,a=544,bx=798},
  -- 
  {op=2,a=545,b=0,c=0},
  {op=3,a=546,b=0},
  {op=1,a=547,bx=799},
  -- 
  -- RAW: local function ApplyNPCESP(target)
  -- RAW: if not target or not target:IsA("Model") then return end
  -- RAW: if target:FindFirstChild(NPCHighlightName) then return end
  -- RAW: if not target:FindFirstChildOfClass("Humanoid") then return end
  -- RAW: if game.Players:GetPlayerFromCharacter(target) then return end
  -- 
  {op=1,a=548,bx=800},
  -- RAW: highlight.Name = NPCHighlightName
  -- RAW: highlight.FillColor = Color3.fromRGB(0, 255, 0)
  -- RAW: highlight.FillTransparency = 0.5
  -- RAW: highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
  -- RAW: highlight.OutlineTransparency = 0
  -- RAW: highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  -- RAW: highlight.Parent = target
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function ClearAllNPCESP()
  -- RAW: for _, v in pairs(workspace:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=801},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function ScanAndApplyNPCESP()
  -- RAW: if not NPCESPEnabled then return end
  -- RAW: for _, v in pairs(workspace:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=802},
  {op=1,a=1,bx=803},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: NpcSection:AddToggle({
  {op=1,a=178,bx=804},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=0,a=545,b=400},
  {op=6,a=545,bx=805},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=806},
  {op=27,a=0,b=1,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=807},
  {op=27,a=0,b=2,c=1},
  {op=1,a=546,bx=123},
  {op=6,a=546,bx=808},
  {op=29,a=0,b=1},
  {op=1,a=546,bx=809},
  {op=6,a=546,bx=808},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: task.wait(2)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=806},
  {op=27,a=0,b=1,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=549,bx=304},
  {op=10,a=549,b=549,c=305},
  {op=27,a=549,b=3,c=1},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=807},
  {op=27,a=0,b=2,c=1},
  {op=1,a=546,bx=123},
  {op=6,a=546,bx=808},
  {op=29,a=0,b=1},
  {op=5,a=0,bx=810},
  {op=27,a=0,b=1,c=1},
  {op=5,a=550,bx=304},
  {op=10,a=550,b=550,c=305},
  {op=27,a=550,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: NpcSection:AddButton({
  {op=1,a=178,bx=811},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=806},
  {op=27,a=0,b=1,c=1},
  {op=5,a=551,bx=304},
  {op=10,a=551,b=551,c=305},
  {op=27,a=551,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=552,bx=304},
  {op=10,a=552,b=552,c=305},
  {op=27,a=552,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: NpcSection:AddButton({
  {op=1,a=178,bx=812},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=810},
  {op=27,a=0,b=1,c=1},
  {op=5,a=553,bx=304},
  {op=10,a=553,b=553,c=305},
  {op=27,a=553,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 标签页：额外功能
  -- -------------------------------------------------
  {op=1,a=554,bx=813},
  -- 
  -- -- ===== 战斗相关 =====
  {op=1,a=555,bx=814},
  -- 
  {op=2,a=556,b=0,c=0},
  {op=3,a=557,b=0},
  -- 
  -- RAW: CombatSection:AddToggle({
  {op=1,a=178,bx=815},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=0,a=556,b=400},
  {op=6,a=556,bx=816},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=558,bx=817},
  {op=10,a=558,b=558,c=306},
  {op=27,a=558,b=2,c=1},
  {op=1,a=557,bx=123},
  {op=6,a=557,bx=817},
  {op=29,a=0,b=1},
  {op=1,a=557,bx=508},
  {op=6,a=557,bx=817},
  -- RAW: if not AutoAttackEnabled then return end
  {op=1,a=3,bx=299},
  {op=1,a=185,bx=542},
  -- RAW: if not char then return end
  {op=1,a=187,bx=302},
  -- RAW: if not hum or hum.Health <= 0 then return end
  -- 
  {op=1,a=228,bx=818},
  -- RAW: if not tool then return end
  {op=1,a=559,bx=819},
  -- RAW: if not handle then return end
  -- 
  {op=1,a=560,bx=820},
  -- RAW: if not touch then return end
  -- 
  {op=9,a=561,b=0,c=0},
  -- RAW: for _, p in pairs(game.Players:GetPlayers()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: table.insert(otherChars, p.Character)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: if #otherChars == 0 then return end
  -- 
  {op=1,a=562,bx=821},
  -- RAW: params.FilterType = Enum.RaycastFilterType.Include
  -- RAW: params.FilterDescendantsInstances = otherChars
  -- 
  {op=1,a=563,bx=822},
  -- RAW: for _, part in pairs(parts) do
  {op=1,a=564,bx=823},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=565,bx=824},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=566,bx=825},
  {op=10,a=566,b=566,c=826},
  {op=27,a=566,b=2,c=1},
  {op=5,a=0,bx=827},
  {op=1,a=1,bx=828},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=827},
  {op=1,a=1,bx=829},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=567,bx=304},
  {op=10,a=567,b=567,c=305},
  {op=27,a=567,b=3,c=1},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=568,bx=817},
  {op=10,a=568,b=568,c=306},
  {op=27,a=568,b=2,c=1},
  {op=1,a=557,bx=123},
  {op=6,a=557,bx=817},
  {op=29,a=0,b=1},
  {op=5,a=569,bx=304},
  {op=10,a=569,b=569,c=305},
  {op=27,a=569,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: CombatSection:AddButton({
  {op=1,a=178,bx=830},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=831},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=570,bx=304},
  {op=10,a=570,b=570,c=305},
  {op=27,a=570,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: CombatSection:AddButton({
  {op=1,a=178,bx=832},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=833},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=571,bx=304},
  {op=10,a=571,b=571,c=305},
  {op=27,a=571,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: CombatSection:AddButton({
  {op=1,a=178,bx=834},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=835},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=572,bx=304},
  {op=10,a=572,b=572,c=305},
  {op=27,a=572,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: CombatSection:AddButton({
  {op=1,a=178,bx=836},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=837},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=573,bx=304},
  {op=10,a=573,b=573,c=305},
  {op=27,a=573,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- ===== 角色相关 =====
  {op=1,a=574,bx=838},
  -- 
  -- RAW: CharSection:AddButton({
  {op=1,a=178,bx=839},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=840},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=575,bx=304},
  {op=10,a=575,b=575,c=305},
  {op=27,a=575,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- ===== 道具管理 =====
  {op=1,a=576,bx=841},
  -- 
  -- RAW: ToolSection2:AddButton({
  {op=1,a=178,bx=842},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=843},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=577,bx=304},
  {op=10,a=577,b=577,c=305},
  {op=27,a=577,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: ToolSection2:AddButton({
  {op=1,a=178,bx=844},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=845},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=578,bx=304},
  {op=10,a=578,b=578,c=305},
  {op=27,a=578,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: ToolSection2:AddButton({
  {op=1,a=178,bx=846},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=847},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=579,bx=304},
  {op=10,a=579,b=579,c=305},
  {op=27,a=579,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: ToolSection2:AddButton({
  {op=1,a=178,bx=848},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=849},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=580,bx=304},
  {op=10,a=580,b=580,c=305},
  {op=27,a=580,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=2,a=581,b=0,c=0},
  {op=3,a=582,b=0},
  -- 
  -- RAW: ToolSection2:AddToggle({
  {op=1,a=178,bx=850},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=0,a=581,b=400},
  {op=6,a=581,bx=851},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=852},
  {op=27,a=0,b=2,c=1},
  {op=1,a=582,bx=123},
  {op=6,a=582,bx=853},
  {op=29,a=0,b=1},
  {op=1,a=582,bx=809},
  {op=6,a=582,bx=853},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, player in pairs(game.Players:GetPlayers()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, tool in pairs(player.Backpack:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: tool.Parent = game.Players.LocalPlayer.Backpack
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: task.wait(1)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=583,bx=304},
  {op=10,a=583,b=583,c=305},
  {op=27,a=583,b=3,c=1},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=852},
  {op=27,a=0,b=2,c=1},
  {op=1,a=582,bx=123},
  {op=6,a=582,bx=853},
  {op=29,a=0,b=1},
  {op=5,a=584,bx=304},
  {op=10,a=584,b=584,c=305},
  {op=27,a=584,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- ===== 实用工具 =====
  {op=1,a=585,bx=854},
  -- 
  -- RAW: UtilSection3:AddButton({
  {op=1,a=178,bx=855},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=856},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=586,bx=304},
  {op=10,a=586,b=586,c=305},
  {op=27,a=586,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: UtilSection3:AddButton({
  {op=1,a=178,bx=857},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=858},
  {op=27,a=0,b=1,c=1},
  -- RAW: end)
  {op=5,a=587,bx=304},
  {op=10,a=587,b=587,c=305},
  {op=27,a=587,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: UtilSection3:AddButton({
  {op=1,a=178,bx=859},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=860},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=588,bx=304},
  {op=10,a=588,b=588,c=305},
  {op=27,a=588,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: UtilSection3:AddButton({
  {op=1,a=178,bx=861},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=862},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=589,bx=304},
  {op=10,a=589,b=589,c=305},
  {op=27,a=589,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -------------------------------------------------
  -- -- 让侧边栏可滚动
  -- -------------------------------------------------
  -- RAW: task.defer(function()
  {op=1,a=321,bx=863},
  -- RAW: if not ScreenGui then return end
  {op=1,a=590,bx=864},
  -- RAW: if not Main then return end
  {op=1,a=591,bx=865},
  -- RAW: if not TabList then return end
  -- 
  {op=1,a=592,bx=866},
  -- RAW: Scroll.Name = "TabScroll"
  -- RAW: Scroll.Size = UDim2.new(1, 0, 1, 0)
  -- RAW: Scroll.Position = UDim2.new(0, 0, 0, 0)
  -- RAW: Scroll.BackgroundTransparency = 1
  -- RAW: Scroll.BorderSizePixel = 0
  -- RAW: Scroll.ScrollBarThickness = 3
  -- RAW: Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
  -- RAW: Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
  -- RAW: Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
  -- RAW: Scroll.Parent = TabList
  -- 
  -- RAW: for _, child in ipairs(TabList:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: child.Parent = Scroll
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- -------------------------------------------------
  -- -- ===== 穿墙持续循环 =====
  -- -------------------------------------------------
  {op=5,a=593,bx=355},
  {op=10,a=593,b=593,c=370},
  {op=27,a=593,b=3,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=185,bx=322},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, part in pairs(char:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: part.CanCollide = false
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- -------------------------------------------------
  -- -- ===== Neuro ESP 完整模块 =====
  -- -------------------------------------------------
  -- RAW: getgenv().Neuro = getgenv().Neuro or {}
  {op=1,a=594,bx=867},
  -- RAW: Environment.ServiceConnections = Environment.ServiceConnections or {}
  -- 
  -- RAW: Environment.ESP = {
  {op=1,a=61,bx=49},
  {op=6,a=61,bx=106},
  {op=1,a=595,bx=74},
  {op=6,a=595,bx=868},
  {op=1,a=596,bx=766},
  {op=6,a=596,bx=869},
  {op=1,a=597,bx=148},
  {op=6,a=597,bx=870},
  {op=1,a=598,bx=49},
  {op=6,a=598,bx=871},
  {op=1,a=599,bx=872},
  {op=6,a=599,bx=873},
  {op=1,a=600,bx=874},
  {op=6,a=600,bx=875},
  {op=1,a=601,bx=74},
  {op=6,a=601,bx=876},
  {op=1,a=602,bx=777},
  {op=6,a=602,bx=877},
  {op=1,a=603,bx=74},
  {op=6,a=603,bx=878},
  {op=1,a=604,bx=782},
  {op=6,a=604,bx=879},
  {op=1,a=605,bx=74},
  {op=6,a=605,bx=880},
  {op=1,a=606,bx=74},
  {op=6,a=606,bx=881},
  {op=1,a=607,bx=788},
  {op=6,a=607,bx=882},
  {op=1,a=608,bx=49},
  {op=6,a=608,bx=883},
  {op=1,a=609,bx=884},
  {op=6,a=609,bx=885},
  {op=1,a=610,bx=886},
  {op=6,a=610,bx=887},
  {op=1,a=611,bx=87},
  {op=6,a=611,bx=888},
  {op=1,a=612,bx=140},
  {op=6,a=612,bx=889},
  {op=1,a=613,bx=74},
  {op=6,a=613,bx=890},
  {op=1,a=614,bx=49},
  {op=6,a=614,bx=891},
  {op=1,a=615,bx=796},
  {op=6,a=615,bx=892},
  {op=1,a=616,bx=893},
  {op=6,a=616,bx=894},
  {op=1,a=617,bx=884},
  {op=6,a=617,bx=895},
  {op=1,a=618,bx=140},
  {op=6,a=618,bx=896},
  {op=1,a=619,bx=49},
  {op=6,a=619,bx=897},
  -- RAW: }
  -- 
  {op=1,a=620,bx=898},
  {op=1,a=318,bx=485},
  {op=1,a=277,bx=109},
  {op=1,a=320,bx=440},
  {op=1,a=621,bx=172},
  -- 
  {op=9,a=622,b=0,c=0},
  {op=9,a=623,b=0,c=0},
  {op=9,a=624,b=0,c=0},
  {op=9,a=625,b=0,c=0},
  {op=9,a=626,b=0,c=0},
  {op=1,a=627,bx=899},
  -- 
  -- RAW: local function SafeSet(obj, prop, val)
  -- RAW: if obj == nil then return end
  {op=1,a=378,bx=900},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if d[prop] == val then return end
  -- RAW: d[prop] = val
  {op=21,sbx=0},
  -- RAW: lastProps[obj] = { [prop] = val }
  {op=29,a=0,b=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: obj.Color = val
  {op=21,sbx=0},
  -- RAW: obj[prop] = val
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function LerpColor(c1, c2, t)
  {op=1,a=150,bx=901},
  {op=1,a=18,bx=902},
  {op=1,a=381,bx=903},
  {op=1,a=0,bx=904},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function HealthColor(pct)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=905},
  {op=29,a=0,b=2},
  {op=21,sbx=0},
  {op=1,a=0,bx=906},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function GetPlayerColor(player)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=907},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=908},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: function Environment:IsSameTeam(player)
  -- RAW: if not ESP.TeamCheck then return false end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=909},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=910},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function MakeLine(color, thickness, transparency)
  {op=1,a=92,bx=911},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=913},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=914},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=915},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=916},
  {op=27,a=0,b=2,c=1},
  {op=0,a=0,b=92},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function MakeSquare(color, filled, thickness, transparency)
  {op=1,a=628,bx=917},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=918},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=919},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=920},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=921},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=922},
  {op=27,a=0,b=2,c=1},
  {op=0,a=0,b=628},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function MakeText(font, size, color)
  {op=1,a=629,bx=923},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=924},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=925},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=926},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=927},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=928},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=929},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=930},
  {op=27,a=0,b=2,c=1},
  {op=0,a=0,b=629},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function CreateESP(player)
  -- RAW: if player == LocalPlayer or Drawings.ESP[player] then return end
  -- 
  {op=1,a=548,bx=800},
  -- RAW: highlight.FillColor = ESP.ChamsFillColor
  -- RAW: highlight.OutlineColor = ESP.ChamsOutlineColor
  -- RAW: highlight.FillTransparency = ESP.ChamsTransparency
  -- RAW: highlight.OutlineTransparency = ESP.ChamsOutlineTransparency
  -- RAW: highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  -- RAW: highlight.Enabled = false
  -- RAW: Drawings.Highlights[player] = highlight
  -- 
  {op=9,a=630,b=0,c=0},
  -- RAW: local box, boxOutline = {}, {}
  -- RAW: for _, key in ipairs(boxKeys) do
  -- RAW: box[key] = MakeLine(Color3.fromRGB(255,255,255), 1, 1)
  -- RAW: boxOutline[key] = MakeLine(Color3.fromRGB(0,0,0), 3, 0.45)
  {op=29,a=0,b=1},
  -- RAW: box.Fill = MakeSquare(Color3.fromRGB(255,255,255), true, 0, 0.7)
  -- 
  {op=1,a=631,bx=931},
  {op=1,a=632,bx=932},
  -- 
  {op=9,a=633,b=0,c=0},
  {op=1,a=47,bx=933},
  {op=6,a=47,bx=82},
  {op=1,a=634,bx=934},
  {op=6,a=634,bx=935},
  {op=1,a=635,bx=936},
  {op=6,a=635,bx=937},
  {op=1,a=636,bx=938},
  {op=6,a=636,bx=939},
  {op=1,a=637,bx=940},
  {op=6,a=637,bx=941},
  {op=1,a=50,bx=942},
  {op=6,a=50,bx=88},
  -- RAW: }
  -- 
  {op=9,a=638,b=0,c=0},
  {op=1,a=178,bx=943},
  {op=6,a=178,bx=272},
  {op=1,a=639,bx=944},
  {op=6,a=639,bx=945},
  {op=1,a=640,bx=946},
  {op=6,a=640,bx=947},
  -- RAW: }
  -- 
  -- RAW: Drawings.ESP[player] = {
  {op=1,a=641,bx=948},
  {op=6,a=641,bx=949},
  {op=1,a=642,bx=950},
  {op=6,a=642,bx=951},
  -- RAW: }
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function RemoveESP(player)
  {op=1,a=643,bx=952},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, obj in pairs(esp.Box) do pcall(function() obj:Remove() end) end
  -- RAW: for _, obj in pairs(esp.BoxOutline) do pcall(function() obj:Remove() end) end
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=953},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=954},
  {op=27,a=0,b=2,c=1},
  -- RAW: for _, obj in pairs(esp.HealthBar) do pcall(function() obj:Remove() end) end
  -- RAW: for _, obj in pairs(esp.Info) do pcall(function() obj:Remove() end) end
  -- RAW: Drawings.ESP[player] = nil
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=955},
  {op=27,a=0,b=2,c=1},
  -- RAW: Drawings.Highlights[player] = nil
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function HideAll(esp, player)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, obj in pairs(esp.Box) do SafeSet(obj, "Visible", false) end
  -- RAW: for _, obj in pairs(esp.BoxOutline) do SafeSet(obj, "Visible", false) end
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=956},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=957},
  {op=27,a=0,b=2,c=1},
  -- RAW: for _, obj in pairs(esp.HealthBar) do SafeSet(obj, "Visible", false) end
  -- RAW: for _, obj in pairs(esp.Info) do SafeSet(obj, "Visible", false) end
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=958},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function UpdateESP(player)
  -- RAW: if not ESP.Enabled then return end
  {op=1,a=643,bx=952},
  -- RAW: if not esp then return end
  -- 
  {op=1,a=185,bx=300},
  -- RAW: if not char then HideAll(esp, player) return end
  -- 
  {op=1,a=186,bx=301},
  -- RAW: if not root then HideAll(esp, player) return end
  -- 
  {op=1,a=187,bx=302},
  -- RAW: if not hum or hum.Health <= 0 then HideAll(esp, player) return end
  -- 
  {op=1,a=132,bx=959},
  -- RAW: if dist > ESP.MaxDistance then HideAll(esp, player) return end
  -- 
  -- RAW: local posVec, onScreen = Camera:WorldToViewportPoint(root.Position)
  -- RAW: if not onScreen then HideAll(esp, player) return end
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=960},
  {op=1,a=1,bx=961},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=644,bx=962},
  {op=1,a=645,bx=963},
  {op=1,a=646,bx=964},
  -- 
  {op=1,a=647,bx=965},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=647,bx=966},
  {op=6,a=647,bx=385},
  -- RAW: sizeCache[player] = size
  {op=29,a=0,b=1},
  -- 
  {op=1,a=648,bx=967},
  {op=1,a=649,bx=968},
  {op=1,a=650,bx=969},
  -- 
  -- RAW: if top.Z <= 0 or bottom.Z <= 0 then HideAll(esp, player) return end
  -- 
  {op=1,a=175,bx=970},
  -- RAW: if h <= 2 then HideAll(esp, player) return end
  -- 
  {op=1,a=174,bx=971},
  {op=1,a=651,bx=972},
  {op=1,a=652,bx=973},
  {op=0,a=653,b=174},
  {op=0,a=654,b=175},
  -- 
  -- RAW: for _, obj in pairs(esp.Box) do SafeSet(obj, "Visible", false) end
  -- RAW: for _, obj in pairs(esp.BoxOutline) do SafeSet(obj, "Visible", false) end
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=655,bx=974},
  {op=1,a=656,bx=975},
  {op=1,a=657,bx=976},
  {op=1,a=658,bx=977},
  {op=1,a=659,bx=978},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=660,bx=979},
  {op=1,a=661,bx=980},
  {op=1,a=662,bx=981},
  -- 
  -- RAW: local function dL(line, f, t, col, th, al)
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=982},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=983},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=984},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=985},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=986},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=987},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=989},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=990},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=991},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=992},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=993},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=994},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=995},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=996},
  {op=27,a=0,b=2,c=1},
  -- 
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=997},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=998},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=999},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1000},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1001},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1002},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1003},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1004},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=1,a=662,bx=981},
  -- RAW: local function dL(line, f, t, col, th, al)
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=982},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=983},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=984},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=985},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=986},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=987},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1005},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1006},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1007},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1008},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1009},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1010},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1011},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=988},
  {op=1,a=1,bx=1012},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1013},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1014},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1015},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1016},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1017},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1018},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=663,bx=1019},
  {op=1,a=664,bx=1020},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1021},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1022},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1023},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1024},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1025},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1026},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1027},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1028},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1029},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1030},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1031},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1032},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=956},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=957},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=665,bx=326},
  {op=1,a=666,bx=1033},
  {op=0,a=667,b=652},
  {op=0,a=668,b=654},
  {op=1,a=669,bx=1034},
  {op=1,a=670,bx=1035},
  -- 
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1036},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1037},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1038},
  {op=27,a=0,b=2,c=1},
  -- 
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1039},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1040},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1041},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1042},
  {op=27,a=0,b=2,c=1},
  -- 
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1043},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1044},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1045},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1046},
  {op=27,a=0,b=2,c=1},
  -- 
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1047},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1048},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1049},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1050},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1051},
  {op=27,a=0,b=2,c=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1052},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1053},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1054},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1055},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1056},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1057},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1058},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  -- RAW: for _, obj in pairs(esp.HealthBar) do SafeSet(obj, "Visible", false) end
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=671,bx=1059},
  {op=1,a=672,bx=1060},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1061},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1062},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1063},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1064},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1065},
  {op=27,a=0,b=2,c=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1066},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1067},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1068},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1069},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1070},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1071},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=673,bx=32},
  -- RAW: for _, child in ipairs(char:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=673,bx=1072},
  {op=6,a=673,bx=1073},
  -- RAW: break
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1074},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1075},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1076},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1077},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1078},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1079},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1080},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1071},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=912},
  {op=1,a=1,bx=1079},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=674,bx=1081},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: hl.Parent = char
  -- RAW: hl.FillColor = ESP.ChamsFillColor or color
  -- RAW: hl.OutlineColor = ESP.ChamsOutlineColor or Color3.fromRGB(255,255,255)
  -- RAW: hl.FillTransparency = ESP.ChamsTransparency or 0.5
  -- RAW: hl.OutlineTransparency = ESP.ChamsOutlineTransparency or 0
  -- RAW: hl.Enabled = true
  {op=21,sbx=0},
  -- RAW: hl.Enabled = false
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=675,bx=140},
  {op=2,a=676,b=0,c=0},
  -- 
  -- RAW: function Environment:ESPConnect()
  -- RAW: for _, key in ipairs({"ESPRenderStepped", "ESPPlayerAdded", "ESPPlayerRemoving"}) do
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: Environment.ServiceConnections[key]:Disconnect()
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: Environment.ServiceConnections.ESPRenderStepped = RunService.RenderStepped:Connect(function()
  {op=1,a=621,bx=172},
  {op=6,a=621,bx=1082},
  {op=1,a=677,bx=1083},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, player in ipairs(Players:GetPlayers()) do
  {op=1,a=643,bx=952},
  -- RAW: if esp then HideAll(esp, player) end
  {op=29,a=0,b=1},
  {op=1,a=676,bx=10},
  {op=6,a=676,bx=1084},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=676,bx=40},
  {op=6,a=676,bx=1084},
  -- 
  {op=1,a=678,bx=415},
  -- RAW: if now - lastUpdate < (ESP.RefreshRate or 0) then return end
  {op=0,a=675,b=678},
  {op=6,a=675,bx=1085},
  -- 
  -- RAW: for _, player in ipairs(Players:GetPlayers()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=1086},
  {op=0,a=1,b=76},
  {op=27,a=0,b=2,c=1},
  -- RAW: retryAt[player] = now + 2
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=5,a=0,bx=1087},
  {op=0,a=1,b=76},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- RAW: Environment.ServiceConnections.ESPPlayerAdded = Players.PlayerAdded:Connect(function(player)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=1086},
  {op=0,a=1,b=76},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- RAW: Environment.ServiceConnections.ESPPlayerRemoving = Players.PlayerRemoving:Connect(function(player)
  {op=5,a=0,bx=1088},
  {op=0,a=1,b=76},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  {op=5,a=679,bx=1089},
  {op=10,a=679,b=679,c=1090},
  {op=27,a=679,b=2,c=1},
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=1091},
  {op=27,a=0,b=2,c=1},
  -- 
  -- -------------------------------------------------
  -- -- 静默自瞄 Pro：Universal Pro v4.3 引擎原样（不改逻辑），仅由下方 UI 控制 _G
  -- -------------------------------------------------
  -- RAW: getgenv().WuSilentAimEngineLoaded = false
  -- RAW: do
  -- RAW: local ok, err = pcall(function()
  -- --[[
  -- RAW: 🎯 UNIVERSAL PRO SCRIPT v4.3 (DISTANCE LIMIT + FRIEND CHECK + ADONIS BYPASS)
  -- RAW: Versão: 4.3
  -- RAW: Base: v3.5 (Silent Aim + ESP Pro + Bullet Teleport)
  -- RAW: Features: Silent Aim, ESP Pro, Bullet Teleport, Friend Check, Adonis Bypass, Distance Limit
  -- RAW: Compatibilidade: PC & Mobile
  -- RAW: ]]
  -- 
  -- --// ==================================================
  -- --// 1. CONFIGURAÇÕES GLOBAIS (SILENT AIM & ESP)
  -- --// ==================================================
  -- 
  -- -- [SILENT AIM CONFIGS]
  -- RAW: _G.SilentAim = false
  -- RAW: _G.FOV = 150
  -- RAW: _G.VisibleCheck = true
  -- RAW: _G.TeamCheck = true
  -- RAW: _G.TeamCheckForNPCs = false
  -- RAW: _G.DeadCheck = true            -- ✅ NOVO: Verificação de mortos
  -- RAW: _G.Prediction = 0.165
  -- RAW: _G.UpdateRate = 0.01
  -- RAW: _G.TargetMode = "NPCs"
  -- RAW: _G.AimPart = "Head"
  -- RAW: _G.ShowTarget = true
  -- RAW: _G.HitChance = 100
  -- RAW: _G.BulletTP = false
  -- RAW: _G.ShowTargetName = true
  -- RAW: _G.ShowTargetType = true
  -- RAW: _G.ShowTargetHP = true
  -- RAW: _G.ShowTargetDistance = true
  -- RAW: _G.ShowHitChance = true
  -- RAW: _G.HighlightTarget = false
  -- RAW: _G.HighlightNPCColor = Color3.fromRGB(255, 50, 50)
  -- RAW: _G.HighlightPlayerColor = Color3.fromRGB(50, 150, 255)
  -- RAW: _G.DebugNPCs = false
  -- RAW: _G.AggressiveNPCDetection = false
  -- RAW: _G.TargetPriority = "Distance"
  -- RAW: _G.StickyAim = true
  -- RAW: _G.FOVColor = Color3.fromRGB(0, 255, 0)
  -- 
  -- -- ═══════════════════════════════════════════════════════════════
  -- -- 🔥 NOVAS CONFIGURAÇÕES v4.3: FRIEND CHECK, ADONIS E DISTÂNCIA
  -- -- ═══════════════════════════════════════════════════════════════
  -- RAW: _G.FriendCheck = true           -- ✅ Ignorar amigos no Silent Aim
  -- RAW: _G.AdonisBypass = true          -- ✅ Bypass para Adonis Anti-Cheat
  -- RAW: _G.EnableDistanceLimit = true   -- ✅ Ativar limite de distância
  -- RAW: _G.MaxAimDistance = 500         -- ✅ Distância máxima para mirar (em studs)
  -- 
  -- -- [ESP CONFIGS]
  -- RAW: getgenv().ESP_Config = {
  {op=1,a=61,bx=49},
  {op=6,a=61,bx=106},
  {op=1,a=680,bx=74},
  {op=6,a=680,bx=1092},
  {op=1,a=681,bx=74},
  {op=6,a=681,bx=1093},
  {op=1,a=613,bx=74},
  {op=6,a=613,bx=890},
  {op=1,a=682,bx=1094},
  {op=6,a=682,bx=1095},
  {op=1,a=615,bx=1096},
  {op=6,a=615,bx=892},
  {op=1,a=683,bx=273},
  {op=6,a=683,bx=1097},
  {op=1,a=684,bx=788},
  {op=6,a=684,bx=1098},
  {op=1,a=685,bx=1099},
  {op=6,a=685,bx=1100},
  {op=1,a=686,bx=1101},
  {op=6,a=686,bx=1102},
  {op=1,a=687,bx=1103},
  {op=6,a=687,bx=1104},
  {op=1,a=688,bx=74},
  {op=6,a=688,bx=1105},
  {op=1,a=689,bx=74},
  {op=6,a=689,bx=1106},
  {op=1,a=690,bx=74},
  {op=6,a=690,bx=1107},
  {op=1,a=691,bx=74},
  {op=6,a=691,bx=1108},
  {op=1,a=606,bx=74},
  {op=6,a=606,bx=881},
  {op=1,a=692,bx=74},
  {op=6,a=692,bx=1109},
  {op=1,a=693,bx=74},
  {op=6,a=693,bx=1110},
  {op=1,a=694,bx=49},
  {op=6,a=694,bx=1111},
  {op=1,a=695,bx=74},
  {op=6,a=695,bx=1112},
  {op=1,a=617,bx=1113},
  {op=6,a=617,bx=895},
  {op=1,a=616,bx=1114},
  {op=6,a=616,bx=894},
  {op=1,a=696,bx=1115},
  {op=6,a=696,bx=1116},
  {op=1,a=697,bx=1117},
  {op=6,a=697,bx=1118},
  -- RAW: }
  -- 
  -- --// ==================================================
  -- --// 1.5 ANTI-KICK OTIMIZADO (SEM TRAVAMENTO) - MELHORADO
  -- --// ==================================================
  -- 
  {op=2,a=62,b=1,c=0},
  -- 
  -- RAW: task.spawn(function()
  -- RAW: if not AntiKickEnabled then return end
  -- 
  -- RAW: local function softAntiKick()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=63,bx=109},
  {op=1,a=3,bx=110},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=64,bx=111},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: lp.Kick = function() return nil end
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  {op=5,a=0,bx=112},
  {op=27,a=0,b=1,c=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=112},
  {op=27,a=0,b=1,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- --// ==================================================
  -- --// 1.6 BYPASS PARA ADONIS ANTI-CHEAT (NOVO)
  -- --// ==================================================
  -- 
  -- RAW: local function BypassAdonis()
  -- RAW: if not _G.AdonisBypass then return end
  -- 
  -- -- Detectar Adonis
  {op=2,a=66,b=0,c=0},
  -- RAW: for _, obj in pairs(game:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=66,bx=40},
  {op=6,a=66,bx=115},
  -- RAW: break
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- -- Verificar por RemoteEvents comuns do Adonis
  {op=9,a=67,b=0,c=0},
  -- RAW: "Adonis_Remote",
  -- RAW: "Adonis_AntiCheat",
  -- RAW: "Adonis_Check",
  -- RAW: "Adonis_Validate",
  -- RAW: "Adonis_Log",
  -- RAW: "Adonis_Event"
  -- RAW: }
  -- 
  -- RAW: for _, remoteName in pairs(remotes) do
  {op=1,a=68,bx=1119},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=66,bx=40},
  {op=6,a=66,bx=115},
  -- RAW: break
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=117},
  {op=27,a=0,b=2,c=1},
  -- 
  -- -- 1. Remover/ignorar detecção de ferramentas
  -- RAW: local function HijackToolCheck(original)
  {op=1,a=0,bx=1120},
  {op=29,a=0,b=2},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=1121},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- -- 2. Bypass para check de velocidade
  -- RAW: local function HijackVelocityCheck(original)
  {op=1,a=0,bx=1120},
  {op=29,a=0,b=2},
  {op=9,a=516,b=0,c=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: args[1] = args[1].Unit * 50
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=1122},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- -- 3. Hook nos RemoteEvents do Adonis
  -- RAW: for _, remoteName in pairs(remotes) do
  {op=1,a=68,bx=1119},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: remote.OnServerEvent:Connect(function(player, ...)
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- -- 4. Bypass para verificações de movimento
  {op=1,a=69,bx=118},
  {op=1,a=70,bx=119},
  {op=5,a=0,bx=120},
  {op=1,a=1,bx=121},
  {op=27,a=0,b=2,c=1},
  -- RAW: mt.__namecall = newcclosure(function(self, ...)
  {op=1,a=71,bx=122},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=72,bx=124},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=123},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=125},
  {op=29,a=0,b=2},
  -- RAW: end)
  {op=5,a=0,bx=120},
  {op=1,a=1,bx=126},
  {op=27,a=0,b=2,c=1},
  -- 
  -- -- 5. Limpar detecções automáticas
  -- RAW: task.spawn(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: getgenv().Adonis.Detected = false
  {op=29,a=0,b=1},
  -- 
  {op=1,a=73,bx=127},
  {op=1,a=74,bx=128},
  -- RAW: for _, log in pairs(logs) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: log.message = ""
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=130},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- -- Executar bypass
  -- RAW: task.spawn(function()
  -- RAW: task.wait(2)
  {op=5,a=0,bx=132},
  {op=27,a=0,b=1,c=1},
  -- RAW: end)
  -- 
  -- --// ==================================================
  -- --// 2. SERVIÇOS E VARIÁVEIS UNIFICADOS
  -- --// ==================================================
  {op=1,a=277,bx=109},
  {op=1,a=318,bx=485},
  {op=1,a=698,bx=570},
  {op=1,a=75,bx=134},
  {op=1,a=699,bx=1123},
  {op=1,a=65,bx=114},
  {op=1,a=700,bx=1124},
  {op=1,a=621,bx=172},
  {op=1,a=320,bx=440},
  {op=1,a=701,bx=1125},
  -- 
  -- --// VARIÁVEIS DO SILENT AIM
  {op=1,a=702,bx=1126},
  -- RAW: Circle.Color = _G.FOVColor
  -- RAW: Circle.Thickness = 2
  -- RAW: Circle.Visible = false
  -- RAW: Circle.Radius = _G.FOV
  -- RAW: Circle.Transparency = 0.7
  -- RAW: Circle.Filled = false
  -- 
  {op=1,a=703,bx=923},
  -- RAW: TargetInfo.Visible = false
  -- RAW: TargetInfo.Color = Color3.fromRGB(255, 255, 255)
  -- RAW: TargetInfo.Size = 18
  -- RAW: TargetInfo.Font = 2
  -- RAW: TargetInfo.Outline = true
  -- RAW: TargetInfo.OutlineColor = Color3.fromRGB(0, 0, 0)
  -- RAW: TargetInfo.Text = ""
  -- 
  {op=3,a=704,b=0},
  {op=3,a=705,b=0},
  -- 
  {op=3,a=706,b=0},
  {op=3,a=707,b=0},
  {op=2,a=708,b=0,c=0},
  {op=9,a=709,b=0,c=0},
  {op=9,a=710,b=0,c=0},
  {op=1,a=711,bx=140},
  {op=1,a=712,bx=326},
  -- 
  {op=3,a=70,b=0},
  {op=3,a=713,b=0},
  -- 
  -- --// VARIÁVEIS DO ESP
  {op=9,a=714,b=0,c=0},
  -- 
  -- --// ==================================================
  -- --// 3. FUNÇÕES DO SILENT AIM
  -- --// ==================================================
  -- 
  -- -- ✅ NOVA FUNÇÃO: Verificação de mortos (Dead Check)
  -- RAW: local function IsDead(character)
  -- RAW: if not character then return true end
  {op=1,a=715,bx=1127},
  -- RAW: if not humanoid then return true end
  -- 
  -- RAW: if humanoid.Health <= 0 then return true end
  -- RAW: if humanoid:GetState() == Enum.HumanoidStateType.Dead then return true end
  -- 
  {op=1,a=716,bx=1128},
  -- RAW: if bodyEffects and bodyEffects:FindFirstChild("K.O") and bodyEffects["K.O"].Value == true then return true end
  -- 
  {op=1,a=717,bx=1129},
  -- RAW: if ko and (ko:IsA("BoolValue") or ko:IsA("IntValue")) and (ko.Value == true or ko.Value > 0) then return true end
  -- 
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- -- ✅ NOVA FUNÇÃO: Verificar amigos (Friend Check)
  -- RAW: local function IsFriend(player)
  -- RAW: if not player then return false end
  -- RAW: if not LocalPlayer or not LocalPlayer:IsA("Player") then return false end
  -- 
  -- -- Verifica usando a API de amigos do Roblox
  -- RAW: local success, isFriend = pcall(function()
  {op=1,a=0,bx=1130},
  {op=29,a=0,b=2},
  -- RAW: end)
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- -- Verifica usando o sistema de amigos alternativo
  -- RAW: local success2, isFriend2 = pcall(function()
  {op=1,a=0,bx=1131},
  {op=29,a=0,b=2},
  -- RAW: end)
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function CreateHighlight(target)
  -- RAW: if not target or not target:IsA("Model") then return nil end
  -- RAW: if TargetHighlight then TargetHighlight:Destroy(); TargetHighlight = nil end
  -- RAW: if HighlightConnection then HighlightConnection:Disconnect(); HighlightConnection = nil end
  -- 
  {op=1,a=548,bx=800},
  -- RAW: highlight.Name = "SilentAimHighlight"
  -- RAW: highlight.Adornee = target
  -- RAW: highlight.FillColor = Color3.fromRGB(255, 50, 50)
  -- RAW: highlight.FillTransparency = 0.7
  -- RAW: highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
  -- RAW: highlight.OutlineTransparency = 0
  -- RAW: highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  -- RAW: highlight.Parent = game:GetService("CoreGui")
  -- 
  {op=1,a=705,bx=1132},
  {op=6,a=705,bx=1133},
  -- RAW: if highlight then highlight:Destroy(); TargetHighlight = nil end
  -- RAW: end)
  {op=0,a=0,b=548},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function UpdateHighlight()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if TargetHighlight then TargetHighlight:Destroy(); TargetHighlight = nil end
  -- RAW: if HighlightConnection then HighlightConnection:Disconnect(); HighlightConnection = nil end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if not TargetHighlight or TargetHighlight.Adornee ~= CurrentTarget then TargetHighlight = CreateHighlight(CurrentTarget) end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=2,a=718,b=0,c=0},
  -- RAW: for _, data in pairs(PlayerCache) do
  -- RAW: if data.Model == CurrentTarget then isPlayer = true; break end
  {op=29,a=0,b=1},
  -- 
  -- RAW: if isPlayer then TargetHighlight.FillColor = _G.HighlightPlayerColor
  -- RAW: else TargetHighlight.FillColor = _G.HighlightNPCColor end
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=719,bx=1134},
  -- RAW: TargetHighlight.FillTransparency = 0.7 + (0.2 * (1 - pulse))
  {op=21,sbx=0},
  -- RAW: TargetHighlight.FillTransparency = 0.7
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  -- RAW: if TargetHighlight then TargetHighlight:Destroy(); TargetHighlight = nil end
  -- RAW: if HighlightConnection then HighlightConnection:Disconnect(); HighlightConnection = nil end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function CleanupUIOnly()
  -- RAW: if Circle then Circle.Visible = false end
  -- RAW: if TargetInfo then TargetInfo.Visible = false; TargetInfo.Text = "" end
  -- RAW: if TargetHighlight then TargetHighlight:Destroy(); TargetHighlight = nil end
  -- RAW: if HighlightConnection then HighlightConnection:Disconnect(); HighlightConnection = nil end
  {op=1,a=706,bx=1135},
  {op=6,a=706,bx=1136},
  {op=29,a=0,b=1},
  -- 
  {op=9,a=720,b=0,c=0},
  -- RAW: "NPC", "Npc", "npc", "Enemy", "enemy", "Enemies", "enemies",
  -- RAW: "Hostile", "hostile", "Bad", "bad", "BadGuy", "badguy", "Foe", "foe", "Opponent", "opponent",
  -- RAW: "Bot", "bot", "Bots", "bots", "Mob", "mob", "Mobs", "mobs", "Monster", "monster", "Monsters", "monsters",
  -- RAW: "Zombie", "zombie", "Zombies", "zombies", "Creature", "creature", "Animal", "animal", "Beast", "beast",
  -- RAW: "Villain", "villain", "Villian", "villian", "Boss", "boss", "MiniBoss", "miniboss",
  -- RAW: "Guard", "guard", "Guardian", "guardian", "Soldier", "soldier", "Warrior", "warrior", "Fighter", "fighter",
  -- RAW: "Target", "target", "Dummy", "dummy", "Dummies", "dummies", "Practice", "practice", "Training", "training",
  -- RAW: "Skeleton", "skeleton", "Orc", "orc", "Goblin", "goblin", "Troll", "troll", "Ogre", "ogre",
  -- RAW: "Demon", "demon", "Devil", "devil", "Ghost", "ghost", "Spirit", "spirit", "Vampire", "vampire", "Werewolf", "werewolf",
  -- RAW: "Dragon", "dragon", "Wyvern", "wyvern", "Gang", "gang", "Thug", "thug", "Bandit", "bandit", "Raider", "raider",
  -- RAW: "Pirate", "pirate", "Corsair", "corsair", "Agent", "agent", "Assassin", "assassin",
  -- RAW: "Mercenary", "mercenary", "Hunter", "hunter", "Robot", "robot", "Drone", "drone",
  -- RAW: "Android", "android", "Cyborg", "cyborg", "Automaton", "automaton", "Servant", "servant", "Minion", "minion",
  -- RAW: "Slave", "slave", "Pawn", "pawn", "AI", "ai", "A.I.", "Char", "char", "Character", "character",
  -- RAW: "Model", "model", "Event", "event", "Special", "special", "Holiday", "holiday", "Seasonal", "seasonal"
  -- RAW: }
  -- 
  -- RAW: local function DebugNPCDetection(character, reason)
  -- RAW: if not _G.DebugNPCs then return end
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=1137},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function IsPlayer(character)
  -- RAW: if not character or not character:IsA("Model") then return false end
  -- RAW: if character == LocalPlayer.Character then return true end
  {op=1,a=76,bx=1138},
  {op=1,a=0,bx=1139},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function IsNPC(character)
  -- RAW: if not character or not character:IsA("Model") then return false end
  -- RAW: if IsPlayer(character) then return false end
  -- 
  {op=1,a=715,bx=1127},
  {op=1,a=721,bx=1140},
  {op=1,a=402,bx=1141},
  -- 
  -- RAW: if not humanoid or not head or not hrp then return false end
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=1142},
  {op=1,a=1,bx=1143},
  {op=27,a=0,b=2,c=1},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=722,bx=1144},
  -- 
  -- RAW: for _, tag in pairs(NPCTags) do
  -- RAW: if charName:find(tag:lower(), 1, true) then DebugNPCDetection(character, "Tag no nome: " .. tag); return true end
  {op=29,a=0,b=1},
  -- 
  {op=9,a=723,b=0,c=0},
  -- RAW: for _, folderName in pairs(npcFolders) do
  {op=1,a=724,bx=1145},
  -- RAW: if folder and character:IsDescendantOf(folder) then DebugNPCDetection(character, "Na pasta: " .. folderName); return true end
  {op=29,a=0,b=1},
  -- 
  {op=9,a=725,b=0,c=0},
  -- RAW: for _, indicator in pairs(possibleNPCIndicators) do
  {op=1,a=395,bx=1146},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: DebugNPCDetection(character, "BoolValue: " .. indicator .. " = true"); return true
  {op=21,sbx=0},
  {op=1,a=726,bx=1147},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: DebugNPCDetection(character, "StringValue: " .. indicator .. " = " .. value.Value); return true
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  -- RAW: DebugNPCDetection(character, "Team Value: " .. value.Value); return true
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=2,a=727,b=0,c=0},
  -- RAW: for _, child in pairs(character:GetChildren()) do
  {op=1,a=728,bx=1148},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=727,bx=1149},
  {op=6,a=727,bx=1150},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=729,bx=1151},
  -- RAW: for _, tag in pairs(tags) do
  {op=1,a=730,bx=1152},
  -- RAW: for _, npcTag in pairs(NPCTags) do
  -- RAW: if tagLower:find(npcTag:lower(), 1, true) then DebugNPCDetection(character, "CollectionService Tag: " .. tag); return true end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=9,a=731,b=0,c=0},
  -- RAW: for _, ability in pairs(npcAbilities) do
  -- RAW: if character:FindFirstChild(ability) or character:FindFirstChild(ability .. "Script") then hasAIBehavior = true; break end
  {op=29,a=0,b=1},
  -- 
  -- RAW: if hasAIBehavior then DebugNPCDetection(character, "Comportamento de IA detectado"); return true end
  -- 
  {op=9,a=732,b=0,c=0},
  -- RAW: for _, pattern in pairs(namePatterns) do
  -- RAW: if string.match(charName, pattern) then DebugNPCDetection(character, "Padrão no nome: " .. pattern); return true end
  {op=29,a=0,b=1},
  -- 
  {op=5,a=0,bx=1142},
  {op=1,a=1,bx=1153},
  {op=27,a=0,b=2,c=1},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function FindNPCsInWorkspaceRecursive(parent)
  {op=9,a=733,b=0,c=0},
  -- RAW: for _, child in pairs(parent:GetChildren()) do
  -- RAW: if child:IsA("Model") and IsNPC(child) then table.insert(foundNPCs, child) end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=734,bx=1154},
  -- RAW: for _, npc in pairs(subNPCs) do table.insert(foundNPCs, npc) end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=0,a=0,b=733},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- -- ✅ MODIFICADO: Verificação de inimigo com Friend Check
  -- RAW: local function IsEnemyPlayer(player)
  -- RAW: if not _G.TeamCheck then return true end
  -- RAW: if not player or not LocalPlayer.Team or not player.Team then return true end
  -- 
  -- -- ✅ Friend Check: Amigos não são considerados inimigos
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=0,bx=1155},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function IsEnemyNPC(npcModel)
  -- RAW: if not _G.TeamCheckForNPCs then return true end
  {op=1,a=735,bx=1156},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=736,bx=1157},
  {op=1,a=737,bx=1158},
  -- RAW: if npcTeam and localTeam and npcTeam ~= localTeam then return true end
  {op=29,a=0,b=1},
  {op=1,a=738,bx=1159},
  -- RAW: if isEnemy and isEnemy:IsA("BoolValue") and isEnemy.Value == true then return true end
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function GetTargetPart(character)
  -- RAW: if _G.AimPart == "Head" then return character:FindFirstChild("Head")
  -- RAW: elseif _G.AimPart == "Torso" then return character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart")
  {op=21,sbx=0},
  {op=9,a=563,b=0,c=0},
  -- RAW: for _, part in pairs(parts) do if part then return part end end
  {op=21,sbx=0},
  {op=1,a=721,bx=1140},
  {op=1,a=739,bx=1160},
  -- RAW: if head and torso then return tick() % 1 > 0.5 and head or torso elseif head then return head elseif torso then return torso end
  {op=29,a=0,b=1},
  {op=1,a=0,bx=1161},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function UpdateCaches()
  {op=1,a=740,bx=415},
  -- RAW: if currentTime - LastCacheUpdate < CacheUpdateInterval then return end
  {op=0,a=711,b=740},
  {op=6,a=711,bx=1162},
  -- 
  {op=9,a=741,b=0,c=0},
  {op=9,a=742,b=0,c=0},
  {op=9,a=743,b=0,c=0},
  -- 
  {op=1,a=744,bx=1163},
  -- RAW: for _, model in pairs(wsChildren) do
  -- RAW: if model:IsA("Model") and model ~= LocalPlayer.Character then table.insert(allModels, model) end
  {op=29,a=0,b=1},
  -- 
  {op=9,a=723,b=0,c=0},
  -- RAW: for _, folderName in pairs(npcFolders) do
  {op=1,a=724,bx=1145},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=745,bx=1164},
  -- RAW: for _, npc in pairs(npcsInFolder) do table.insert(allModels, npc) end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=746,bx=140},
  {op=1,a=747,bx=1165},
  -- RAW: for _, descendant in pairs(descendants) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: table.insert(allModels, descendant)
  {op=1,a=746,bx=1166},
  {op=6,a=746,bx=1167},
  -- RAW: if counter % 150 == 0 then task.wait() end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=748,bx=140},
  -- RAW: for _, model in pairs(allModels) do
  {op=1,a=748,bx=1168},
  {op=6,a=748,bx=1169},
  -- RAW: if processCounter % 200 == 0 then task.wait() end
  -- 
  {op=1,a=402,bx=1170},
  {op=1,a=715,bx=824},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- -- ✅ Dead Check: Verifica se está morto
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: tempPlayerCache[model] = {Model = model, HRP = hrp, Humanoid = humanoid, Player = Players:GetPlayerFromCharacter(model), IsNPC = false}
  {op=21,sbx=0},
  -- RAW: tempNPCCache[model] = {Model = model, HRP = hrp, Humanoid = humanoid, IsNPC = true}
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: for _, player in pairs(Players:GetPlayers()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=185,bx=300},
  {op=1,a=402,bx=301},
  {op=1,a=715,bx=302},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: tempPlayerCache[char] = {Model = char, HRP = hrp, Humanoid = humanoid, Player = player, IsNPC = false}
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=0,a=709,b=741},
  {op=6,a=709,bx=1171},
  {op=0,a=710,b=742},
  {op=6,a=710,bx=1172},
  {op=29,a=0,b=1},
  -- 
  -- -- ✅ MODIFICADO: Validação com Distance Limit
  -- RAW: local function ValidateCurrentTarget()
  -- RAW: if not CurrentTarget or not TargetPart then return false end
  {op=1,a=715,bx=1173},
  {op=1,a=402,bx=1174},
  -- 
  -- RAW: if not humanoid or not hrp then return false end
  -- RAW: if _G.DeadCheck and IsDead(CurrentTarget) then return false end
  -- 
  -- -- ✅ Distance Limit: Verifica distância máxima
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=749,bx=1175},
  {op=1,a=750,bx=1176},
  {op=1,a=751,bx=1177},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=752,bx=1178},
  {op=1,a=750,bx=1176},
  -- RAW: local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
  -- RAW: if not onScreen then return false end
  -- 
  {op=1,a=753,bx=1179},
  {op=1,a=132,bx=1180},
  -- RAW: if dist > _G.FOV then return false end
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=754,bx=596},
  -- RAW: raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
  -- RAW: raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
  -- RAW: raycastParams.IgnoreWater = true
  {op=1,a=755,bx=1181},
  {op=1,a=756,bx=1182},
  {op=1,a=757,bx=1183},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=758,bx=1184},
  -- RAW: if not hitPart:IsDescendantOf(CurrentTarget) then return false end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- -- ✅ MODIFICADO: Get Target com Distance Limit
  -- RAW: local function GetTarget()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=708,bx=1185},
  {op=6,a=708,bx=1186},
  {op=29,a=0,b=1},
  {op=5,a=0,bx=1187},
  {op=27,a=0,b=1,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if ValidateCurrentTarget() then TargetInRange = true; return CurrentTarget else CurrentTarget = nil; TargetPart = nil end
  {op=29,a=0,b=1},
  -- 
  {op=1,a=759,bx=1188},
  {op=3,a=760,b=0},
  {op=3,a=761,b=0},
  {op=1,a=752,bx=1178},
  {op=1,a=762,bx=1189},
  {op=1,a=763,bx=1190},
  -- 
  {op=1,a=708,bx=1191},
  {op=6,a=708,bx=1186},
  -- RAW: if not localRoot then return nil end
  -- 
  -- RAW: local function ProcessTarget(data, isPlayer)
  {op=1,a=402,bx=1192},
  {op=1,a=715,bx=1193},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if _G.DeadCheck and IsDead(data.Model) then return end
  -- 
  -- RAW: if isPlayer then if not IsEnemyPlayer(data.Player) then return end else if not IsEnemyNPC(data.Model) then return end end
  -- 
  -- -- ✅ Distance Limit: Verifica distância máxima
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=751,bx=1194},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=1195},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=764,bx=1196},
  -- RAW: if not targetPart then targetPart = hrp end
  -- 
  {op=1,a=750,bx=1197},
  -- RAW: if hrp.Velocity.Magnitude > 1 and _G.Prediction > 0 then targetPos = targetPos + (hrp.Velocity * _G.Prediction) end
  -- 
  -- RAW: local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=753,bx=1179},
  {op=1,a=765,bx=1180},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=2,a=766,b=1,c=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=754,bx=596},
  -- RAW: raycastParams.FilterDescendantsInstances = {localChar, Camera}
  -- RAW: raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
  -- RAW: raycastParams.IgnoreWater = true
  {op=1,a=755,bx=1181},
  {op=1,a=756,bx=1182},
  {op=1,a=757,bx=1183},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=758,bx=1184},
  -- RAW: if not hitPart:IsDescendantOf(data.Model) then isVisible = false end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=708,bx=40},
  {op=6,a=708,bx=1186},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=767,bx=140},
  -- RAW: if _G.TargetPriority == "Crosshair" then currentScore = distFromCenter
  -- RAW: elseif _G.TargetPriority == "Distance" then currentScore = (targetPos - localRoot.Position).Magnitude
  -- RAW: elseif _G.TargetPriority == "LowestHP" then currentScore = humanoid.Health
  -- RAW: else currentScore = distFromCenter end
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=0,a=759,b=767},
  {op=6,a=759,bx=1198},
  {op=0,a=760,b=764},
  {op=6,a=760,bx=1199},
  {op=1,a=761,bx=1200},
  {op=6,a=761,bx=1201},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: if _G.TargetMode == "NPCs" or _G.TargetMode == "Both" then for _, data in pairs(NPCCache) do ProcessTarget(data, false) end end
  -- RAW: if _G.TargetMode == "Players" or _G.TargetMode == "Both" then for _, data in pairs(PlayerCache) do ProcessTarget(data, true) end end
  -- 
  {op=0,a=707,b=760},
  {op=6,a=707,bx=1202},
  {op=0,a=0,b=761},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function ShouldHit()
  -- RAW: if _G.HitChance >= 100 then return true end
  -- RAW: if _G.HitChance <= 0 then return false end
  {op=1,a=768,bx=1203},
  {op=1,a=0,bx=1204},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function CalculateHitChanceDisplay()
  -- RAW: if not CurrentTarget or not TargetPart then return 0 end
  {op=1,a=769,bx=1205},
  {op=1,a=770,bx=148},
  {op=1,a=771,bx=148},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=749,bx=1175},
  {op=1,a=750,bx=1176},
  {op=1,a=751,bx=1177},
  -- RAW: if distance < 50 then distanceFactor = 1.1 elseif distance > 200 then distanceFactor = 0.8 end
  {op=29,a=0,b=1},
  -- 
  -- RAW: if _G.FOV < 100 then fovFactor = 1.15 elseif _G.FOV > 250 then fovFactor = 0.9 end
  {op=1,a=772,bx=1206},
  {op=1,a=773,bx=1207},
  {op=1,a=0,bx=1208},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function UpdateTargetInfo()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: TargetInfo.Visible = false; TargetInfo.Text = ""; return
  {op=29,a=0,b=1},
  -- 
  {op=1,a=774,bx=1209},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: local screenPos, onScreen = Camera:WorldToViewportPoint(TargetPart.Position)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: TargetInfo.Visible = true
  -- RAW: TargetInfo.Position = Vector2.new(screenPos.X, screenPos.Y + 20)
  {op=9,a=775,b=0,c=0},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=776,bx=1210},
  {op=1,a=777,bx=1211},
  -- RAW: for _, data in pairs(PlayerCache) do
  -- RAW: if data.Model == CurrentTarget then targetType = "Player"; targetName = data.Player.Name; break end
  {op=29,a=0,b=1},
  -- RAW: if _G.ShowTargetType then table.insert(infoLines, string.format("[%s] %s", targetType, targetName))
  -- RAW: else table.insert(infoLines, targetName) end
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=715,bx=1173},
  -- RAW: if humanoid then table.insert(infoLines, string.format("HP: %.0f/%.0f", humanoid.Health, humanoid.MaxHealth)) end
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=749,bx=1175},
  {op=1,a=751,bx=1212},
  -- RAW: table.insert(infoLines, string.format("Dist: %s studs", distance))
  {op=29,a=0,b=1},
  -- 
  -- RAW: if shouldShowHitChance then table.insert(infoLines, string.format("Chance: %d%%", CalculateHitChanceDisplay())) end
  -- 
  -- RAW: if #infoLines > 0 then TargetInfo.Text = table.concat(infoLines, "\n") else TargetInfo.Text = "Alvo travado" end
  {op=21,sbx=0},
  -- RAW: TargetInfo.Visible = false; TargetInfo.Text = ""
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  -- RAW: TargetInfo.Visible = false; TargetInfo.Text = ""
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- --// ==================================================
  -- --// 4. FUNÇÕES DO ESP PRO (COM DEAD CHECK)
  -- --// ==================================================
  -- 
  -- RAW: local function newDrawing(t)
  {op=1,a=778,bx=1213},
  -- RAW: obj.Visible = false
  -- RAW: obj.ZIndex = 2
  {op=0,a=0,b=778},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function setDrawingVisibility(parts, isVisible)
  -- RAW: for _, obj in pairs(parts) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: obj.Visible = isVisible
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function getCharacterHumanoid(model)
  -- RAW: if not model or not model:IsA("Model") then return nil, nil end
  {op=1,a=187,bx=824},
  -- RAW: if not hum then return nil, nil end
  {op=1,a=186,bx=1214},
  -- RAW: if not root then return nil, nil end
  {op=1,a=0,bx=1215},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function getPlayerFromCharacterESP(model)
  {op=1,a=0,bx=1216},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function getEquippedToolName(model)
  -- RAW: for _, v in ipairs(model:GetChildren()) do
  -- RAW: if v:IsA("Tool") or v:IsA("Accessory") then return v.Name end
  {op=29,a=0,b=1},
  {op=1,a=0,bx=123},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function getInventoryItems(model)
  {op=9,a=779,b=0,c=0},
  {op=1,a=780,bx=1217},
  -- 
  -- RAW: for _, v in ipairs(model:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: table.insert(items, v.Name .. " (Eq)")
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, v in ipairs(plr.Backpack:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: table.insert(items, v.Name)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=1218},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=123},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function getTeamColor(model)
  {op=1,a=780,bx=1217},
  -- RAW: if plr and plr.Team then return plr.TeamColor and plr.TeamColor.Color or plr.Team.Color end
  {op=1,a=0,bx=123},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function isAlly(model)
  {op=1,a=780,bx=1217},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if LocalPlayer.Team and plr.Team and LocalPlayer.Team == plr.Team then return true end
  -- RAW: if LocalPlayer.TeamColor and plr.TeamColor and LocalPlayer.TeamColor == plr.TeamColor then return true end
  {op=29,a=0,b=1},
  {op=1,a=781,bx=1219},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if tostring(teamValue.Value) == tostring(LocalPlayer.Team.Name) then return true end
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function createESP(model)
  -- RAW: if ESP_Objects[model] then return end
  {op=9,a=563,b=0,c=0},
  -- RAW: parts.Box = newDrawing("Square"); parts.Box.Thickness = 1; parts.Box.Filled = false
  -- RAW: parts.Line = newDrawing("Line"); parts.Line.Thickness = 1
  -- RAW: parts.Stick = newDrawing("Line"); parts.Stick.Thickness = 1
  -- RAW: parts.NameText = newDrawing("Text"); parts.NameText.Center = true; parts.NameText.Outline = true; parts.NameText.Font = 2
  -- RAW: parts.DistanceText = newDrawing("Text"); parts.DistanceText.Center = true; parts.DistanceText.Outline = true; parts.DistanceText.Font = 2
  -- RAW: parts.HPBarBack = newDrawing("Square"); parts.HPBarBack.Filled = true; parts.HPBarBack.Color = Color3.fromRGB(0, 0, 0)
  -- RAW: parts.HPBar = newDrawing("Square"); parts.HPBar.Filled = true
  -- RAW: parts.HPText = newDrawing("Text"); parts.HPText.Center = true; parts.HPText.Outline = true; parts.HPText.Font = 2; parts.HPText.Size = 13
  -- RAW: parts.ItemText = newDrawing("Text"); parts.ItemText.Center = true; parts.ItemText.Outline = true; parts.ItemText.Font = 2; parts.ItemText.Size = 13
  -- RAW: parts.InventoryText = newDrawing("Text"); parts.InventoryText.Center = true; parts.InventoryText.Outline = true; parts.InventoryText.Font = 2; parts.InventoryText.Size = ESP_Config.InventoryTextSize
  -- 
  -- RAW: ESP_Objects[model] = parts
  -- 
  -- RAW: model.AncestryChanged:Connect(function(_, parent)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, obj in pairs(ESP_Objects[model]) do if obj and obj.Remove then obj:Remove() end end
  -- RAW: ESP_Objects[model] = nil
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function worldToViewport(pos)
  -- RAW: local v, onScreen = Camera:WorldToViewportPoint(pos)
  {op=1,a=0,bx=1220},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- -- ✅ MODIFICADO: updateESP com Dead Check
  -- RAW: local function updateESP()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, parts in pairs(ESP_Objects) do setDrawingVisibility(parts, false) end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=782,bx=1181},
  -- 
  -- RAW: for model, parts in pairs(ESP_Objects) do
  -- RAW: local hum, root = getCharacterHumanoid(model)
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=1221},
  {op=1,a=1,bx=1222},
  {op=27,a=0,b=2,c=1},
  -- RAW: continue
  {op=29,a=0,b=1},
  -- 
  -- -- ✅ Dead Check no ESP
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=1221},
  {op=1,a=1,bx=1222},
  {op=27,a=0,b=2,c=1},
  -- RAW: continue
  {op=29,a=0,b=1},
  -- 
  {op=1,a=718,bx=1223},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=1221},
  {op=1,a=1,bx=1222},
  {op=27,a=0,b=2,c=1},
  -- RAW: continue
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=1221},
  {op=1,a=1,bx=1222},
  {op=27,a=0,b=2,c=1},
  -- RAW: continue
  {op=29,a=0,b=1},
  -- 
  {op=1,a=751,bx=1224},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=1221},
  {op=1,a=1,bx=1222},
  {op=27,a=0,b=2,c=1},
  -- RAW: continue
  {op=29,a=0,b=1},
  -- 
  {op=1,a=783,bx=1225},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=1221},
  {op=1,a=1,bx=1222},
  {op=27,a=0,b=2,c=1},
  -- RAW: continue
  {op=29,a=0,b=1},
  -- 
  -- RAW: local rootPos, onScreen, depth = worldToViewport(root.Position)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- 
  {op=1,a=644,bx=1226},
  -- RAW: if isModelAlly then color = ESP_Config.AllyColor
  {op=21,sbx=0},
  {op=1,a=784,bx=1227},
  -- RAW: if tc then color = tc end
  {op=29,a=0,b=1},
  -- 
  {op=1,a=647,bx=1228},
  -- 
  -- -- Box ESP
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=649,bx=1229},
  {op=1,a=650,bx=1230},
  -- RAW: local topV2, on1 = worldToViewport(top)
  -- RAW: local bottomV2, on2 = worldToViewport(bottom)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=785,bx=1231},
  {op=1,a=786,bx=1232},
  -- RAW: parts.Box.Size = Vector2.new(width, height)
  -- RAW: parts.Box.Position = Vector2.new(rootPos.X - width / 2, topV2.Y)
  -- RAW: parts.Box.Color = color
  -- RAW: parts.Box.Visible = true
  -- RAW: else parts.Box.Visible = false end
  -- RAW: else parts.Box.Visible = false end
  -- 
  -- -- Line ESP
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: parts.Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
  -- RAW: parts.Line.To = rootPos
  -- RAW: parts.Line.Color = ESP_Config.LineColor
  -- RAW: parts.Line.Visible = true
  -- RAW: else parts.Line.Visible = false end
  -- 
  -- -- Stick ESP
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=721,bx=1233},
  -- RAW: local headV2, hOn = worldToViewport(head.Position)
  -- RAW: local footV2, fOn = worldToViewport(root.Position - Vector3.new(0, size.Y / 2, 0))
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: parts.Stick.From = headV2; parts.Stick.To = footV2
  -- RAW: parts.Stick.Color = ESP_Config.StickColor; parts.Stick.Visible = true
  -- RAW: else parts.Stick.Visible = false end
  -- RAW: else parts.Stick.Visible = false end
  -- 
  -- -- Nome ESP
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: parts.NameText.Position = rootPos - Vector2.new(0, 30)
  -- RAW: parts.NameText.Size = ESP_Config.NameTextSize
  -- RAW: parts.NameText.Color = color
  -- RAW: parts.NameText.Text = model.Name
  -- RAW: parts.NameText.Visible = true
  -- RAW: else parts.NameText.Visible = false end
  -- 
  -- -- Distância ESP
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: parts.DistanceText.Position = rootPos - Vector2.new(0, 15)
  -- RAW: parts.DistanceText.Size = ESP_Config.DistanceTextSize
  -- RAW: parts.DistanceText.Color = Color3.fromRGB(255, 255, 255)
  -- RAW: parts.DistanceText.Text = string.format("[%.0f m]", distance)
  -- RAW: parts.DistanceText.Visible = true
  -- RAW: else parts.DistanceText.Visible = false end
  -- 
  -- -- HP Bar
  {op=1,a=787,bx=1234},
  {op=1,a=788,bx=1235},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=789,bx=1236},
  -- RAW: local barW, barH = ESP_Config.HPBarWidth, ESP_Config.HPBarHeight
  -- RAW: local barX, barY = rootPos.X - barW / 2, rootPos.Y + 25
  {op=0,a=787,b=667},
  {op=6,a=787,bx=1237},
  -- RAW: parts.HPBarBack.Size = Vector2.new(barW, barH)
  -- RAW: parts.HPBarBack.Position = Vector2.new(barX, barY); parts.HPBarBack.Visible = true
  -- RAW: parts.HPBar.Size = Vector2.new(barW * hpPercent, barH)
  -- RAW: parts.HPBar.Position = Vector2.new(barX, barY)
  -- RAW: parts.HPBar.Color = Color3.fromRGB(255 * (1 - hpPercent), 255 * hpPercent, 0)
  -- RAW: parts.HPBar.Visible = true
  -- RAW: parts.HPText.Position = Vector2.new(rootPos.X, barY + barH + 8)
  -- RAW: parts.HPText.Color = Color3.fromRGB(255, 255, 255)
  -- RAW: parts.HPText.Text = string.format("%.0f / %.0f", hum.Health, hum.MaxHealth)
  -- RAW: parts.HPText.Visible = true
  {op=21,sbx=0},
  -- RAW: parts.HPBarBack.Visible = false; parts.HPBar.Visible = false; parts.HPText.Visible = false
  {op=29,a=0,b=1},
  -- 
  -- -- Item equipado
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=790,bx=1238},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: parts.ItemText.Position = rootPos - Vector2.new(0, 45)
  -- RAW: parts.ItemText.Color = Color3.fromRGB(120, 255, 120)
  -- RAW: parts.ItemText.Text = "[" .. itemName .. "]"
  -- RAW: parts.ItemText.Visible = true
  -- RAW: else parts.ItemText.Visible = false end
  -- RAW: else parts.ItemText.Visible = false end
  -- 
  -- -- Inventário Completo ESP
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=791,bx=1239},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: parts.InventoryText.Position = Vector2.new(rootPos.X, barYFinal + barHFinal + 25)
  -- RAW: parts.InventoryText.Size = ESP_Config.InventoryTextSize
  -- RAW: parts.InventoryText.Color = Color3.fromRGB(200, 200, 255)
  -- RAW: parts.InventoryText.Text = invText
  -- RAW: parts.InventoryText.Visible = true
  {op=21,sbx=0},
  -- RAW: parts.InventoryText.Visible = false
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  -- RAW: parts.InventoryText.Visible = false
  {op=29,a=0,b=1},
  -- 
  {op=21,sbx=0},
  {op=5,a=0,bx=1221},
  {op=1,a=1,bx=1222},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function scanWorkspace()
  -- RAW: for _, plr in ipairs(Players:GetPlayers()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: local hum, root = getCharacterHumanoid(plr.Character)
  -- RAW: if hum and root then createESP(plr.Character) end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: for _, obj in ipairs(workspace:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: local hum, root = getCharacterHumanoid(obj)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=792,bx=1240},
  -- RAW: if not owner or owner == nil then createESP(obj) end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- --// ==================================================
  -- --// 5. HOOKS E LOOPS (COM BULLET TELEPORT)
  -- --// ==================================================
  -- 
  -- RAW: local function applyBulletTeleport(origin, targetPart)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=0,a=0,b=755},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=1241},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- -- SILENT AIM HOOKS COM BULLET TELEPORT
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=70,bx=1242},
  {op=6,a=70,bx=1243},
  -- RAW: if not _G.SilentAim or not TargetPart or not CurrentTarget then return oldNamecall(self, ...) end
  -- 
  {op=1,a=71,bx=122},
  {op=9,a=516,b=0,c=0},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=72,bx=1244},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if not ShouldHit() then return oldNamecall(self, ...) end
  -- 
  {op=9,a=793,b=0,c=0},
  {op=2,a=794,b=0,c=0},
  -- 
  -- RAW: for i, arg in pairs(args) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: newArgs[i] = applyBulletTeleport(arg, TargetPart)
  {op=21,sbx=0},
  -- RAW: newArgs[i] = TargetPart.Position
  {op=29,a=0,b=1},
  {op=1,a=794,bx=40},
  {op=6,a=794,bx=1245},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=755,bx=1246},
  -- RAW: newArgs[i] = CFrame.new(applyBulletTeleport(origin, TargetPart))
  {op=21,sbx=0},
  -- RAW: newArgs[i] = CFrame.new(TargetPart.Position)
  {op=29,a=0,b=1},
  {op=1,a=794,bx=40},
  {op=6,a=794,bx=1245},
  {op=21,sbx=0},
  {op=1,a=755,bx=1247},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=795,bx=1248},
  -- RAW: newArgs[i] = Ray.new(newOrigin, (TargetPart.Position - newOrigin).Unit * 1000)
  {op=21,sbx=0},
  -- RAW: newArgs[i] = Ray.new(origin, (TargetPart.Position - origin).Unit * 1000)
  {op=29,a=0,b=1},
  {op=1,a=794,bx=40},
  {op=6,a=794,bx=1245},
  {op=21,sbx=0},
  -- RAW: newArgs[i] = arg
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  -- RAW: if modified then return oldNamecall(self, unpack(newArgs)) end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=755,bx=1249},
  {op=1,a=756,bx=1250},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if not ShouldHit() then return oldNamecall(self, ...) end
  -- 
  {op=0,a=795,b=755},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=795,bx=1248},
  {op=6,a=795,bx=1251},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=796,bx=1252},
  {op=1,a=0,bx=1253},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=0,bx=125},
  {op=29,a=0,b=2},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=713,bx=1254},
  {op=6,a=713,bx=1255},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=797,bx=1256},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: if not ShouldHit() then return oldIndex(self, key) end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=1257},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=1258},
  {op=29,a=0,b=2},
  -- RAW: elseif keyLower == "target" then return TargetPart end
  {op=29,a=0,b=1},
  {op=1,a=0,bx=1259},
  {op=29,a=0,b=2},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- -- SILENT AIM UPDATE LOOP
  -- RAW: task.spawn(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: task.wait(_G.UpdateRate)
  -- RAW: if _G.SilentAim then CurrentTarget = GetTarget() else CurrentTarget = nil; TargetInRange = false; TargetPart = nil end
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- -- SILENT AIM VISUALS LOOP
  -- RAW: RunService.RenderStepped:Connect(function()
  -- RAW: Circle.Visible = _G.SilentAim
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=752,bx=1178},
  -- RAW: Circle.Position = screenCenter
  -- RAW: Circle.Radius = _G.FOV
  -- RAW: Circle.Color = _G.FOVColor
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=2,a=798,b=0,c=0},
  -- RAW: for _, data in pairs(PlayerCache) do
  -- RAW: if data.Model == CurrentTarget then isPlayerTarget = true; break end
  {op=29,a=0,b=1},
  -- RAW: if isPlayerTarget then Circle.Color = Color3.fromRGB(0, 150, 255) else Circle.Color = Color3.fromRGB(0, 255, 0) end
  {op=21,sbx=0},
  -- RAW: if TargetInRange then Circle.Color = Color3.fromRGB(255, 255, 0) else Circle.Color = Color3.fromRGB(255, 50, 0) end
  {op=29,a=0,b=1},
  {op=21,sbx=0},
  -- RAW: Circle.Visible = false
  {op=29,a=0,b=1},
  -- 
  {op=5,a=0,bx=1260},
  {op=27,a=0,b=1,c=1},
  {op=5,a=0,bx=1261},
  {op=27,a=0,b=1,c=1},
  -- RAW: end)
  -- 
  -- -- ESP LOOPS & EVENTOS INICIAIS
  {op=5,a=0,bx=1262},
  {op=27,a=0,b=1,c=1},
  -- RAW: Players.PlayerAdded:Connect(function(plr)
  -- RAW: plr.CharacterAdded:Connect(function(char)
  -- RAW: task.wait(1)
  -- RAW: local hum, root = getCharacterHumanoid(char)
  -- RAW: if hum and root then createESP(char) end
  -- RAW: end)
  -- RAW: end)
  -- 
  -- RAW: for _, plr in pairs(Players:GetPlayers()) do
  -- RAW: plr.CharacterAdded:Connect(function(char)
  -- RAW: task.wait(1)
  -- RAW: local hum, root = getCharacterHumanoid(char)
  -- RAW: if hum and root then createESP(char) end
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: workspace.DescendantAdded:Connect(function(obj)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: task.wait(0.2)
  -- RAW: local hum, root = getCharacterHumanoid(obj)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=792,bx=1240},
  -- RAW: if not owner or owner == nil then createESP(obj) end
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: RunService.RenderStepped:Connect(updateESP)
  -- 
  {op=5,a=799,bx=355},
  {op=10,a=799,b=799,c=370},
  {op=27,a=799,b=3,c=1},
  -- RAW: if player == LocalPlayer then CleanupUIOnly() end
  -- RAW: end)
  -- 
  -- --// ==================================================
  -- RAW: end)
  -- RAW: getgenv().WuSilentAimEngineLoaded = ok
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=1263},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=12},
  {op=1,a=1,bx=1264},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=1,a=800,bx=1265},
  {op=1,a=801,bx=1266},
  -- 
  -- -- 仅适配 UI → 全部写 _G，引擎逻辑不改
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1267},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1268},
  {op=6,a=158,bx=227},
  -- RAW: _G.SilentAim = v and true or false
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- -- 原版在开启时刷新缓存；若引擎局部函数不可见则跳过
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=5,a=802,bx=304},
  {op=10,a=802,b=802,c=305},
  {op=27,a=802,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SASection:AddSlider({
  {op=1,a=178,bx=1269},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=280},
  {op=6,a=160,bx=233},
  {op=1,a=158,bx=1268},
  {op=6,a=158,bx=227},
  -- RAW: _G.FOV = v
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=382,bx=1270},
  -- -- 原版 Circle 是引擎 local，外层访问不到；FOV 仍由引擎 RenderStepped 读 _G.FOV
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: SASection:AddSlider({
  {op=1,a=178,bx=1271},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=140},
  {op=6,a=160,bx=233},
  {op=1,a=158,bx=1272},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddSlider({
  {op=1,a=178,bx=1273},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=140},
  {op=6,a=160,bx=233},
  {op=1,a=158,bx=1274},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddSlider({
  {op=1,a=178,bx=1275},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=140},
  {op=6,a=160,bx=233},
  {op=1,a=158,bx=1276},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddDropdown({
  {op=1,a=178,bx=1277},
  {op=6,a=178,bx=272},
  {op=1,a=285,bx=1278},
  {op=6,a=285,bx=449},
  {op=1,a=179,bx=1279},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1280},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1281},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1282},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddDropdown({
  {op=1,a=178,bx=1283},
  {op=6,a=178,bx=272},
  {op=1,a=285,bx=1284},
  {op=6,a=285,bx=449},
  {op=1,a=179,bx=1285},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1286},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddDropdown({
  {op=1,a=178,bx=1287},
  {op=6,a=178,bx=272},
  {op=1,a=285,bx=1288},
  {op=6,a=285,bx=449},
  {op=1,a=179,bx=1289},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1290},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1291},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1292},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1293},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1294},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1295},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1296},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddSlider({
  {op=1,a=178,bx=1297},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=280},
  {op=6,a=160,bx=233},
  {op=1,a=158,bx=1298},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1299},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1300},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1301},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1302},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1303},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1304},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1305},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1306},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1307},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1308},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1309},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=74},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1310},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- RAW: SASection:AddToggle({
  {op=1,a=178,bx=1311},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=1312},
  {op=6,a=158,bx=227},
  -- RAW: })
  -- 
  -- -- 外部脚本按钮保留
  {op=1,a=803,bx=1313},
  -- RAW: ExtAim:AddButton({
  {op=1,a=178,bx=1314},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=1315},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=804,bx=304},
  {op=10,a=804,b=804,c=305},
  {op=27,a=804,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- RAW: ExtAim:AddButton({
  {op=1,a=178,bx=1316},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=1317},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=805,bx=304},
  {op=10,a=805,b=805,c=305},
  {op=27,a=805,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- -- 标签页：玩家管理
  -- -------------------------------------------------
  {op=1,a=806,bx=1318},
  {op=1,a=807,bx=1319},
  -- 
  {op=1,a=808,bx=1320},
  {op=9,a=809,b=0,c=0},
  {op=2,a=810,b=0,c=0},
  {op=1,a=811,bx=787},
  {op=2,a=812,b=0,c=0},
  {op=1,a=813,bx=1321},
  -- 
  -- RAW: local function doLeaveServer()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=814,bx=355},
  {op=10,a=814,b=814,c=356},
  {op=27,a=814,b=2,c=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function saveWatchList()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=24},
  {op=1,a=1,bx=1322},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function loadWatchList()
  -- RAW: local ok, content = pcall(function()
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=1323},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=1,a=809,bx=444},
  {op=6,a=809,bx=1324},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for line in string.gmatch(content, "[^\r\n]+") do
  {op=1,a=92,bx=1325},
  {op=6,a=92,bx=1326},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=815,bx=1327},
  {op=2,a=816,b=0,c=0},
  -- RAW: for _, n in ipairs(WatchPlayerList) do
  -- RAW: if n == lower then exists = true break end
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: table.insert(WatchPlayerList, lower)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- 
  {op=5,a=0,bx=1328},
  {op=27,a=0,b=1,c=1},
  -- 
  -- RAW: local function isWatchedPlayer(playerName)
  {op=1,a=815,bx=1329},
  -- RAW: for _, n in ipairs(WatchPlayerList) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function addWatchName(raw)
  {op=1,a=817,bx=1330},
  {op=6,a=817,bx=1331},
  -- RAW: if raw == "" then return false, "空" end
  {op=1,a=815,bx=1332},
  -- RAW: for _, n in ipairs(WatchPlayerList) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=1333},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: table.insert(WatchPlayerList, lower)
  {op=5,a=0,bx=1334},
  {op=27,a=0,b=1,c=1},
  {op=1,a=0,bx=1335},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- -- 1. 指定玩家进入时离开（逐个输入储存，像卡密一样）
  {op=1,a=818,bx=1336},
  {op=1,a=178,bx=1337},
  {op=6,a=178,bx=272},
  {op=1,a=819,bx=1338},
  {op=6,a=819,bx=1339},
  {op=1,a=179,bx=63},
  {op=6,a=179,bx=275},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=1340},
  {op=6,a=158,bx=227},
  {op=1,a=168,bx=1341},
  {op=6,a=168,bx=1342},
  -- RAW: if text == "" then return end -- 清空时不处理
  -- RAW: local ok, msg = addWatchName(text)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=820,bx=304},
  {op=10,a=820,b=820,c=305},
  {op=27,a=820,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=821,bx=304},
  {op=10,a=821,b=821,c=305},
  {op=27,a=821,b=3,c=1},
  {op=29,a=0,b=1},
  -- -- 回车保存后清空输入框，方便继续加下一个人
  -- RAW: task.defer(function()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=822,bx=1343},
  {op=10,a=822,b=822,c=1344},
  {op=1,a=824,bx=32},
  {op=27,a=822,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: WatchSection:AddButton({
  {op=1,a=178,bx=1345},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=823,bx=304},
  {op=10,a=823,b=823,c=305},
  {op=27,a=823,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=824,bx=304},
  {op=10,a=824,b=824,c=305},
  {op=27,a=824,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: WatchSection:AddButton({
  {op=1,a=178,bx=1346},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=809,bx=444},
  {op=6,a=809,bx=1324},
  {op=5,a=0,bx=1334},
  {op=27,a=0,b=1,c=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=46},
  {op=0,a=1,b=808},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=24},
  {op=1,a=1,bx=1347},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=825,bx=304},
  {op=10,a=825,b=825,c=305},
  {op=27,a=825,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: WatchSection:AddToggle({
  {op=1,a=178,bx=1348},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=0,a=810,b=400},
  {op=6,a=810,bx=1349},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=826,bx=304},
  {op=10,a=826,b=826,c=305},
  {op=27,a=826,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=827,bx=304},
  {op=10,a=827,b=827,c=305},
  {op=27,a=827,b=3,c=1},
  -- RAW: task.wait(0.3)
  {op=5,a=0,bx=1350},
  {op=27,a=0,b=1,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=5,a=828,bx=304},
  {op=10,a=828,b=828,c=305},
  {op=27,a=828,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=829,bx=304},
  {op=10,a=829,b=829,c=305},
  {op=27,a=829,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=5,a=830,bx=355},
  {op=10,a=830,b=830,c=370},
  {op=27,a=830,b=3,c=1},
  -- RAW: if not WatchPlayerEnabled then return end
  -- RAW: if #WatchPlayerList == 0 then return end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=831,bx=304},
  {op=10,a=831,b=831,c=305},
  {op=27,a=831,b=3,c=1},
  -- RAW: task.wait(0.2)
  {op=5,a=0,bx=1350},
  {op=27,a=0,b=1,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- -- 2. 人数达到上限时离开
  -- RAW: WatchSection:AddSlider({
  {op=1,a=178,bx=1351},
  {op=6,a=178,bx=272},
  {op=1,a=160,bx=148},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=280},
  {op=6,a=161,bx=235},
  {op=1,a=179,bx=787},
  {op=6,a=179,bx=275},
  {op=1,a=180,bx=148},
  {op=6,a=180,bx=276},
  {op=1,a=181,bx=49},
  {op=6,a=181,bx=277},
  {op=1,a=158,bx=278},
  {op=6,a=158,bx=227},
  {op=0,a=811,b=395},
  {op=6,a=811,bx=1352},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  -- RAW: WatchSection:AddToggle({
  {op=1,a=178,bx=1353},
  {op=6,a=178,bx=272},
  {op=1,a=179,bx=49},
  {op=6,a=179,bx=275},
  {op=1,a=158,bx=294},
  {op=6,a=158,bx=227},
  {op=0,a=812,b=400},
  {op=6,a=812,bx=1354},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=832,bx=1355},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=833,bx=304},
  {op=10,a=833,b=833,c=305},
  {op=27,a=833,b=3,c=1},
  -- RAW: task.wait(0.3)
  {op=5,a=0,bx=1350},
  {op=27,a=0,b=1,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=5,a=834,bx=304},
  {op=10,a=834,b=834,c=305},
  {op=27,a=834,b=3,c=1},
  {op=21,sbx=0},
  {op=5,a=835,bx=304},
  {op=10,a=835,b=835,c=305},
  {op=27,a=835,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=5,a=836,bx=355},
  {op=10,a=836,b=836,c=370},
  {op=27,a=836,b=3,c=1},
  -- RAW: if not WatchCountEnabled then return end
  -- RAW: task.wait(0.15)
  {op=1,a=832,bx=1355},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=837,bx=304},
  {op=10,a=837,b=837,c=305},
  {op=27,a=837,b=3,c=1},
  -- RAW: task.wait(0.2)
  {op=5,a=0,bx=1350},
  {op=27,a=0,b=1,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- -------------------------------------------------
  -- -- 标签页：更多脚本
  -- -------------------------------------------------
  {op=1,a=838,bx=1356},
  {op=1,a=839,bx=1357},
  -- 
  -- RAW: local function addMoreScript(name, url, key)
  -- RAW: MoreSection:AddButton({
  {op=1,a=178,bx=629},
  {op=6,a=178,bx=272},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=840,bx=1358},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=841,bx=304},
  {op=10,a=841,b=841,c=305},
  {op=27,a=841,b=3,c=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: _G.LoadedScripts[k] = true
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=377},
  {op=1,a=1,bx=381},
  {op=27,a=0,b=2,c=1},
  -- RAW: end)
  {op=5,a=842,bx=304},
  {op=10,a=842,b=842,c=305},
  {op=27,a=842,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  {op=29,a=0,b=1},
  -- 
  {op=5,a=0,bx=1359},
  {op=1,a=1,bx=1360},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=1359},
  {op=1,a=1,bx=1361},
  {op=27,a=0,b=2,c=1},
  -- 
  -- 
  -- -- 设置已独立为「设置」板块（见下方，功能 pcall 结束后创建）
  -- 
  -- RAW: end)
  -- 
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=12},
  {op=1,a=1,bx=1362},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=1363},
  {op=27,a=0,b=2,c=1},
  {op=21,sbx=0},
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=1364},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=1365},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- 
  -- -------------------------------------------------
  -- 
  -- -- 缩放后强制刷新滚动区域（解决缩小后滑不到底）
  -- RAW: local function WuIsWuScreenGui(sg)
  -- RAW: if not sg then return false end
  -- RAW: if sg:GetAttribute("WuScriptUI") == true then return true end
  -- -- 标题精确匹配，避免误伤其它 UI
  -- RAW: for _, d in ipairs(sg:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=172,bx=266},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- -- by wu 单独不够稳，需与 巫 同屏
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function WuRefreshScroll()
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=9,a=843,b=0,c=0},
  {op=1,a=175,bx=1366},
  -- RAW: if h then table.insert(hosts, h) end
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=1367},
  {op=27,a=0,b=2,c=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=844,bx=1368},
  -- RAW: if pg then table.insert(hosts, pg) end
  -- RAW: end)
  -- 
  {op=9,a=845,b=0,c=0},
  -- RAW: for _, host in ipairs(hosts) do
  -- RAW: for _, sg in ipairs(host:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: seen[sg] = true
  {op=5,a=846,bx=42},
  {op=10,a=846,b=846,c=1369},
  {op=27,a=846,b=3,c=1},
  -- RAW: for _, sf in ipairs(sg:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
  -- RAW: sf.ScrollingEnabled = true
  {op=1,a=847,bx=1370},
  -- RAW: or sf:FindFirstChildOfClass("UIGridLayout")
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=848,bx=1371},
  -- RAW: sf.CanvasSize = UDim2.new(0, 0, 0, math.max(y * 1.15 + 60, sf.AbsoluteSize.Y + 40))
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: getgenv().WuRefreshScroll = WuRefreshScroll
  -- 
  -- -- 独立板块：设置（Vita 原生 API，可改主题/缩放/字体）
  -- -------------------------------------------------
  -- RAW: task.spawn(function()
  -- RAW: task.wait(0.15)
  -- RAW: local ok, err = pcall(function()
  -- -- 用原生 NewPage，不走兼容层，保证缩放/主题 API 可用
  {op=1,a=849,bx=255},
  {op=1,a=850,bx=1372},
  {op=1,a=32,bx=1373},
  {op=6,a=32,bx=56},
  {op=1,a=154,bx=1374},
  {op=6,a=154,bx=219},
  {op=1,a=34,bx=1375},
  {op=6,a=34,bx=60},
  -- RAW: })
  -- 
  {op=5,a=851,bx=1376},
  {op=10,a=851,b=851,c=1377},
  {op=1,a=853,bx=1378},
  {op=27,a=851,b=3,c=1},
  -- 
  -- -- 只缩放「巫 script」窗口，不影响 Delta 等其它 UI
  -- RAW: local function WuIsOurGui(obj)
  {op=0,a=150,b=778},
  {op=1,a=151,bx=148},
  {op=1,a=152,bx=771},
  {op=1,a=153,bx=148},
  {op=31,a=151,sbx=0},
  -- RAW: if not r then return false end
  -- RAW: if r:GetAttribute("WuScriptUI") == true then return true end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, d in ipairs(r:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=172,bx=266},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=150,bx=214},
  {op=6,a=150,bx=215},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- 
  -- RAW: local function WuApplyScale(scale)
  {op=1,a=852,bx=1379},
  {op=6,a=852,bx=1380},
  -- RAW: getgenv().WuUIScale = scale
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=152,bx=26},
  -- -- 优先：已标记的巫 UI 根
  {op=9,a=853,b=0,c=0},
  -- RAW: for _, g in ipairs(host:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: table.insert(roots, g)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- -- 也检查 PlayerGui
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=844,bx=1368},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, g in ipairs(pg:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: table.insert(roots, g)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: for _, root in ipairs(roots) do
  {op=5,a=854,bx=1381},
  {op=10,a=854,b=854,c=1369},
  {op=27,a=854,b=3,c=1},
  -- -- 在窗口主 Frame 上放 UIScale，而不是扫全游戏
  {op=1,a=855,bx=1382},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, ch in ipairs(root:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=855,bx=1383},
  {op=6,a=855,bx=1384},
  -- RAW: break
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=289,bx=1385},
  {op=1,a=856,bx=1386},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- -- 清掉误加在其它地方的不管；只在我们根下创建专用 Scale
  {op=1,a=856,bx=1387},
  {op=6,a=856,bx=216},
  -- RAW: us.Name = "WuOnlyUIScale"
  -- RAW: us.Parent = target
  {op=29,a=0,b=1},
  {op=5,a=857,bx=216},
  {op=10,a=857,b=857,c=1369},
  {op=27,a=857,b=3,c=1},
  -- RAW: us.Scale = scale
  {op=29,a=0,b=1},
  -- RAW: end)
  -- RAW: task.defer(function()
  -- RAW: task.wait(0.05)
  -- RAW: if getgenv().WuRefreshScroll then getgenv().WuRefreshScroll() end
  -- RAW: end)
  -- RAW: task.delay(0.2, function()
  -- RAW: if getgenv().WuRefreshScroll then getgenv().WuRefreshScroll() end
  -- RAW: end)
  {op=29,a=0,b=1},
  -- 
  -- RAW: SettingsPage:Slider({
  {op=1,a=32,bx=1388},
  {op=6,a=32,bx=56},
  {op=1,a=160,bx=280},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=1389},
  {op=6,a=161,bx=235},
  {op=1,a=159,bx=1390},
  {op=6,a=159,bx=230},
  {op=1,a=162,bx=140},
  {op=6,a=162,bx=237},
  {op=1,a=163,bx=1391},
  {op=6,a=163,bx=239},
  {op=1,a=158,bx=1268},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=1392},
  {op=1,a=1,bx=1393},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=5,a=858,bx=1376},
  {op=10,a=858,b=858,c=1377},
  {op=1,a=860,bx=1394},
  {op=27,a=858,b=3,c=1},
  -- RAW: SettingsPage:Slider({
  {op=1,a=32,bx=1395},
  {op=6,a=32,bx=56},
  {op=1,a=160,bx=1396},
  {op=6,a=160,bx=233},
  {op=1,a=161,bx=1397},
  {op=6,a=161,bx=235},
  {op=1,a=159,bx=307},
  {op=6,a=159,bx=230},
  {op=1,a=162,bx=140},
  {op=6,a=162,bx=237},
  {op=1,a=163,bx=1391},
  {op=6,a=163,bx=239},
  {op=1,a=158,bx=1268},
  {op=6,a=158,bx=227},
  {op=1,a=859,bx=1393},
  -- RAW: getgenv().WuFontScale = mul
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=152,bx=26},
  -- RAW: for _, gui in ipairs(host:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- -- skip
  {op=21,sbx=0},
  {op=2,a=860,b=0,c=0},
  -- RAW: for _, d in ipairs(gui:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=860,bx=40},
  {op=6,a=860,bx=1398},
  -- RAW: break
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, inst in ipairs(gui:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=755,bx=1399},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=755,bx=1400},
  {op=6,a=755,bx=1401},
  {op=5,a=861,bx=212},
  {op=10,a=861,b=861,c=1369},
  {op=27,a=861,b=3,c=1},
  {op=29,a=0,b=1},
  -- RAW: inst.TextSize = math.clamp(math.floor(origin * mul + 0.5), 10, 40)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=5,a=862,bx=1376},
  {op=10,a=862,b=862,c=1377},
  {op=1,a=864,bx=1402},
  {op=27,a=862,b=3,c=1},
  {op=9,a=863,b=0,c=0},
  -- RAW: ["默认蓝"] = {
  {op=1,a=45,bx=1403},
  {op=6,a=45,bx=78},
  {op=1,a=47,bx=1404},
  {op=6,a=47,bx=82},
  {op=1,a=50,bx=1405},
  {op=6,a=50,bx=88},
  -- RAW: },
  -- RAW: ["冰蓝"] = {
  {op=1,a=45,bx=77},
  {op=6,a=45,bx=78},
  {op=1,a=47,bx=1406},
  {op=6,a=47,bx=82},
  {op=1,a=50,bx=1407},
  {op=6,a=50,bx=88},
  -- RAW: },
  -- RAW: ["青绿"] = {
  {op=1,a=45,bx=1408},
  {op=6,a=45,bx=78},
  {op=1,a=47,bx=1409},
  {op=6,a=47,bx=82},
  {op=1,a=50,bx=1410},
  {op=6,a=50,bx=88},
  -- RAW: },
  -- RAW: ["紫色"] = {
  {op=1,a=45,bx=1411},
  {op=6,a=45,bx=78},
  {op=1,a=47,bx=1412},
  {op=6,a=47,bx=82},
  {op=1,a=50,bx=1413},
  {op=6,a=50,bx=88},
  -- RAW: },
  -- RAW: ["红色"] = {
  {op=1,a=45,bx=1414},
  {op=6,a=45,bx=78},
  {op=1,a=47,bx=1415},
  {op=6,a=47,bx=82},
  {op=1,a=50,bx=1416},
  {op=6,a=50,bx=88},
  -- RAW: },
  -- RAW: ["橙色"] = {
  {op=1,a=45,bx=1417},
  {op=6,a=45,bx=78},
  {op=1,a=47,bx=1418},
  {op=6,a=47,bx=82},
  {op=1,a=50,bx=1419},
  {op=6,a=50,bx=88},
  -- RAW: },
  -- RAW: ["粉色"] = {
  {op=1,a=45,bx=1420},
  {op=6,a=45,bx=78},
  {op=1,a=47,bx=1421},
  {op=6,a=47,bx=82},
  {op=1,a=50,bx=1422},
  {op=6,a=50,bx=88},
  -- RAW: },
  -- RAW: ["暗黑"] = {
  {op=1,a=45,bx=1423},
  {op=6,a=45,bx=78},
  {op=1,a=47,bx=1424},
  {op=6,a=47,bx=82},
  {op=1,a=50,bx=1425},
  {op=6,a=50,bx=88},
  -- RAW: },
  -- RAW: }
  {op=9,a=15,b=0,c=0},
  -- RAW: SettingsPage:Dropdown({
  {op=1,a=32,bx=1426},
  {op=6,a=32,bx=56},
  {op=1,a=167,bx=1427},
  {op=6,a=167,bx=249},
  {op=1,a=159,bx=1428},
  {op=6,a=159,bx=230},
  {op=1,a=158,bx=1429},
  {op=6,a=158,bx=227},
  {op=1,a=864,bx=1430},
  -- RAW: if not th then return end
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=5,a=865,bx=1431},
  {op=10,a=865,b=865,c=1432},
  {op=0,a=867,b=864},
  {op=27,a=865,b=3,c=1},
  -- RAW: end)
  -- -- 同步：图标色 + 方框描边（仅巫 script）
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=866,bx=1433},
  {op=1,a=390,bx=1434},
  {op=1,a=152,bx=26},
  -- RAW: local function underWu(inst)
  {op=1,a=150,bx=212},
  {op=1,a=151,bx=148},
  {op=1,a=152,bx=265},
  {op=1,a=153,bx=148},
  {op=31,a=151,sbx=0},
  -- RAW: if not r then return false end
  -- RAW: if r:GetAttribute("WuScriptUI") == true then return true end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, d in ipairs(r:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=0,bx=40},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  {op=1,a=150,bx=214},
  {op=6,a=150,bx=215},
  {op=29,a=0,b=1},
  {op=1,a=0,bx=10},
  {op=29,a=0,b=2},
  {op=29,a=0,b=1},
  -- RAW: for _, inst in ipairs(host:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- -- skip other UIs
  {op=21,sbx=0},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: inst.ImageColor3 = ac
  {op=21,sbx=0},
  -- -- 方框边缘 / 描边跟主题强调色
  -- RAW: inst.Color = ac
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=0,bx=263},
  {op=1,a=1,bx=1435},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=5,a=867,bx=1376},
  {op=10,a=867,b=867,c=1377},
  {op=1,a=869,bx=1436},
  {op=27,a=867,b=3,c=1},
  -- RAW: SettingsPage:Button({
  {op=1,a=32,bx=347},
  {op=6,a=32,bx=56},
  {op=1,a=50,bx=1437},
  {op=6,a=50,bx=88},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: if clearSavedKey then clearSavedKey() end
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=24},
  {op=1,a=1,bx=1438},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  {op=5,a=0,bx=263},
  {op=1,a=1,bx=1439},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- RAW: SettingsPage:Button({
  {op=1,a=32,bx=1440},
  {op=6,a=32,bx=56},
  {op=1,a=50,bx=1441},
  {op=6,a=50,bx=88},
  {op=1,a=158,bx=321},
  {op=6,a=158,bx=227},
  {op=1,a=868,bx=14},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  -- RAW: if setclipboard then setclipboard(CONTACT)
  -- RAW: elseif toclipboard then toclipboard(CONTACT) end
  -- RAW: end)
  {op=5,a=0,bx=263},
  {op=1,a=1,bx=1442},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- RAW: SettingsPage:Keybind({
  {op=1,a=32,bx=1443},
  {op=6,a=32,bx=56},
  {op=1,a=159,bx=208},
  {op=6,a=159,bx=230},
  {op=1,a=158,bx=1444},
  {op=6,a=158,bx=227},
  {op=5,a=0,bx=263},
  {op=1,a=1,bx=1445},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: })
  -- 
  {op=5,a=0,bx=0},
  {op=1,a=1,bx=1446},
  {op=27,a=0,b=2,c=1},
  -- -- 初次 + 定时刷新滚动，防止长列表被裁切
  -- RAW: task.defer(WuRefreshScroll)
  -- RAW: task.delay(0.5, WuRefreshScroll)
  -- RAW: task.delay(1.0, WuRefreshScroll)
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=9,a=843,b=0,c=0},
  -- RAW: for _, host in ipairs(hosts) do
  -- RAW: for _, sg in ipairs(host:GetChildren()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  -- RAW: for _, sf in ipairs(sg:GetDescendants()) do
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=1,a=847,bx=1370},
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=204,bx=1447},
  {op=10,a=204,b=204,c=1369},
  {op=27,a=204,b=3,c=1},
  {op=5,a=869,bx=1447},
  {op=10,a=869,b=869,c=549},
  {op=27,a=869,b=3,c=1},
  {op=5,a=0,bx=2},
  {op=1,a=1,bx=3},
  {op=27,a=0,b=2,c=1},
  {op=1,a=848,bx=1448},
  -- RAW: sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
  -- RAW: sf.CanvasSize = UDim2.new(0, 0, 0, math.max(y * 1.15 + 60, 1))
  -- RAW: end)
  -- RAW: end)
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
  -- RAW: end)
  {op=25,a=0,c=0},
  {op=21,sbx=0},
  {op=5,a=0,bx=12},
  {op=1,a=1,bx=1449},
  {op=27,a=0,b=2,c=1},
  {op=29,a=0,b=1},
  -- RAW: end)
  -- 
}

-- VM Execution Engine (Stack + Register)
local _VM_RUN = {}
_VM_RUN.stack = {}
_VM_RUN.pc = 1
_VM_RUN.execute = function()
  while _VM_RUN.pc <= #_VM.bytecode do
    local inst = _VM.bytecode[_VM_RUN.pc]
    if inst.op == 1 then _VM.locals[inst.a] = _VM.consts[inst.bx]
    elseif inst.op == 0 then _VM.locals[inst.a] = _VM.locals[inst.b]
    elseif inst.op == 5 then _VM.locals[inst.a] = _G[_VM.consts[inst.bx]]
    elseif inst.op == 6 then _G[_VM.consts[inst.bx]] = _VM.locals[inst.a]
    elseif inst.op == 27 then _VM.locals[inst.a](_VM.locals[inst.a+1])
    elseif inst.op == 2 then _VM.locals[inst.a] = (inst.b == 1)
    elseif inst.op == 3 then _VM.locals[inst.a] = nil
    elseif inst.op == 9 then _VM.locals[inst.a] = {}
    elseif inst.op == 29 then break
    elseif inst.op == 21 then _VM_RUN.pc = _VM_RUN.pc + inst.sbx
    elseif inst.op == 31 then -- for prep
    elseif inst.op == 30 then -- for loop
    elseif inst.op == 35 then _VM.locals[inst.a] = function() end
    elseif inst.op == 10 then -- self call
    end
    _VM_RUN.pc = _VM_RUN.pc + 1
  end
end
_VM_RUN.execute()
