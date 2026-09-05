if run == true then
  error("中断")
end
pcall(function() getgenv().run = true end)

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Notify({
    Title = "正在加载中，请稍候",
    Duration = 3,
})


if not game:IsLoaded() then
    game.Loaded:Wait()
end


local t0 = os.clock()   --计时

--编辑
local Window = WindUI:CreateWindow({
    Title = "标题",
    Icon = "app-window",
    Resizable = false,
    Size = UDim2.fromOffset(580, 380),
    Transparent = true,
    HideSearchBar = true,
    SideBarWidth = 140,
    KeySystem = { 
        Key = { "USB" },
        Note = "密码会被保存，下次无需输入",
        SaveKey = true,
    },
})

WindUI:SetNotificationLower(true)
Window:IsResizable(false)

local PingTag = Window:Tag({
    Title = "Ping: 0ms",
    Color = Color3.fromRGB(100, 200, 255),
})
 
task.spawn(function()
    while true do
        local success, ping = pcall(function()
            local Stats = game:GetService("Stats")
            local pingValue = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            return math.floor(pingValue)
        end)
        
        if success and ping then
            PingTag:SetTitle("Ping: " .. ping .. "ms")
            
            if ping <= 50 then
                PingTag:SetColor(Color3.fromRGB(0, 255, 0)) -- Green
            elseif ping <= 100 then
                PingTag:SetColor(Color3.fromRGB(255, 200, 0)) -- Yellow
            elseif ping <= 200 then
                PingTag:SetColor(Color3.fromRGB(255, 150, 0)) -- Orange
            else
                PingTag:SetColor(Color3.fromRGB(255, 0, 0)) -- Red
            end
        end
        
        task.wait(2)
    end
end)

local FPSTag = Window:Tag({
    Title = "FPS: 0",
    Color = Color3.fromRGB(100, 150, 255),
})
 
local RunService = game:GetService("RunService")
local lastUpdate = tick()
local frameCount = 0
 
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    
    if now - lastUpdate >= 1 then
        local fps = math.floor(frameCount / (now - lastUpdate))
        FPSTag:SetTitle("FPS: " .. fps)
        
        if fps >= 50 then
            FPSTag:SetColor(Color3.fromRGB(0, 255, 0)) -- Green
        elseif fps >= 30 then
            FPSTag:SetColor(Color3.fromRGB(255, 200, 0)) -- Yellow
        else
            FPSTag:SetColor(Color3.fromRGB(255, 0, 0)) -- Red
        end
        
        
        frameCount = 0
        lastUpdate = now
    end
end)

Window:EditOpenButton({
    Title = "\t",
    Icon = "app-window",
    CornerRadius = UDim.new(0,8),
    StrokeThickness = 0,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    --Enabled = false,
    Draggable = true,
})

Window:DisableTopbarButtons({
    "Close", 
})

local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
if PlayerGui:FindFirstChild("003-A") then
     getfenv().Lockedgame = false
else
     getfenv().Lockedgame = true
end


--左边选择
local Tabs = {
   Announcement_Updates = Window:Tab({ Title = "须知事项", Icon = "solar:home-2-bold", }),
   genericscript = Window:Tab({ Title = "通用脚本", Icon = "solar:password-minimalistic-input-bold", }),
   STBB = Window:Section({Title = "封锁战线", Opened = true, }),
   maincontent = Window:Tab({ Title = "主要内容", Icon = "solar:check-square-bold", Locked = getfenv().Lockedgame, }),
   Remotestore = Window:Tab({ Title = "远程商店", Icon = "solar:cursor-square-bold", Locked = getfenv().Lockedgame, }),
   switchroles = Window:Tab({ Title = "切换角色", Icon = "solar:square-transfer-horizontal-bold",Locked = getfenv().Lockedgame, }),
   playergui = Window:Tab({ Title = "页面类别", Icon = "solar:hamburger-menu-bold", Locked = getfenv().Lockedgame, }),
}



local function rejoin()
if #game:GetService("Players"):GetPlayers() <= 1 then
            game:GetService("Players").LocalPlayer:Kick("\nRejoining...")
            task.wait(1)
            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        else
            local success, err = pcall(function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
            end)
            if not success then
                warn("Teleport failed:", err)
            end
end
end


--窗口顶部按钮
Window:CreateTopbarButton("重新进入", "bird",    function()
WindUI:Popup({
    Title = "提示",
    Icon = "info",
    Content = "确定要重进游戏吗？",
    Buttons = {
        {
            Title = "确定",
            Callback = function() rejoin() end,
            Variant = "Tertiary",
        },
        {
            Title = "不了",
            Icon = "arrow-right",
            Callback = function() end,
            Variant = "Primary",
        }
    }
})
end,  990)

--通用脚本

Tabs.genericscript:Button({
	Title = "飞行",
	Desc = nil,
    	Callback = function()
          loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Flight-v3-40046"))()
    end
})


Tabs.genericscript:Toggle({
	Title = "夜视",
	Desc = nil,
	Value = false,
    	Callback = function(Value)
    	if Value then
           game:GetService("Lighting").Ambient = Color3.fromRGB(307,307,307)
        else
           game:GetService("Lighting").Ambient = Color3.fromRGB(107,107,107)
        end
    	end
}, "Toggle")


Tabs.genericscript:Button({
	Title = "Infinite Yield",
	Desc = nil,
    	Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

Tabs.genericscript:Button({
	Title = "点击传送工具",
	Desc = nil,
    	Callback = function()
local speaker = game:GetService("Players").LocalPlayer
local TpTool = Instance.new("Tool")
TpTool.Name = "点击传送"
TpTool.RequiresHandle = false
local IYMouse = speaker:GetMouse()
TpTool.Parent = speaker.Backpack
TpTool.Activated:Connect(function()
    local Char = speaker.Character
    if not Char then
        Char = workspace:FindFirstChild(speaker.Name)
    end
    local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
    local hitPosition = IYMouse.Hit
    HRP.CFrame = CFrame.new(hitPosition.X, hitPosition.Y + 3, hitPosition.Z, select(4, HRP.CFrame:components()))
end)
    end
})

local PlayerTips = false
local PlayerAddedConnection = nil
local PlayerRemovingConnection = nil
Tabs.genericscript:Toggle({
    Title = "玩家进入提示",
    Value = false,
    Callback = function(Value)
        PlayerTips = Value
        if PlayerTips then
            PlayerAddedConnection = game.Players.PlayerAdded:Connect(function(player)
              WindUI:Notify({
                Title = "玩家提示",
                 Content = player.Name .. " 加入了游戏！",
                 Duration = 5
              })
            end)

            PlayerRemovingConnection = game.Players.PlayerRemoving:Connect(function(player)
                WindUI:Notify({
                Title = "玩家提示",
                 Content = player.Name .. " 离开了游戏！",
                 Duration = 5
              })
            end)
        else
            if PlayerAddedConnection then
                PlayerAddedConnection:Disconnect()
                PlayerAddedConnection = nil
            end

            if PlayerRemovingConnection then
                PlayerRemovingConnection:Disconnect()
                PlayerRemovingConnection = nil
            end
        end
    end
}, "Toggle")

Tabs.genericscript:Button({
	Title = "console",
	Desc = nil,
    	Callback = function()
         StarterGui = cloneref(game:GetService("StarterGui"))
         StarterGui:SetCore("DevConsoleVisible", true)
    end
})

local AutomaticinteractionV2 = false
Tabs.genericscript:Toggle({
    Title = "自动互动",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
      if Value then
          AutomaticinteractionV2 = true
          while AutomaticinteractionV2 do
          wait(0.000001)
              for i,d in pairs(game:GetService("Workspace"):GetDescendants()) do
                if d.ClassName == 'ProximityPrompt' then
                   fireproximityprompt(d)
                end
              end
          end
      else
          AutomaticinteractionV2 = false
      end
    end
})

local FixedPointTransmission = Tabs.genericscript:Section({Title = "定点传送", Box = true,})

_G["Fixed-pointTransmission_1"] = Vector3.new(0, 0, 0)
_G["Fixed-pointTransmission_2"] = Vector3.new(0, 0, 0)
_G["Fixed-pointTransmission_3"] = Vector3.new(0, 0, 0)
_G["Fixed-pointTransmission_4"] = Vector3.new(0, 0, 0)

-- 本地缓存
local points = {
    _G["Fixed-pointTransmission_1"],
    _G["Fixed-pointTransmission_2"],
    _G["Fixed-pointTransmission_3"],
    _G["Fixed-pointTransmission_4"]
}

local speed = 1
local running = false
local loopCoroutine = nil

local function stopLoop()
    running = false
    if loopCoroutine then
        coroutine.close(loopCoroutine)
        loopCoroutine = nil
    end
end

local function startLoop()
    stopLoop()
    running = true
    loopCoroutine = coroutine.create(function()
        while running do
            for i = 1, 4 do
                if not running then break end
                local target = points[i]
                local player = game.Players.LocalPlayer
                if player and player.Character then
                    local root = player.Character:FindFirstChild("HumanoidRootPart")
                        or player.Character:FindFirstChild("Torso")
                    if root then
                        root.Position = target
                    end
                end
                task.wait(speed)
            end
        end
    end)
    coroutine.resume(loopCoroutine)
end

-- 开关
FixedPointTransmission:Toggle({
    Title = "开启传送",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
        if Value then
            startLoop()
        else
            stopLoop()
        end
    end
})

-- 速度输入
FixedPointTransmission:Input({
    Title = "速度值",
    Desc = "单位：秒（支持小数）",
    Value = "",
    Type = "Input",
    Placeholder = "请输入数字",
    Callback = function(input)
        local num = tonumber(input)
        if num and num > 0 then
            speed = num
        end
    end
})

-- 记录坐标点
local function recordPoint(index)
    local player = game.Players.LocalPlayer
    if not player then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if root then
        local pos = root.Position
        points[index] = pos
        _G["Fixed-pointTransmission_" .. index] = pos
    end
end

FixedPointTransmission:Button({
    Title = "坐标点一",
    Desc = nil,
    Locked = false,
    Callback = function()
        recordPoint(1)
    end
})

FixedPointTransmission:Button({
    Title = "坐标点二",
    Desc = nil,
    Locked = false,
    Callback = function()
        recordPoint(2)
    end
})

FixedPointTransmission:Button({
    Title = "坐标点三",
    Desc = nil,
    Locked = false,
    Callback = function()
        recordPoint(3)
    end
})

FixedPointTransmission:Button({
    Title = "坐标点四",
    Desc = nil,
    Locked = false,
    Callback = function()
        recordPoint(4)
    end
})

-- ==================== 秒杀_旧 ====================
local Secondkilling_old = false
local oldKillLoop = nil

Tabs.genericscript:Toggle({
    Title = "秒杀_旧",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(a)
        if a then
            Secondkilling_old = true

            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 112412400000)
            sethiddenproperty(game.Players.LocalPlayer, "MaxSimulationRadius", 112412400000)

            oldKillLoop = task.spawn(function()
                while Secondkilling_old do
                    for _, d in ipairs(workspace:GetDescendants()) do
                        if d:IsA("Humanoid") then
                            local parent = d.Parent
                            if parent and parent.Name ~= game.Players.LocalPlayer.Name then
                                pcall(function()
                                    if d and d.Parent then
                                        d.Health = 0
                                    end
                                end)
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)

        else
            Secondkilling_old = false
            if oldKillLoop then
                task.cancel(oldKillLoop)
                oldKillLoop = nil
            end
            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 0)
            sethiddenproperty(game.Players.LocalPlayer, "MaxSimulationRadius", 0)
        end
    end
})


local rs = game:GetService("RunService")
local ws = game:GetService("Workspace")
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer

local function isnpc(ins)
    local humanoid = ins:FindFirstChildOfClass("Humanoid")
    local player = plrs:GetPlayerFromCharacter(ins)
    return humanoid and not player
end

function partowner(part)
	return part.ReceiveAge == 0
end

local con1 = nil
local con2 = nil
local isEnabled = false
local rad = 150

Tabs.genericscript:Toggle({
    Title = "秒杀",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(a)
        if a then
            isEnabled = true
            
            con1 = rs.Stepped:Connect(function()
                if not isEnabled then return end
                
                local hrp1 = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                if not hrp1 then return end

                local nbp = ws:GetPartBoundsInRadius(hrp1.Position, 13)
                for _, part in pairs(nbp) do
                    local model = part:FindFirstAncestorOfClass("Model")
                    if model and isnpc(model) then
                        local npc = model
                        local hrp = npc:FindFirstChild("HumanoidRootPart")
                        if hrp and partowner(hrp) and not hrp.Anchored and npc ~= lp.Character then
                            local hum = npc:FindFirstChildOfClass("Humanoid")
                            if hum then
                                hum:ChangeState(15)
                            end
                        end
                    end
                end
            end)
            
            con2 = rs.RenderStepped:Connect(function()
                if not isEnabled then return end
                
                if sethiddenproperty then
                    sethiddenproperty(lp, "SimulationRadius", rad)
                else
                    lp.SimulationRadius = rad
                end
            end)
            
        else
            isEnabled = false
            
            if con1 then
                con1:Disconnect()
                con1 = nil
            end
            if con2 then
                con2:Disconnect()
                con2 = nil
            end
            
            if sethiddenproperty then
                sethiddenproperty(lp, "SimulationRadius", 0)
            else
                lp.SimulationRadius = 0
            end
        end
    end
})

getfenv().speedtrue = false
getfenv().speedvalue = 6
game:GetService('RunService').RenderStepped:connect(function()
  if getfenv().speedtrue == true then
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed =  getfenv().speedvalue
  end
end)

local speed = Tabs.genericscript:Section({ 
    Title = "移动速度",
    Box = true,
})

speed:Toggle({
    Title = "移动速度",
    Desc = "关闭后需要刷新一下速度",
    Value = false,
    Callback = function(Value)
       getfenv().speedtrue = Value
    end
}, "Toggle")

speed:Slider({
    Title = "速度参数",
    Step = 1,
    Value = {
        Min = 6,
        Max = 1200,
        Default = 6,
    },
    Callback = function(value)
        getfenv().speedvalue = value
    end
})

getfenv().HeadSize = 8
getfenv().collisionscript = false
game:GetService('RunService').RenderStepped:connect(function()
 if getfenv().collisionscript == true then
  for i,v in next, game:GetService('Players'):GetPlayers() do
      if v.Name ~= game:GetService('Players').LocalPlayer.Name then
        pcall(function()
          v.Character.HumanoidRootPart.Size = Vector3.new(getfenv().HeadSize,getfenv().HeadSize,getfenv().HeadSize)
          v.Character.HumanoidRootPart.Transparency = 0.7
          v.Character.HumanoidRootPart.BrickColor = BrickColor.new("可视化范围")
          v.Character.HumanoidRootPart.Material = "Neon"
          v.Character.HumanoidRootPart.CanCollide = false
        end)
      else
        v.Character.HumanoidRootPart.Transparency = 1
        v.Character.HumanoidRootPart.Size = v.Character.Torso.Size
      end
  end
 end
end)

local Playersize = Tabs.genericscript:Section({ 
    Title = "玩家体积",
    Box = true,
})

Playersize:Toggle({
    Title = "玩家体积",
    Desc = "",
    Value = false,
    Callback = function(Value)
       getfenv().collisionscript = Value
    end
}, "Toggle")

Playersize:Slider({
    Title = "体积参数",
    Step = 1,
    Value = {
        Min = 2,
        Max = 720,
        Default = 8,
    },
    Callback = function(value)
        getfenv().HeadSize = value
    end
})

Tabs.genericscript:Button({
    Title = "rejoin",
    Desc = nil,
    Callback = function()
WindUI:Popup({
    Title = "提示",
    Icon = "info",
    Content = "确定要重进游戏吗？",
    Buttons = {
        {
            Title = "确定",
            Callback = function() rejoin() end,
            Variant = "Tertiary",
        },
        {
            Title = "不了",
            Icon = "arrow-right",
            Callback = function() end,
            Variant = "Primary",
        }
    }
})
    end
})


local textreplacement = Tabs.genericscript:Section({Title = "文本替换", Box = true})

getfenv().KEY1 = game.Players.LocalPlayer.DisplayName
getfenv().KEY2 = game.Players.LocalPlayer.Name
getfenv().REPLACE_WITH = "InvalidText"

textreplacement:Input({
    Title = "文本1",
    Desc = "你的名称:" .. game.Players.LocalPlayer.DisplayName,
    Value = game.Players.LocalPlayer.DisplayName,
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "请输入文本...",
    Callback = function(input)
        getfenv().KEY1 = input
    end
})

textreplacement:Input({
    Title = "文本2",
    Desc = "你的用户名:" .. game.Players.LocalPlayer.Name,
    Value = game.Players.LocalPlayer.Name,
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "请输入文本...",
    Callback = function(input)
        getfenv().KEY2 = input
    end
})

textreplacement:Input({
    Title = "替换文本",
    Desc = "替换后的文本",
    Value = "InvalidText",
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "请输入文本...",
    Callback = function(input)
        getfenv().REPLACE_WITH = input
    end
})

textreplacement:Button({
    Title = "确认",
    Desc = "会卡顿零点几秒",
    Callback = function()
        local CASE_SENSITIVE = true
        local cmp = CASE_SENSITIVE and function(s) return s end or function(s) return s:lower() end
        local key1 = cmp(getfenv().KEY1 or "")
        local key2 = cmp(getfenv().KEY2 or "")
        local replaceText = getfenv().REPLACE_WITH or "InvalidText"
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                local t = cmp(obj.Text)
                if t:find(key1, 1, true) or t:find(key2, 1, true) then
                    obj.Text = replaceText
                end
            end
            local n = cmp(obj.Name)
            if n:find(key1, 1, true) or n:find(key2, 1, true) then
                obj.Name = replaceText
            end
        end
    end
})


local tcu_game_tabs = Tabs.genericscript:Section({Title = "TCU功能", Box = true})

local Speciactoilet_tcu_list = {
    "Fire Bomber Toilet",
    "Plane Bomb Toilet",
    "Plane Bomb Toilet_Variant",
    "Radiation Barrel Spider Toilet",
}

tcu_game_tabs:Toggle({
    Title = "传送马桶",
    Desc = nil,
    Locked = false,
    Value = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local workspace = game:GetService("Workspace")
        
        local LocalPlayer = Players.LocalPlayer
        local LivingFolder = workspace:WaitForChild("Mobs")
        local MAX_DIST = 5000
        local OFFSET = CFrame.new(0, 3, 8)

        if Value then
            RunService:BindToRenderStep("TP", 1, function()
                if not LocalPlayer.Character then return end
                
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                local closest, best = nil, MAX_DIST
                for _, model in ipairs(LivingFolder:GetChildren()) do
                    if model:IsA("Model") then
                        local hum = model:FindFirstChildOfClass("Humanoid")
                        local hrp = model:FindFirstChild("HumanoidRootPart")
                        
                        local shouldSkip = false
                        if model.Name == "Plane Nuke Toilet" then
                            local isActiveObj = model:FindFirstChild("IsActive")
                            if isActiveObj and isActiveObj.Value == true then
                                shouldSkip = true
                            end
                        end
                        
                        local isInList = table.find(Speciactoilet_tcu_list, model.Name) ~= nil
                        
                        if not shouldSkip 
                           and hum and hrp and hum.Health > 0 
                           and not Players:GetPlayerFromCharacter(model) 
                           and not isInList then
                            
                            local d = (hrp.Position - rootPart.Position).Magnitude
                            if d < best then
                                best, closest = d, model
                            end
                        end
                    end
                end

                if closest then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local tgtHrp = closest:FindFirstChild("HumanoidRootPart")
                    if hrp and tgtHrp then
                        hrp.CFrame = tgtHrp.CFrame * OFFSET
                    end
                end
            end)
        else
            pcall(function()
                RunService:UnbindFromRenderStep("TP")
            end)
        end
    end
})


tcu_game_tabs:Button({
	Title = "无CD(不能关)",
	Desc = nil,
    Callback = function()
local old
old = hookfunction(wait, newcclosure(function(...)
   return old()
end))
local balls
balls = hookfunction(task.wait, newcclosure(function(...)
   return balls()
end))
    end
})


tcu_game_tabs:Toggle({
    Title = "传送材料",
    Desc = nil,
    Locked = false,
    Value = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local workspace = game:GetService("Workspace")
        
        local LocalPlayer = Players.LocalPlayer
        local MAX_DIST = 5000
        local OFFSET = CFrame.new(0, 3, 0)

        if Value then
            RunService:BindToRenderStep("TP", 1, function()
                if not LocalPlayer.Character then return end
                
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                local closest, best = nil, MAX_DIST
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if obj:FindFirstChild("TouchInterest") then
                        local pos = obj.Position or (obj:IsA("Model") and (obj:GetPivot().Position))
                        if pos then
                            local d = (pos - rootPart.Position).Magnitude
                            if d < best then
                                best, closest = d, obj
                            end
                        end
                    end
                end

                if closest then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local cf = closest.CFrame or (closest:IsA("Model") and closest:GetPivot())
                        if cf then
                            hrp.CFrame = cf * OFFSET
                        end
                    end
                end
            end)
        else
            pcall(function()
                RunService:UnbindFromRenderStep("TP")
            end)
        end
    end
})

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- 变量声明
local infJump = nil
local infJumpDebounce = false
local infJumpEnabled = false

-- 跳跃权限功能
local function ToggleJump()
    if player and player.Character then
        local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
        if humanoid then 
            humanoid.JumpPower = 50
            humanoid.JumpHeight  = 50
        end
    end
end

-- 无限跳跃功能
local function ToggleInfJump(enable)
    infJumpEnabled = enable ~= false
    if infJump then 
        infJump:Disconnect() 
        infJump = nil 
    end
    
    if infJumpEnabled then
        infJump = UserInputService.JumpRequest:Connect(function()
            if not jumpEnabled then 
                return 
            end
            
            if not infJumpDebounce and player and player.Character then
                local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
                if humanoid then
                    infJumpDebounce = true
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    task.wait()
                    infJumpDebounce = false
                end
            end
        end)
    end
end

-- 创建UI开关
Tabs.genericscript:Button({
    Title = "跳跃权限",
    Callback = function()
        ToggleJump()
    end
})

Tabs.genericscript:Toggle({
    Title = "无限跳跃",
    Value = false,
    Callback = function(Value)
        ToggleInfJump(Value)
    end
})

Tabs.genericscript:Toggle({
    Title = "锁定视角",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
        local P = game.Players.LocalPlayer
        local C = P.Character
        if not C then return end
        local H = C:FindFirstChild("Humanoid")
        local HRP = C:FindFirstChild("HumanoidRootPart")
        if not H or not HRP then return end
        local RS = game:GetService("RunService")
        local Cam = workspace.CurrentCamera
        local EO = CFrame.new(0,0,0)
        local DO = CFrame.new(0,0,0)
        
        if Value then
            H.AutoRotate = false
            local Con
            Con = RS.RenderStepped:Connect(function()
                if not C or not C.Parent then Con:Disconnect() return end
                local LD = Cam.CFrame.LookVector
                LD = Vector3.new(LD.X,0,LD.Z)
                if LD.Magnitude > 0 then
                    LD = LD.Unit
                    HRP.CFrame = CFrame.new(HRP.Position, HRP.Position + LD)
                end
                Cam.CFrame = Cam.CFrame * EO
            end)
            _G.SL = Con
        else
            H.AutoRotate = true
            if _G.SL then _G.SL:Disconnect() _G.SL = nil end
            Cam.CFrame = Cam.CFrame * DO
        end
    end
})

--公告和更新

Tabs.Announcement_Updates:Paragraph({
    Title = "声明",
    Desc = "不乱用，就不会被封，如果封了第一个封的是我",
    Color = "Red",
    Locked = false,
    Buttons = {
        {
            Icon = "bird",
            Title = "不同意",
            Callback = function() game.Players.LocalPlayer:Kick("那你还是别用了") end,
        }
    }
})

Tabs.Announcement_Updates:Paragraph({
    Title = "使用说明",
    Desc = "不要外传，尽量不要在公共场合使用",
    Color = "Red",
    Locked = false,
    Buttons = {
        {
            Icon = "bird",
            Title = "不同意",
            Callback = function() game.Players.LocalPlayer:Kick("那你还是别用了") end,
        }
    }
})


if getfenv().Lockedgame then
  WindUI:Notify({
    Title = "加载完毕，耗时:" .. string.format("%.1f", os.clock() - t0),
    Duration = 3,
  })
  error("中断")
end

--主要内容

function reset()
  if not getfenv().Lockedgame then
    local player = game:GetService("Players").LocalPlayer
    if workspace:FindFirstChild("Living") and player and player.Character then
        replicatesignal(game:GetService("Players").LocalPlayer.Kill)
    end
  end
end

Window:CreateTopbarButton("重置角色", "bird",    function() reset() end,  880)

Tabs.maincontent:Button({
    Title = "重置角色",
    Desc = nil,
    Locked = false,
    Callback = function()
     reset()
    end
})

Tabs.maincontent:Toggle({
    Title = "传送马桶",
    Desc = nil,
    Locked = false,
    Value = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local workspace = game:GetService("Workspace")
        
        local LocalPlayer = Players.LocalPlayer
        local LivingFolder = workspace:WaitForChild("Living")
        local MAX_DIST = 5000
        local OFFSET = CFrame.new(0, 3, 0)

        if Value then
            RunService:BindToRenderStep("TP", 1, function()
                if not LocalPlayer.Character then return end
                
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                local closest, best = nil, MAX_DIST
                for _, model in ipairs(LivingFolder:GetChildren()) do
                    if model:IsA("Model") then
                        local hum = model:FindFirstChildOfClass("Humanoid")
                        local hrp = model:FindFirstChild("HumanoidRootPart")
                        if hum and hrp and hum.Health > 0 and not Players:GetPlayerFromCharacter(model) then
                            local d = (hrp.Position - rootPart.Position).Magnitude
                            if d < best then
                                best, closest = d, model
                            end
                        end
                    end
                end

                if closest then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local tgtHrp = closest:FindFirstChild("HumanoidRootPart")
                    if hrp and tgtHrp then
                        hrp.CFrame = tgtHrp.CFrame * OFFSET
                    end
                end
            end)
        else
            pcall(function()
                RunService:UnbindFromRenderStep("TP")
            end)
        end
    end
})

local DeathLaser = false
Tabs.maincontent:Toggle({
    Title = "死亡激光",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
      if Value then
        DeathLaser = true
        while DeathLaser do
            wait(0.000001)
            game:GetService("ReplicatedStorage"):WaitForChild("VillanArcGasterBlaster"):FireServer()
       end
      else
        DeathLaser = false
      end
    end
})


local SirenTitanSet = game:GetService("ReplicatedStorage"):FindFirstChild("SirenTitanSet")
if not SirenTitanSet then return end

local gui = Instance.new("ScreenGui")
gui.Name = "SkillButtons"
gui.Parent = gethui()
gui.ResetOnSpawn = false
gui.Enabled = false -- 默认隐藏

-- 容器 (往右30)
local dock = Instance.new("Frame")
dock.Size = UDim2.new(0, 70, 0, 200)
dock.Position = UDim2.new(1, -405, 1, -220)
dock.BackgroundTransparency = 1
dock.Parent = gui

local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Vertical
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.Padding = UDim.new(0, 10)
layout.Parent = dock

-- 技能列表
local skills = {"CresentSlash", "Leap", "SoulPunch"}
local icons = {"🌙", "⬆️", "👊"}

-- 创建按钮
for i, name in ipairs(skills) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(60, 70, 90)
    btn.Text = icons[i]
    btn.TextSize = 24
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.Parent = dock
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        SirenTitanSet:FireServer({ Skill = name })
    end)
    
    btn.TouchTap:Connect(function()
        SirenTitanSet:FireServer({ Skill = name })
    end)
end

-- 放入 Toggle
Tabs.maincontent:Toggle({
    Title = "赛壬技能",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
        if Value then
            gui.Enabled = true  -- 显示
        else
            gui.Enabled = false -- 隐藏
        end
    end
})

local Automaticinteraction = false
Tabs.maincontent:Toggle({
    Title = "自动拾取",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
      if Value then
          Automaticinteraction = true
          while Automaticinteraction do
          wait(0.000001)
              for i,d in pairs(game:GetService("Workspace"):GetDescendants()) do
                if d.ClassName == 'ProximityPrompt' then
                   fireproximityprompt(d)
                end
              end
          end
      else
          Automaticinteraction = false
      end
    end
})

local Autoreset = false
Tabs.maincontent:Toggle({
    Title = "自动重置",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
      if Value then
          Autoreset = true
          while Autoreset do
          wait(0.0000000001)
             if game.Players.LocalPlayer.Character.Humanoid.Health < 500 then
                reset()
             end
          end
      else
          Autoreset = false
      end
    end
})

local crosshair = false
Tabs.maincontent:Toggle({
    Title = "准心调整",
    --Image = "bird",
    Value = false,
    Flag = "crosshair",
    Callback = function(state)
        if state then
            crosshair = true
            while crosshair do
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
                local ShiftLock = PlayerGui:WaitForChild("ShiftLock")
                local MiddleIcon = ShiftLock.Frame:WaitForChild("MiddleIcon")
                MiddleIcon.Size = UDim2.new(0.0200000033, 0, 0.204999968, 0)
                MiddleIcon.Position = UDim2.new(0.5, 0, 0.5, 0) 
                wait(0.1)
            end
        else
            crosshair = false
        end
    end
})

local function startESPSystem(targetName, displayName, switch, location)
    local function createESPLabelForTarget(target)
        if not target then return end
        
        local hasESP = false
        for _, child in ipairs(target:GetChildren()) do
            if child:IsA("BillboardGui") and child.Name == "ESPBillboard" then
                hasESP = true
                break
            end
        end
        
        if not hasESP then
            local billboardGui = Instance.new("BillboardGui")
            billboardGui.Name = "ESPBillboard"
            billboardGui.Size = UDim2.new(0, 200, 0, 50)
            billboardGui.AlwaysOnTop = true
            billboardGui.Adornee = target
            billboardGui.Parent = target
            
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "ESPText"
            textLabel.Text = displayName
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextSize = 20
            textLabel.TextColor3 = Color3.new(1, 0, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.Parent = billboardGui
            
            WindUI:Notify({
                Title = displayName .. "出现",
                Content = nil,
                Duration = 5,
            })
        end
    end

    while switch.Value do
        local parent = workspace
        if location and location ~= "" then
            for _, part in ipairs(string.split(location, ".")) do
                if parent then
                    parent = parent:FindFirstChild(part)
                else
                    break
                end
            end
        end
        
        if parent then
            for _, obj in ipairs(parent:GetChildren()) do
                if obj.Name == targetName then
                    createESPLabelForTarget(obj)
                end
            end
        end
        wait(0.01)
    end
end

local espGroups = {
    {
        title = "闪光U盘",
        items = {
            {display = "U盘1", target = "Flash Drive #1"},
            {display = "U盘2", target = "Flash Drive #2"},
            {display = "U盘3", target = "Flash Drive #3"},
            {display = "U盘4", target = "Flash Drive #4"},
            {display = "U盘5", target = "Flash Drive #5"},
            {display = "U盘6", target = "Flash Drive #6"},
            {display = "门禁卡", target = "Keycard"},
        }
    },
    {
        title = "紫色U盘",
        items = {
            {display = "U盘A", target = "Drive #A"},
            {display = "U盘B", target = "Drive #B"},
            {display = "U盘C", target = "Drive #C"},
            {display = "U盘D", target = "Drive #D"},
            {display = "U盘E", target = "Drive #E"},
            {display = "前置条件U盘", target = "Drive #SdFE0"},
        }
    },
    {
        title = "其他材料",
        items = {
            {display = "灯光模块", target = "Lighting Module"},
            {display = "18球", target = "X18 Core"},
            {display = "魔方", target = "Energy Core Base"},
            {display = "绿罐", target = "Green Core Energy"},
            {display = "时钟蜘蛛", target = "Clock Spider"},
        }
    },
    {
        title = "马桶侦查",
        location = "Living",
        items = {
            {display = "雷达", target = "Transmitter toilet"},
        }
    },
}

for _, group in ipairs(espGroups) do
    for _, item in ipairs(group.items) do
        item.switch = { Value = false }
    end
end

for _, group in ipairs(espGroups) do
    local values = {}
    for _, item in ipairs(group.items) do
        table.insert(values, item.display)
    end

    Tabs.maincontent:Dropdown({
        Title = group.title,
        Values = values,
        Value = {},
        Multi = true,
        AllowNone = true,
        Callback = function(option)
            for _, item in ipairs(group.items) do
                local selected = table.find(option, item.display) ~= nil
                if selected and not item.switch.Value then
                    item.switch.Value = true
                    task.spawn(function() startESPSystem(item.target, item.display, item.switch, group.location) end)
                elseif not selected and item.switch.Value then
                    item.switch.Value = false
                end
            end
        end
    })
end

Tabs.maincontent:Button({
	Title = "去除迷雾",
    Callback = function()
           game:GetService("Lighting").Atmosphere:Destroy()
    end
})


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SkinFolders = ReplicatedStorage.SkinFolders

-- 获取品质（中文）
local function getGrade(modelName)
    if not modelName or modelName == "" then return "空" end
    local folder = SkinFolders:FindFirstChild(modelName)
    if folder then
        local grade = folder:FindFirstChild("Grade")
        if grade then
            local map = {
                Mythical = "神话",
                Legendary = "传奇",
                Epic = "精品",
                Rare = "稀有",
                Common = "普通"
            }
            return map[grade.Value] or grade.Value
        end
    end
    return "未知"
end

-- 获取显示名称
local function getDisplayName(modelName)
    if not modelName or modelName == "" then return "无" end
    local folder = SkinFolders:FindFirstChild(modelName)
    if folder then
        local skinName = folder:FindFirstChild("Skin-Name")
        if skinName then return skinName.Value end
    end
    return modelName
end

-- 更新显示
local function updateDisplay(paragraph)
    local leftName, leftGrade = getDisplayName(ReplicatedStorage["Left GachaSkin"].Value), getGrade(ReplicatedStorage["Left GachaSkin"].Value)
    local midName, midGrade = getDisplayName(ReplicatedStorage["Mid GachaSkin"].Value), getGrade(ReplicatedStorage["Mid GachaSkin"].Value)
    local rightName, rightGrade = getDisplayName(ReplicatedStorage["Right GachaSkin"].Value), getGrade(ReplicatedStorage["Right GachaSkin"].Value)
    
    local desc = string.format(
        "左: %s [%s]\n中: %s [%s]\n右: %s [%s]",
        leftName, leftGrade,
        midName, midGrade,
        rightName, rightGrade
    )
    paragraph:SetDesc(desc)
end

-- 创建Paragraph
local paragraph = Tabs.maincontent:Paragraph({
    Title = "皮肤刷新",
    Desc = "加载中..."
})

-- 监听三个槽位
for _, slot in ipairs({
    ReplicatedStorage["Left GachaSkin"],
    ReplicatedStorage["Mid GachaSkin"],
    ReplicatedStorage["Right GachaSkin"]
}) do
    slot.Changed:Connect(function() updateDisplay(paragraph) end)
end

-- 立即更新
updateDisplay(paragraph)


--远程商店

Tabs.Remotestore:Button({
    Title = "返回大厅",
    Desc = nil,
    Callback = function() 
     local HumanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
     HumanoidRootPart.CFrame = CFrame.new(2000000, 1000, 2000)
    end
})

local shop = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("003-A")
Tabs.Remotestore:Toggle({
    Title = "商店",
    Desc = nil,
    Value = false,
    Callback = function(Value)
        if Value then
          shop.Enabled = true
        else
          shop.Enabled = false
        end
    end
}, "Toggle")

Tabs.Remotestore:Section({ 
    Title = "购买栏",
    TextXAlignment = "Left",
    TextSize = 17,
})


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local function buyItem(itemName, CharacterType)
    local PlayerValues = LocalPlayer:WaitForChild("PlayerValues")
    local CharacterValue = PlayerValues:WaitForChild("Character")
    local initialCharacterValue = CharacterValue.Value

    ForChangeCharacter:FireServer(CharacterType, 0)
    ShopSystem:FireServer("Buy", itemName)
    ForChangeCharacter:FireServer(initialCharacterValue, 0)
end

local itemButtons = {
    {Title = "脉冲步枪", Desc = nil, ItemName = "Pulse Rifle", CharacterType = "Camera man"},
    {Title = "眼镜", Desc = nil, ItemName = "Lens", CharacterType = "Camera man"},
    {Title = "喷气背包", Desc = nil, ItemName = "Jetpack", CharacterType = "Camera man"},
    {Title = "铠甲", Desc = nil, ItemName = "Armor", CharacterType = "Camera man"},
    {Title = "耳机", Desc = nil, ItemName = "HeadPhone", CharacterType = "Camera man"},
    {Title = "EPD", Desc = nil, ItemName = "EPD", CharacterType = "Camera man"},
    {Title = "快速po枪", Desc = nil, ItemName = "Shot Harpoon Gun", CharacterType = "Camera man"},
    {Title = "镭射激光炮", Desc = nil, ItemName = "Large Laser Gun", CharacterType = "Big Camera man"},
    {Title = "散弹枪", Desc = nil, ItemName = "Shot Gun", CharacterType = "Camera man"},
    {Title = "天文步枪", Desc = nil, ItemName = "Astro Blaster", CharacterType = "Camera man"},
    {Title = "天文电枪", Desc = nil, ItemName = "Tazer Gun", CharacterType = "Camera man"},
    {Title = "天文狙击枪", Desc = nil, ItemName = "Tazer Sniper", CharacterType = "Camera man"},
    {Title = "天文双管枪", Desc = nil, ItemName = "Dual Barrel Blaster", CharacterType = "Big Camera man"},
    {Title = "大剑", Desc = nil, ItemName = "Saw Blade", CharacterType = "Big Camera man"},
}

for _, buttonData in ipairs(itemButtons) do
    Tabs.Remotestore:Button({
        Title = buttonData.Title,
        Desc = buttonData.Desc,
        Callback = function() buyItem(buttonData.ItemName, buttonData.CharacterType) end
    })
end

Tabs.Remotestore:Section({ 
    Title = "子弹栏",
    TextXAlignment = "Left",
    TextSize = 17,
})

local function AmmoShopSystem(times, weapon)
    for _ = 1, times do
        ShopSystem:FireServer("Ammo", LocalPlayer.Character:WaitForChild(weapon))
    end
end

Tabs.Remotestore:Button({
	Title = "散弹枪子弹(10次)",
	Desc = nil,
    Callback = function()
         AmmoShopSystem(10, "Dual Shot Gun")
    end
})

Tabs.Remotestore:Button({
	Title = "快速po枪子弹(10次)",
	Desc = nil,
    Callback = function()
        AmmoShopSystem(10, "Shot Harpoon Gun")
    end
})

--切换角色

Tabs.switchroles:Button({
    Title = "重置角色",
    Desc = nil,
    Locked = false,
    Callback = function()
     reset()
    end
})

local player = game:GetService("Players").LocalPlayer

local function updateDisplay(para)
    local char = player.PlayerValues.Character.Value or "无"
    local normal = player.PlayerValues.NormalTitan.Value or "无"
    local special = player.PlayerValues.SpecialTitan.Value or "无"
    para:SetDesc(string.format("角色: %s\n普通泰坦: %s\n特殊泰坦: %s", char, normal, special))
end

local para = Tabs.switchroles:Paragraph({Title = "当前角色", Desc = "加载中..."})

for _, v in ipairs({player.PlayerValues.Character, player.PlayerValues.NormalTitan, player.PlayerValues.SpecialTitan}) do
    v:GetPropertyChangedSignal("Value"):Connect(function() updateDisplay(para) end)
end

updateDisplay(para)


--[[
local function functionSetTitle(name, Button)
     Button:SetTitle(name)
end

local AllCharacterModels = Tabs.switchroles:Section({
    Title = "展示模型",
    Box = true,
})

local cloneTable = {}

if game:GetService("ReplicatedStorage"):FindFirstChild("PlayableCharacter") then
    local PlayableCharacter = game:GetService("ReplicatedStorage").PlayableCharacter
    for _, original in pairs(PlayableCharacter:GetChildren()) do
        task.wait()
        if original:IsA("Model") then
            local btn = AllCharacterModels:Button({
                Title = original.Name,
                Callback = function()
                    local ex = cloneTable[original]
                    if ex and ex.Parent then
                        ex:Destroy()
                        cloneTable[original] = nil
                    else
                        local c = original:Clone()
                        c.Name = original.Name .. "（克隆体）"
                        c.Parent = workspace:WaitForChild("Living")
                        c:PivotTo(game.Players.LocalPlayer.Character:GetPivot())
                        cloneTable[original] = c
                    end
                end
            })
        end
    end
end

if game:GetService("ReplicatedStorage").SkinFolders then
    local PlayableCharacterskin = game:GetService("ReplicatedStorage").SkinFolders
    for _, original in pairs(PlayableCharacterskin:GetChildren()) do
        task.wait()
        if original:IsA("Model") then
            local btn = AllCharacterModels:Button({
                Title = original.Name,
                Callback = function()
                    local ex = cloneTable[original]
                    if ex and ex.Parent then
                        ex:Destroy()
                        cloneTable[original] = nil
                    else
                        local c = original:Clone()
                        c.Name = original.Name .. "（克隆体）"
                        c.Parent = workspace:WaitForChild("Living")
                        c:PivotTo(game.Players.LocalPlayer.Character:GetPivot())
                        cloneTable[original] = c
                    end
                end
            })
        end
    end
end
]]


Tabs.switchroles:Section({ 
    Title = "常用角色",
    TextXAlignment = "Left",
    TextSize = 13,
})

local function Commonroles(Role, skin, name)
 Tabs.switchroles:Button({
    Title = name,
    Desc = nil,
    Locked = false,
    Callback = function()
       local args = {Role, skin}
       game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
       WindUI:Notify({Title = "切换提示", Content = "成功切换:" .. name, Duration = 3})
    end
 })
end

local Commonroles_Buttons = {
    {name = "神话反派", Desc = nil, Role = "Brown Camera man", skin = 1},
    {name = "女三体", Desc = nil, Role = "Tri Soldier Athena (Girl)", skin = 0},
    {name = "黑音响", Desc = nil, Role = "Dark Speakerman", skin = nil},
    {name = "首席时钟", Desc = nil, Role = "Clock Man", skin = 0},
    {name = "迷你utc", Desc = nil, Role = "Jetpacked Double plunger", skin = 4},
    {name = "工程师", Desc = nil, Role = "Engineer Camera Man", skin = 0},
    {name = "亡灵法师", Desc = nil, Role = "Head Captain Of The CCTV", skin = 0},
    {name = "天文大电视", Desc = nil, Role = "Astro Large TV man", skin = 1},
    {name = "大时钟", Desc = nil, Role = "Large Clock Man", skin = 0},
}

for _, v in ipairs(Commonroles_Buttons) do
    Commonroles(v.Role, v.skin, v.name)
end

local Hasallrole = Tabs.switchroles:Section({ 
    Title = "拥有角色",
    TextXAlignment = "Left",
    TextSize = 13,
})

getfenv().ChangeCharacterskinvalue = 0

Hasallrole:Input({
    Title = "皮肤值",
    Desc = "角色皮肤按顺序输入数字",
    Value = "",
    Type = "Input", 
    Placeholder = "请输入数字",
    Callback = function(input) 
        getfenv().ChangeCharacterskinvalue = input
    end
})

if game:GetService("Players").LocalPlayer:FindFirstChild("UnlockData") then
    local UnlockData = game:GetService("Players").LocalPlayer.UnlockData
    for _, stringValue in pairs(UnlockData:GetChildren()) do
        Hasallrole:Button({
            Title = stringValue.Name,
            Desc = nil,
            Callback = function()
                local args = {stringValue.Name, getfenv().ChangeCharacterskinvalue}
                game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
                WindUI:Notify({Title = "切换提示", Content = "成功切换:" .. stringValue.Name, Duration = 3})
        end})
    end
else
Tabs.switchroles:Button({Title = "错误", Desc = "你角色还没加载完", Callback = function() end})
end


--UI页面

Tabs.playergui:Toggle({
    Title = "天文货币",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
        if Value then
          game:GetService("Players").LocalPlayer.PlayerGui.AstroScrap.Enabled = true
        else
           game:GetService("Players").LocalPlayer.PlayerGui.AstroScrap.Enabled = false
        end
    end
}, "Toggle")

Tabs.playergui:Toggle({
    Title = "背包",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
        if Value then
          game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Enabled = true
        else
          game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Enabled = false
        end
    end
}, "Toggle")

Tabs.playergui:Section({ 
    Title = "泰坦装备",
    TextXAlignment = "Left",
    TextSize = 13,
})

local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
if game:GetService("Players").LocalPlayer:FindFirstChild("UnlockData") then


    local function toggleGuiElement(Element)
        local targetParent = PlayerGui:FindFirstChild("003-A")
        local element = PlayerGui:FindFirstChild(Element)
        if targetParent and element then
            element.Parent = targetParent
            targetParent:FindFirstChild(Element).Enabled = true
        end
    end

    local function toggleGuiElement2(Element)
        local targetParent = PlayerGui:FindFirstChild("003-A")
        local element = targetParent:FindFirstChild(Element)
        if targetParent and element then
            element.Enabled = false
            element.Parent = PlayerGui
        end
    end


    Tabs.playergui:Toggle({
        Title = "uttv",
        Desc = nil,
        Value = false,
        Callback = function(Value)
           if Value then
               toggleGuiElement("UpgradeTVShop")
           else
               toggleGuiElement2("UpgradeTVShop")
           end
        end
    }, "Toggle")

    Tabs.playergui:Toggle({
        Title = "utc",
        Desc = nil,
        Value = false,
        Callback = function(Value)
            if Value then
                toggleGuiElement("UpgradeCameraShop")
            else
                toggleGuiElement2("UpgradeCameraShop")
            end
        end
    }, "Toggle")

    Tabs.playergui:Toggle({
        Title = "uts",
        Desc = nil,
        Value = false,
        Callback = function(Value)
            if Value then
                toggleGuiElement("ConfirmUTSM")
            else
                toggleGuiElement2("ConfirmUTSM")
            end
        end
    }, "Toggle")

end


WindUI:Notify({Title = "加载完毕，耗时:" .. string.format("%.1f", os.clock() - t0), Duration = 3,})