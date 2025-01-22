local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BX Hub",
   LoadingTitle = "BX Hub Loader",
   LoadingSubtitle = "By BX Team",
   Theme = "Default",
   DisableRayfieldPrompts = true,
   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = nil
   },
   KeySystem = false
})

local UniversalTab = Window:CreateTab("Universal", 92875681906793)
local UniversalHubTab = Window:CreateTab("Hubs", 13518130183)
local OtherTab = Window:CreateTab("Games", 11894535915)

local Connections = {
   InfiniteJump = nil,
   Noclip = nil,
   LoopSpeed = nil,
   LoopJumpPower = nil
}

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
   end,
})

UniversalTab:CreateButton({
   Name = "Infinite Yield",
   SectionParent = ScriptsCategory,
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})

local UtilitiesCategory = UniversalTab:CreateSection("Utilities")

UniversalTab:CreateToggle({
   Name = "Speed",
   CurrentValue = false,
   Flag = "LoopSpeedToggle",
   Callback = function(State)
      if State then
         Connections.LoopSpeed = game:GetService("RunService").Stepped:Connect(function()
            local player = game.Players.LocalPlayer
            local char = player.Character
            local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
               humanoid.WalkSpeed = speedValue
            end
         end)
      else
         if Connections.LoopSpeed then
            Connections.LoopSpeed:Disconnect()
            Connections.LoopSpeed = nil
         end
         local player = game.Players.LocalPlayer
         local char = player.Character
         local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
         if humanoid then
            humanoid.WalkSpeed = defaultSpeed
         end
      end
   end,
})

UniversalTab:CreateSlider({
   Name = "Speed",
   Range = {2, 60},
   Increment = 1,
   Suffix = " Studs",
   CurrentValue = speedValue,
   SectionParent = UtilitiesCategory,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      speedValue = Value
   end,
})

UniversalTab:CreateToggle({
   Name = "Jump Power",
   CurrentValue = false,
   Flag = "LoopJumpPowerToggle",
   Callback = function(State)
      if State then
         Connections.LoopJumpPower = game:GetService("RunService").Stepped:Connect(function()
            local player = game.Players.LocalPlayer
            local char = player.Character
            local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
               humanoid.UseJumpPower = true
               humanoid.JumpPower = jumpPowerValue
            end
         end)
      else
         if Connections.LoopJumpPower then
            Connections.LoopJumpPower:Disconnect()
            Connections.LoopJumpPower = nil
         end
         local player = game.Players.LocalPlayer
         local char = player.Character
         local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
         if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = defaultJumpPower
         end
      end
   end,
})

UniversalTab:CreateSlider({
   Name = "Jump",
   Range = {2, 120},
   Increment = 5,
   Suffix = " Power",
   CurrentValue = jumpPowerValue,
   SectionParent = UtilitiesCategory,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      jumpPowerValue = Value
   end,
})

UniversalTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJumpToggle",
   Callback = function(State)
      if State then
         Connections.InfiniteJump = game:GetService("UserInputService").JumpRequest:Connect(function()
            local player = game.Players.LocalPlayer
            local char = player.Character
            local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
            if humanoid then
               humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
         end)
      else
         if Connections.InfiniteJump then
            Connections.InfiniteJump:Disconnect()
            Connections.InfiniteJump = nil
         end
      end
   end,
})

UniversalTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(State)
      if State then
         Connections.Noclip = game:GetService("RunService").Stepped:Connect(function()
            local player = game.Players.LocalPlayer
            local char = player.Character
            if char then
               for _, part in ipairs(char:GetDescendants()) do
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
   end,
})

UniversalHubTab:CreateSection("Scripts")

UniversalHubTab:CreateButton({
   Name = "Kncrypt Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/Kncrypt/refs/heads/main/Loader.lua"))()
   end,
})

UniversalHubTab:CreateButton({
   Name = "Speed Hub",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua"))()
   end,
})

OtherTab:CreateSection("Scripts")

OtherTab:CreateButton({
   Name = "Doors",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/KINGHUB01/BlackKing-obf/main/Doors%20Blackking%20And%20BobHub"))()
   end,
})

OtherTab:CreateButton({
   Name = "Pressure",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Fire-Hub/main/Loader"))()
   end,
})

Rayfield:Notify({
   Title = "Welcome!",
   Content = "Welcome to BX Hub!",
   Duration = 3,
   Image = nil,
})

