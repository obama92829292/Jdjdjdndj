local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10)

if not playerGui then
    warn("PlayerGui not found!")
    return
end

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "AjjanGUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Create Open Button
local openButton = Instance.new("TextButton")
openButton.Name = "AXSButton"
openButton.Text = "Ajjan"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextSize = 14
openButton.Font = Enum.Font.GothamBold
openButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
openButton.BorderSizePixel = 0
openButton.Size = UDim2.new(0, 50, 0, 50)
openButton.Position = UDim2.new(0.5, -25, 0.5, -25)
openButton.Active = true
openButton.Visible = true
openButton.Parent = gui
Instance.new("UICorner", openButton).CornerRadius = UDim.new(1, 0)

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0.05, 0)

-- Create Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.Parent = mainFrame

-- Create Title Text
local titleText = Instance.new("TextLabel")
titleText.Text = "Steal a Brainrot | Ajjan"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 14
titleText.Font = Enum.Font.GothamBold
titleText.BackgroundTransparency = 1
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.Parent = titleBar

-- Create Close Button
local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.Active = true
closeButton.Parent = titleBar
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0.1, 0)

-- Create Tab Buttons Frame
local tabButtons = Instance.new("Frame")
tabButtons.Size = UDim2.new(1, 0, 0, 40)
tabButtons.Position = UDim2.new(0, 0, 0, 30)
tabButtons.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tabButtons.Parent = mainFrame

-- Create Tabs Container
local tabsContainer = Instance.new("Frame")
tabsContainer.Size = UDim2.new(1, -20, 1, 0)
tabsContainer.Position = UDim2.new(0, 10, 0, 0)
tabsContainer.BackgroundTransparency = 1
tabsContainer.Parent = tabButtons

-- Define Tabs
local tabs = {"Main", "Visual", "Misc"}
local tabFrames = {}

-- Create Tab Buttons and Frames
for i, name in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.TextSize = 14
    tabButton.Font = Enum.Font.GothamBold
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabButton.BorderSizePixel = 0
    tabButton.Size = UDim2.new(0.333, -5, 1, -10)
    tabButton.Position = UDim2.new((i - 1) / #tabs, 5, 0, 5)
    tabButton.Active = true
    tabButton.Parent = tabsContainer
    Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 8)

    local frame = Instance.new("ScrollingFrame")
    frame.Name = name .. "Frame"
    frame.Size = UDim2.new(1, -20, 1, -80)
    frame.Position = UDim2.new(0, 10, 0, 80)
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.ScrollBarThickness = 5
    frame.BackgroundTransparency = 1
    frame.Visible = i == 1
    frame.Parent = mainFrame
    tabFrames[name] = frame
end

-- Connect Tab Button Clicks
for _, btn in ipairs(tabsContainer:GetChildren()) do
    if btn:IsA("TextButton") then
        btn.MouseButton1Click:Connect(function()
            for name, frame in pairs(tabFrames) do
                frame.Visible = (name == btn.Text)
            end
            for _, otherBtn in ipairs(tabsContainer:GetChildren()) do
                if otherBtn:IsA("TextButton") then
                    otherBtn.BackgroundColor3 = (otherBtn == btn) and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(50, 50, 50)
                end
            end
        end)
    end
end

-- Button Creation Helper Function
local function createButton(parent, text, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.BorderSizePixel = 0
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 5, 0, posY)
    btn.Active = true
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end

    -- Update CanvasSize
    local canvasHeight = posY + 50
    if parent and parent.CanvasSize and parent.CanvasSize.Y.Offset < canvasHeight then
        parent.CanvasSize = UDim2.new(0, 0, 0, canvasHeight)
    end
    return btn
end

-- Infinite Jump
local infJump = false
local infBtn = createButton(tabFrames.Main, "Infinite Jump", 10, function()
    infJump = not infJump
    infBtn.BackgroundColor3 = infJump and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(60, 60, 60)
end)

UserInputService.JumpRequest:Connect(function()
    if infJump and player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Noclip
local noclip = false
local noclipBtn = createButton(tabFrames.Main, "Noclip", 60, function()
    noclip = not noclip
    noclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(60, 60, 60)
end)

RunService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Godmode
local godmode = false
local godBtn = createButton(tabFrames.Main, "Godmode", 110, function()
    godmode = not godmode
    godBtn.BackgroundColor3 = godmode and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(60, 60, 60)
end)

RunService.Heartbeat:Connect(function()
    if godmode and player.Character then
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health < hum.MaxHealth then
            hum.Health = hum.MaxHealth
        end
    end
end)

-- Speed Boost
local speedBoostEnabled = false
local speedBoostConnection = nil

local function applyLoopSpeed()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    local old = hrp:FindFirstChild("LoopSpeedForce")
    if old then old:Destroy() end

    local bv = Instance.new("BodyVelocity")
    bv.Name = "LoopSpeedForce"
    bv.MaxForce = Vector3.new(1, 0, 1) * 1e5
    bv.P = 1250
    bv.Velocity = Vector3.zero
    bv.Parent = hrp

    local con
    con = RunService.RenderStepped:Connect(function()
        if hum and hum.Parent and hum.Health > 0 then
            local dir = hum.MoveDirection
            bv.Velocity = dir.Magnitude > 0 and dir.Unit * 60 or Vector3.zero
        else
            bv:Destroy()
            if con then con:Disconnect() end
        end
    end)
    return con
end

local function runSpeedBoost()
    task.spawn(function()
        speedBoostConnection = applyLoopSpeed()
    end)
end

local function stopSpeedBoost()
    if speedBoostConnection then
        speedBoostConnection:Disconnect()
        speedBoostConnection = nil
    end
    if player.Character then
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local old = hrp:FindFirstChild("LoopSpeedForce")
            if old then old:Destroy() end
        end
    end
end

local speedBtn = createButton(tabFrames.Main, "Speed Boost", 160, function()
    speedBoostEnabled = not speedBoostEnabled
    speedBtn.BackgroundColor3 = speedBoostEnabled and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(60, 60, 60)
    if speedBoostEnabled then
        runSpeedBoost()
    else
        stopSpeedBoost()
    end
end)

player.CharacterAdded:Connect(function()
    if speedBoostEnabled then
        task.delay(1, runSpeedBoost)
    end
end)

-- Lock Base ESP
local activeLockTimeEsp = false
local lteInstances = {}

local function updateLock()
    if not activeLockTimeEsp then
        for _, instance in pairs(lteInstances) do
            if instance then
                instance:Destroy()
            end
        end
        lteInstances = {}
        return
    end

    for _, plot in pairs(workspace.Plots:GetChildren()) do
        local timeLabel = plot:FindFirstChild("Purchases", true) and 
            plot.Purchases:FindFirstChild("PlotBlock", true) and
            plot.Purchases.PlotBlock.Main:FindFirstChild("BillboardGui", true) and
            plot.Purchases.PlotBlock.Main.BillboardGui:FindFirstChild("RemainingTime", true)

        if timeLabel and timeLabel:IsA("TextLabel") then
            local espName = "LockTimeESP_" .. plot.Name
            local existingBillboard = plot:FindFirstChild(espName)
            local isUnlocked = timeLabel.Text == "0s"
            local displayText = isUnlocked and "Unlocked" or ("Lock: " .. timeLabel.Text)
            local textColor = isUnlocked and Color3.fromRGB(220, 20, 60) or Color3.fromRGB(255, 255, 0)

            if not existingBillboard then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = espName
                billboard.Size = UDim2.new(0, 200, 0, 30)
                billboard.StudsOffset = Vector3.new(0, 5, 0)
                billboard.AlwaysOnTop = true
                billboard.Adornee = plot.Purchases.PlotBlock.Main

                local label = Instance.new("TextLabel")
                label.Text = displayText
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextScaled = true
                label.TextColor3 = textColor
                label.TextStrokeColor3 = Color3.new(0, 0, 0)
                label.TextStrokeTransparency = 0
                label.Font = Enum.Font.SourceSansBold
                label.Parent = billboard

                billboard.Parent = plot
                lteInstances[plot.Name] = billboard
            else
                local label = existingBillboard:FindFirstChildOfClass("TextLabel")
                if label then
                    label.Text = displayText
                    label.TextColor3 = textColor
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    pcall(updateLock)
end)

local lockBtn = createButton(tabFrames.Visual, "Lock Base ESP", 10, function()
    activeLockTimeEsp = not activeLockTimeEsp
    lockBtn.BackgroundColor3 = activeLockTimeEsp and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(60, 60, 60)
end)

-- Dragging Function
local function makeDraggable(frame)
    local dragging = false
    local dragInput, dragStart, startPos

    local function updateInput(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            local conn
            conn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    conn:Disconnect()
                end
            end)
        end
    end

    frame.InputBegan:Connect(updateInput)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
               ⅅ
System: startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Apply Dragging
makeDraggable(mainFrame)
makeDraggable(openButton)

-- Toggle GUI
local function toggleGUI(visible)
    mainFrame.Visible = visible
end

openButton.MouseButton1Click:Connect(function()
    toggleGUI(true)
end)

closeButton.MouseButton1Click:Connect(function()
    toggleGUI(false)
end)
