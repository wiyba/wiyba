local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BX Hub",
   LoadingTitle = "BX Hub",
   LoadingSubtitle = "By BX_Team",
   Theme = "Default",
   DisableRayfieldPrompts = true,
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = nil
   },
   KeySystem = false,
   WindowSize = Vector2.new(500, 700),
   OpenCloseKey = Enum.KeyCode.RightControl
})

local UniversalTab = Window:CreateTab("Universal", 92875681906793)
local HubsTab = Window:CreateTab("Hubs", 13518130183)
local GamesTab = Window:CreateTab("Games", 11894535915)
local SettingsTab = Window:CreateTab("Settings", 4483345998)
local Connections = {
   InfiniteJump = nil,
   Noclip = nil,
   LoopSpeed = nil,
   LoopJumpPower = nil,
   Fly = nil
}
local Lighting = game:GetService("Lighting")
local origSettings = {
   Brightness = Lighting.Brightness,
   ClockTime = Lighting.ClockTime,
   FogEnd = Lighting.FogEnd,
   FogStart = Lighting.FogStart,
   GlobalShadows = Lighting.GlobalShadows,
   OutdoorAmbient = Lighting.OutdoorAmbient,
   Ambient = Lighting.Ambient
}
local BrightLoop = nil
local defaultSpeed = 16
local defaultJumpPower = 50
local speedValue = 16
local jumpPowerValue = 50
local ScriptsCategory = UniversalTab:CreateSection("Scripts")

UniversalTab:CreateButton({
   Name = "Orca",
   SectionParent = ScriptsCategory,
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()
   end
})

UniversalTab:CreateButton({
   Name = "Infinite Yield",
   SectionParent = ScriptsCategory,
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end
})

local UtilitiesCategory = UniversalTab:CreateSection("Utilities")

UniversalTab:CreateToggle({
   Name = "Speed",
   CurrentValue = false,
   Flag = "LoopSpeedToggle",
   Callback = function(State)
      if State then
         Connections.LoopSpeed = game:GetService("RunService").Stepped:Connect(function()
            local p = game.Players.LocalPlayer
            local c = p.Character
            local h = c and c:FindFirstChildWhichIsA("Humanoid")
            if h then
               h.WalkSpeed = speedValue
            end
         end)
      else
         if Connections.LoopSpeed then
            Connections.LoopSpeed:Disconnect()
            Connections.LoopSpeed = nil
         end
         local p = game.Players.LocalPlayer
         local c = p.Character
         local h = c and c:FindFirstChildWhichIsA("Humanoid")
         if h then
            h.WalkSpeed = defaultSpeed
         end
      end
   end
})

UniversalTab:CreateToggle({
   Name = "Jump Power",
   CurrentValue = false,
   Flag = "LoopJumpPowerToggle",
   Callback = function(State)
      if State then
         Connections.LoopJumpPower = game:GetService("RunService").Stepped:Connect(function()
            local p = game.Players.LocalPlayer
            local c = p.Character
            local h = c and c:FindFirstChildWhichIsA("Humanoid")
            if h then
               h.UseJumpPower = true
               h.JumpPower = jumpPowerValue
            end
         end)
      else
         if Connections.LoopJumpPower then
            Connections.LoopJumpPower:Disconnect()
            Connections.LoopJumpPower = nil
         end
         local p = game.Players.LocalPlayer
         local c = p.Character
         local h = c and c:FindFirstChildWhichIsA("Humanoid")
         if h then
            h.UseJumpPower = true
            h.JumpPower = defaultJumpPower
         end
      end
   end
})

UniversalTab:CreateToggle({
   Name = "Full Bright",
   CurrentValue = false,
   Flag = "FullBrightToggle",
   Callback = function(State)
      if State then
         local function applyFullBright()
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
         end
         applyFullBright()
         BrightLoop = game:GetService("RunService").RenderStepped:Connect(applyFullBright)
      else
         if BrightLoop then
            BrightLoop:Disconnect()
            BrightLoop = nil
         end
         Lighting.Brightness = origSettings.Brightness
         Lighting.ClockTime = origSettings.ClockTime
         Lighting.FogEnd = origSettings.FogEnd
         Lighting.FogStart = origSettings.FogStart
         Lighting.GlobalShadows = origSettings.GlobalShadows
         Lighting.OutdoorAmbient = origSettings.OutdoorAmbient
         Lighting.Ambient = origSettings.Ambient
      end
   end
})

UniversalTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJumpToggle",
   Callback = function(State)
      if State then
         Connections.InfiniteJump = game:GetService("UserInputService").JumpRequest:Connect(function()
            local p = game.Players.LocalPlayer
            local c = p.Character
            local h = c and c:FindFirstChildWhichIsA("Humanoid")
            if h then
               h:ChangeState(Enum.HumanoidStateType.Jumping)
            end
         end)
      else
         if Connections.InfiniteJump then
            Connections.InfiniteJump:Disconnect()
            Connections.InfiniteJump = nil
         end
      end
   end
})

UniversalTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(State)
      if State then
         Connections.Noclip = game:GetService("RunService").Stepped:Connect(function()
            local p = game.Players.LocalPlayer
            local c = p.Character
            if c then
               for _, part in ipairs(c:GetDescendants()) do
                  if part:IsA("BasePart") and part.CanCollide then
                     part.CanCollide = false
                  end
               end
            end
         end)
      else
         if Connections.Noclip then
            Connections.Noclip:Disconnect()
            Connections.Noclip = nil
         end
      end
   end
})

UniversalTab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(State)
      if State then
         local p = game.Players.LocalPlayer
         local c = p.Character or p.CharacterAdded:Wait()
         local root = c:WaitForChild("HumanoidRootPart")
         Connections.Fly = game:GetService("RunService").RenderStepped:Connect(function()
            if root then
               root.Anchored = true
               local v = Vector3.new(0,0,0)
               local uis = game:GetService("UserInputService")
               if uis:IsKeyDown(Enum.KeyCode.W) then
                  v = v + root.CFrame.LookVector
               end
               if uis:IsKeyDown(Enum.KeyCode.S) then
                  v = v - root.CFrame.LookVector
               end
               if uis:IsKeyDown(Enum.KeyCode.A) then
                  v = v - root.CFrame.RightVector
               end
               if uis:IsKeyDown(Enum.KeyCode.D) then
                  v = v + root.CFrame.RightVector
               end
               if uis:IsKeyDown(Enum.KeyCode.Space) then
                  v = v + Vector3.new(0,1,0)
               end
               if uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                  v = v - Vector3.new(0,1,0)
               end
               root.CFrame = root.CFrame + v * 0.6
            end
         end)
      else
         if Connections.Fly then
            Connections.Fly:Disconnect()
            Connections.Fly = nil
         end
         local p = game.Players.LocalPlayer
         local c = p.Character
         local root = c and c:FindFirstChild("HumanoidRootPart")
         if root then
            root.Anchored = false
         end
      end
   end
})

HubsTab:CreateSection("Scripts")

HubsTab:CreateButton({
   Name = "Kncrypt Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/Loader.lua"))()
   end
})

HubsTab:CreateButton({
   Name = "Speed Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
   end
})

GamesTab:CreateSection("Scripts")

GamesTab:CreateButton({
   Name = "Doors",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/KINGHUB01/BlackKing-obf/main/Doors%20Blackking%20And%20BobHub"))()
   end
})

GamesTab:CreateButton({
   Name = "Pressure",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Fire-Hub/main/Loader"))()
   end
})

SettingsTab:CreateSection("Settings")

SettingsTab:CreateSlider({
   Name = "Speed",
   Range = {2, 60},
   Increment = 1,
   Suffix = " Studs",
   CurrentValue = speedValue,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      speedValue = Value
   end
})

SettingsTab:CreateSlider({
   Name = "Jump",
   Range = {2, 120},
   Increment = 5,
   Suffix = " Power",
   CurrentValue = jumpPowerValue,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      jumpPowerValue = Value
   end
})

SettingsTab:CreateSection("Binds")

SettingsTab:CreateKeybind({
   Name = "Toggle Noclip",
   CurrentKeybind = Enum.KeyCode.Q,
   Flag = "NoclipKeybind",
   Callback = function()
      local tog = Rayfield.Flags["NoclipToggle"]
      if tog then
         tog:Set(not tog.CurrentValue)
      end
   end
})

SettingsTab:CreateKeybind({
   Name = "Toggle Fly",
   CurrentKeybind = Enum.KeyCode.V,
   Flag = "FlyKeybind",
   Callback = function()
      local tog = Rayfield.Flags["FlyToggle"]
      if tog then
         tog:Set(not tog.CurrentValue)
      end
   end
})

Rayfield:Notify({
   Title = "Welcome!",
   Content = "Welcome to BX Hub!",
   Duration = 3,
   Image = nil
})
