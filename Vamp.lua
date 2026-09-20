-- [[ VAMP HUB - BROOKHAVEN UTILITY SCRIPT WITH EMOTES ]] --
-- Educational Purpose Only

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- UI Init (VAMP Design CoreGui me)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VAMP_Hub_Ultimate"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 460) -- Height badha di taaki Emotes fit ho sakein
MainFrame.Position = UDim2.new(0.3, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(25, 10, 10)
Title.Text = "  VAMP HUB | Ultimate Brookhaven Menu"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

---------------------------------------------------------
-- [ CORE EMOTE PLAYER LOGIC ]
---------------------------------------------------------
-- Yeh function kisi bhi custom animation/emote ID ko force play karta hai
local currentTrack = nil
local function playCustomEmote(animationId)
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end
    
    -- Purana chal raha emote roko
    if currentTrack then
        currentTrack:Stop()
    end
    
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. tostring(animationId)
    
    local success, err = pcall(function()
        currentTrack = humanoid:LoadAnimation(anim)
        currentTrack:Play()
    end)
    
    if not success then
        warn("Emote load nahi ho paya: " .. tostring(err))
    end
end

---------------------------------------------------------
-- [ EMOTES GUI SECTION ]
---------------------------------------------------------
local EmoteSectionTitle = Instance.new("TextLabel")
EmoteSectionTitle.Size = UDim2.new(1, -40, 0, 30)
EmoteSectionTitle.Position = UDim2.new(0, 20, 0, 230)
EmoteSectionTitle.Text = "★ ALL EMOTES & ANIMATIONS ★"
EmoteSectionTitle.TextColor3 = Color3.fromRGB(255, 0, 0)
EmoteSectionTitle.TextSize = 14
EmoteSectionTitle.Font = Enum.Font.GothamBold
EmoteSectionTitle.BackgroundTransparency = 1
EmoteSectionTitle.TextXAlignment = Enum.TextXAlignment.Left
EmoteSectionTitle.Parent = MainFrame

-- Custom Emote ID Input (Koyi bhi premium animation id chalane ke liye)
local EmoteInput = Instance.new("TextBox")
EmoteInput.Size = UDim2.new(0, 150, 0, 35)
EmoteInput.Position = UDim2.new(0, 20, 0, 270)
EmoteInput.PlaceholderText = "Custom Emote ID..."
EmoteInput.Text = ""
EmoteInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
EmoteInput.TextColor3 = Color3.fromRGB(255, 255, 255)
EmoteInput.Parent = MainFrame

local PlayEmoteBtn = Instance.new("TextButton")
PlayEmoteBtn.Size = UDim2.new(0, 150, 0, 35)
PlayEmoteBtn.Position = UDim2.new(0, 190, 0, 270)
PlayEmoteBtn.Text = "Play Emote ID"
PlayEmoteBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
PlayEmoteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayEmoteBtn.Parent = MainFrame

PlayEmoteBtn.MouseButton1Click:Connect(function()
    local id = tonumber(EmoteInput.Text)
    if id then
        playCustomEmote(id)
    end
end)

-- Stop Emote Button
local StopEmoteBtn = Instance.new("TextButton")
StopEmoteBtn.Size = UDim2.new(0, 150, 0, 35)
StopEmoteBtn.Position = UDim2.new(0, 360, 0, 270)
StopEmoteBtn.Text = "Stop Emote"
StopEmoteBtn.BackgroundColor3 = Color3.fromRGB(60, 10, 10)
StopEmoteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopEmoteBtn.Parent = MainFrame

StopEmoteBtn.MouseButton1Click:Connect(function()
    if currentTrack then
        currentTrack:Stop()
    end
end)

-- Quick Emote Buttons (Common Premium/Fun Animations)
local emotesList = {
    {name = "T-Pose", id = 2743269143},
    {name = "Floss", id = 2862804562},
    {name = "Dab", id = 2482701140},
    {name = "Hyped (Groove)", id = 2862788552},
    {name = "Ninja Idle", id = 658826508},
    {name = "Zombie Walk", id = 616168032}
}

for i, emote in ipairs(emotesList) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 150, 0, 30)
    
    -- Grid placement
    local xPos = 20 + ((i - 1) % 3) * 170
    local yPos = 320 + math.floor((i - 1) / 3) * 40
    
    btn.Position = UDim2.new(0, xPos, 0, yPos)
    btn.Text = emote.name
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(100, 0, 0)
    btn.Parent = MainFrame
    
    btn.MouseButton1Click:Connect(function()
        playCustomEmote(emote.id)
    end)
end

---------------------------------------------------------
-- [ PICHLE PARAMES / FEATURES ]
---------------------------------------------------------
-- 1. FLY BUTTON
local flying = false
local flySpeed = 50
local FlyBtn = Instance.new("TextButton")
FlyBtn.Size = UDim2.new(0, 150, 0, 35)
FlyBtn.Position = UDim2.new(0, 20, 0, 60)
FlyBtn.Text = "Toggle Fly"
FlyBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Parent = MainFrame

FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.PlatformStand = true
        local bg = Instance.new("BodyGyro", hrp)
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        spawn(function()
            while flying and character and hrp do
                RunService.RenderStepped:Wait()
                bv.velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
                bg.cframe = workspace.CurrentCamera.CFrame
            end
            bg:Destroy()
            bv:Destroy()
            humanoid.PlatformStand = false
        end)
    else
        FlyBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
    end
end)

-- 2. AVATAR COPY
local TargetInput = Instance.new("TextBox")
TargetInput.Size = UDim2.new(0, 150, 0, 35)
TargetInput.Position = UDim2.new(0, 190, 0, 60)
TargetInput.PlaceholderText = "Player Username..."
TargetInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.Parent = MainFrame

local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0, 150, 0, 35)
CopyBtn.Position = UDim2.new(0, 350, 0, 60)
CopyBtn.Text = "Copy Avatar"
CopyBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.Parent = MainFrame

CopyBtn.MouseButton1Click:Connect(function()
    local targetPlayer = Players:FindFirstChild(TargetInput.Text)
    if targetPlayer and targetPlayer.Character and LocalPlayer.Character then
        for _, item in pairs(LocalPlayer.Character:GetChildren()) do
            if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") then item:Destroy() end
        end
        for _, item in pairs(targetPlayer.Character:GetChildren()) do
            if item:IsA("Accessory") or item:IsA("Shirt") or item:IsA("Pants") then item:Clone().Parent = LocalPlayer.Character end
        end
    end
end)

-- 3. UNLIMITED PLAYER SPEED
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0, 150, 0, 35)
SpeedInput.Position = UDim2.new(0, 20, 0, 120)
SpeedInput.PlaceholderText = "Player Speed..."
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Parent = MainFrame

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        local num = tonumber(SpeedInput.Text)
        if num then LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = num end
    end
end)

-- 4. VEHICLE SPEED
local CarSpeedInput = Instance.new("TextBox")
CarSpeedInput.Size = UDim2.new(0, 150, 0, 35)
CarSpeedInput.Position = UDim2.new(0, 190, 0, 120)
CarSpeedInput.PlaceholderText = "Vehicle Speed..."
CarSpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CarSpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CarSpeedInput.Parent = MainFrame

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local seat = LocalPlayer.Character.Humanoid.SeatPart
        if seat and seat:IsA("VehicleSeat") then
            local targetCarSpeed = tonumber(CarSpeedInput.Text)
            if targetCarSpeed then
                seat.MaxSpeed = targetCarSpeed
                seat.Velocity = seat.CFrame.LookVector * (targetCarSpeed * 0.8)
            end
        end
    end
end)

-- 5. ADJUSTABLE SPIN
local spinning = false
local SpinInput = Instance.new("TextBox")
SpinInput.Size = UDim2.new(0, 150, 0, 35)
SpinInput.Position = UDim2.new(0, 20, 0, 180)
SpinInput.PlaceholderText = "Spin Speed..."
SpinInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpinInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinInput.Parent = MainFrame

local SpinBtn = Instance.new("TextButton")
SpinBtn.Size = UDim2.new(0, 150, 0, 35)
SpinBtn.Position = UDim2.new(0, 190, 0, 180)
SpinBtn.Text = "Toggle Spin"
SpinBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
