if run == true then
  error("中断")
end
pcall(function() getgenv().run = true end)

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local t0 = os.clock()   --计时

--编辑
local Window = WindUI:CreateWindow({
    Title = "标题",
    Icon = "app-window",
    Resizable = false,
    Size = UDim2.fromOffset(580, 380),
    Transparent = true,
    HideSearchBar = false,
    SideBarWidth = 140,
    KeySystem = { 
        Key = { "USB" },
        Note = "密码会被保存，下次无需输入",
        SaveKey = true,
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

Window:DisableTopbarButtons({
    "Close", 
    "Fullscreen",
})

local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
if PlayerGui:FindFirstChild("003-A") then
     _G.Lockedgame = false
else
     _G.Lockedgame = true
end

--左边选择
local Tabs = {
   Announcement_Updates = Window:Tab({ Title = "须知事项", Icon = "solar:home-2-bold", }),
   genericscript = Window:Tab({ Title = "通用脚本", Icon = "solar:password-minimalistic-input-bold", }),
   STBB = Window:Section({Title = "封锁战线", Opened = true, }),
   maincontent = Window:Tab({ Title = "主要内容", Icon = "solar:check-square-bold", Locked = _G.Lockedgame, }),
   Remotestore = Window:Tab({ Title = "远程商店", Icon = "solar:cursor-square-bold", Locked = _G.Lockedgame, }),
   switchroles = Window:Tab({ Title = "切换角色", Icon = "solar:square-transfer-horizontal-bold",Locked = _G.Lockedgame, }),
   playergui = Window:Tab({ Title = "页面类别", Icon = "solar:hamburger-menu-bold", Locked = _G.Lockedgame, }),
}



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

local con1
Tabs.genericscript:Toggle({
 Title = "秒杀",
 Desc = nil,
 Value = false,
 Locked = false,
 Callback = function(a)
    if a then
		con1 = rs.Stepped:Connect(function()
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
	else
		if con1 then
			con1:Disconnect()
			con1 = nil
		end
	end
 end
})

local rad = 150
rs.RenderStepped:Connect(function()
	if sethiddenproperty then
		sethiddenproperty(lp,"SimulationRadius",rad)
	else
		lp.SimulationRadius=rad
	end
end)


_G.speedtrue = false
_G.speedvalue = 6
game:GetService('RunService').RenderStepped:connect(function()
  if _G.speedtrue == true then
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.speedvalue
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
       _G.speedtrue = Value
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
        _G.speedvalue = value
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

local Playersize = Tabs.genericscript:Section({ 
    Title = "玩家体积",
    Box = true,
})

Playersize:Toggle({
    Title = "玩家体积",
    Desc = "",
    Value = false,
    Callback = function(Value)
       _G.collisionscript = Value
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
        _G.HeadSize = value
    end
})

Tabs.genericscript:Button({
    Title = "rejoin",
    Desc = nil,
    Callback = function()
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
})


local allplayergui = Tabs.genericscript:Section({ 
    Title = "全部页面",
    Box = true,
})

if game:GetService("Players").LocalPlayer.PlayerGui then
    local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
    for _, stringValue in pairs(PlayerGui:GetChildren()) do
        if stringValue:IsA("ScreenGui") then
            if stringValue.Enabled == false then
                allplayergui:Toggle({
                     Title = stringValue.Name,
                     Value = false,
                     Callback = function(Value)
                          if Value then
                               stringValue.Enabled = true
                          else
                               stringValue.Enabled = false
                          end
                    end
                }, "Toggle")
            else
                allplayergui:Toggle({
                     Title = stringValue.Name,
                     Value = true,
                     Callback = function(Value)
                          if Value then
                               stringValue.Enabled = true
                          else
                               stringValue.Enabled = false
                          end
                    end
                }, "Toggle")                
            end    
        end
    end
end

local textreplacement = Tabs.genericscript:Section({Title = "文本替换", Box = true})

_G.KEY1 = game.Players.LocalPlayer.DisplayName
_G.KEY2 = game.Players.LocalPlayer.Name
_G.REPLACE_WITH = "InvalidText"

textreplacement:Input({
    Title = "文本1",
    Desc = "你的名称:" .. game.Players.LocalPlayer.DisplayName,
    Value = game.Players.LocalPlayer.DisplayName,
    InputIcon = "bird",
    Type = "Input",
    Placeholder = "请输入文本...",
    Callback = function(input)
        _G.KEY1 = input
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
        _G.KEY2 = input
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
        _G.REPLACE_WITH = input
    end
})

textreplacement:Button({
    Title = "确认",
    Desc = "会卡顿零点几秒",
    Callback = function()
        local CASE_SENSITIVE = true
        local cmp = CASE_SENSITIVE and function(s) return s end or function(s) return s:lower() end
        local key1 = cmp(_G.KEY1 or "")
        local key2 = cmp(_G.KEY2 or "")
        local replaceText = _G.REPLACE_WITH or "InvalidText"
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

function reset()
    local player = game:GetService("Players").LocalPlayer
    if workspace:FindFirstChild("Living") and player and player.Character then
        replicatesignal(game:GetService("Players").LocalPlayer.Kill)
    end
end


--窗口顶部按钮
Window:CreateTopbarButton("重置角色", "bird",    function() reset() end,  990)



--主要内容


Tabs.maincontent:Button({
    Title = "重置角色",
    Desc = nil,
    Locked = false,
    Callback = function()
     reset()
    end
})


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local LivingFolder = workspace:WaitForChild("Living")
local MAX_DIST = 5000
local OFFSET = CFrame.new(0, 3, 0)

Tabs.maincontent:Toggle({
    Title = "传送最近马桶",
    Desc = nil,
    Locked = false,
    Value = false,
    Callback = function(Value)
        if Value then
            RunService:BindToRenderStep("TP", 1, function()
                local rootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
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
            RunService:UnbindFromRenderStep("TP")
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
    Values = { "U盘A", "U盘B", "U盘C", "U盘D", "U盘E", "前置条件U盘"},
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
        
        if table.find(option, "U盘E") then
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

local positioningLightingModule = { Value = false }
local positioningX18Core = { Value = false }
local positioningGreenCoreEnergy = { Value = false }
local positioningEnergyCoreBase = { Value = false }
local clockspider = { Value = false}
Tabs.maincontent:Dropdown({
    Title = "其他材料",
    Values = { "灯光模块", "18球", "魔方", "绿罐", "时钟蜘蛛" },
    Value = {},
    Multi = true,
    AllowNone = true,
    Callback = function(option) 
        if table.find(option, "灯光模块") then
            positioningLightingModule.Value = true
            task.spawn(function() startESPSystem("Lighting Module", "灯光模块", positioningLightingModule) end)
        else
            positioningLightingModule.Value = false
        end
      
        if table.find(option, "18球") then
            positioningX18Core.Value = true
            task.spawn(function() startESPSystem("X18 Core", "x18球", positioningX18Core) end)
        else
            positioningX18Core.Value = false
        end
      
        if table.find(option, "魔方") then
            positioningEnergyCoreBase.Value = true
            task.spawn(function() startESPSystem("Energy Core Base", "魔方", positioningEnergyCoreBase) end)
        else
            positioningEnergyCoreBase.Value = false
        end
        
        if table.find(option, "绿罐") then
            positioningGreenCoreEnergy.Value = true
            task.spawn(function() startESPSystem("Green Core Energy", "绿罐", positioningGreenCoreEnergy) end)
        else
            positioningGreenCoreEnergy.Value = false
        end
        
        if table.find(option, "时钟蜘蛛") then
            clockspider.Value = true
            task.spawn(function() startESPSystem("Clock Spider", "时钟蜘蛛", clockspider) end)
        else
            clockspider.Value = false
        end
    end
})

Tabs.maincontent:Button({
	Title = "去除迷雾",
    Callback = function()
           game:GetService("Lighting").Atmosphere:Destroy()
    end
})

--远程商店

Tabs.Remotestore:Button({
    Title = "返回大厅",
    Desc = nil,
    Callback = function() 
     local HumanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
     HumanoidRootPart.CFrame = CFrame.new(2000, 1000, 2000)
    end
})


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

Tabs.switchroles:Section({ 
    Title = "常用角色",
    TextXAlignment = "Left",
    TextSize = 13,
})


local function WindUINotify(part)
      WindUI:Notify({Title = "切换提示", Content = "成功切换:" .. part, Duration = 5})
end

Tabs.switchroles:Button({
    Title = "神话反派",
    Desc = nil,
    Locked = false,
    Callback = function()
       local args = {"Brown Camera man", 1}
       game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
       WindUINotify("Brown Camera man")
    end
})

Tabs.switchroles:Button({
    Title = "女三体",
    Desc = nil,
    Locked = false,
    Callback = function()
       local args = {"Tri Soldier Athena (Girl)", 0}
       game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
       WindUINotify("Tri Soldier Athena (Girl)")
    end
})

Tabs.switchroles:Button({
    Title = "黑音响",
    Desc = nil,
    Locked = false,
    Callback = function()
       local args = {"Dark Speakerman", 2}
       game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
       WindUINotify("Dark Speakerman")
    end
})

Tabs.switchroles:Button({
    Title = "首席时钟",
    Desc = nil,
    Locked = false,
    Callback = function()
       local args = {"Clock Man", 0}
       game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
       WindUINotify("Clock Man")
    end
})

Tabs.switchroles:Section({ 
    Title = "拥有角色",
    TextXAlignment = "Left",
    TextSize = 13,
})

_G.ChangeCharacterskinvalue = 0

Tabs.switchroles:Input({
    Title = "皮肤值",
    Desc = "角色皮肤按顺序输入数字",
    Value = "",
    Type = "Input", 
    Placeholder = "请输入数字",
    Callback = function(input) 
        _G.ChangeCharacterskinvalue = input
    end
})

if game:GetService("Players").LocalPlayer:FindFirstChild("UnlockData") then
    local UnlockData = game:GetService("Players").LocalPlayer.UnlockData
    for _, stringValue in pairs(UnlockData:GetChildren()) do
        Tabs.switchroles:Button({
            Title = stringValue.Name,
            Desc = nil,
            Callback = function()
                local args = {stringValue.Name, _G.ChangeCharacterskinvalue}
                game:GetService("ReplicatedStorage"):WaitForChild("ForChangeCharacter"):FireServer(unpack(args))
                WindUINotify(stringValue.Name)
            end})
    end
else
Tabs.switchroles:Button({Title = "错误", Desc = "没角色是吧", Callback = function() end})
end


--UI页面

if game:GetService("Players").LocalPlayer:FindFirstChild("UnlockData") then
Tabs.playergui:Toggle({
    Title = "商店",
    Desc = nil,
    Value = false,
    Callback = function(Value)
        if Value then
          game:GetService("Players").LocalPlayer.PlayerGui["003-A"].Enabled = true
        else
          game:GetService("Players").LocalPlayer.PlayerGui["003-A"].Enabled = false
        end
    end
}, "Toggle")
end


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

WindUINotify("运行完毕，耗时:" .. os.clock() - t0)