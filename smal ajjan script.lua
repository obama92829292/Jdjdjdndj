<meta name='viewport' content='width=device-width, initial-scale=1'/>local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 10) -- Wait for PlayerGui with timeout

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
    tabButton.Size = UDim2.new(0.333, -5, 1, -10) -- Adjusted for even spacing
    tabButton.Position = UDim2.new((i - 1) / #tabs, 5, 0, 5)
    tabButton.Active = true
    tabButton.Parent = tabsContainer
    Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 8)

    local frame = Instance.new("ScrollingFrame")
    frame.Name = name .. "Frame"
    frame.Size = UDim2.new(1, -20, 1, -80)
    frame.Position = UDim2.new(0, 10, 0, 80)
    frame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated dynamically
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
            print("Tab clicked: " .. btn.Text) -- Debug
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
        btn.MouseButton1Click:Connect(function()
            print("Button clicked: " .. text) -- Debug
            callback()
        end)
    end

    -- Update CanvasSize of parent ScrollingFrame
    local canvasHeight = posY + 50 -- Button height + padding
    if parent and parent.CanvasSize and parent.CanvasSize.Y.Offset < canvasHeight then
        parent.CanvasSize = UDim2.new(0, 0, 0, canvasHeight)
    end

    print("Created button: " .. text, btn) -- Debug
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
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
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
        if hum then
            if hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
            if not hum:FindFirstChild("NoDamage") then
                local tag = Instance.new("BoolValue")
                tag.Name = "NoDamage"
                tag.Parent = hum
            end
        end
    end
end)

-- Instant Steal (Jump)
createButton(tabFrames.Main, "Jump", 160, function()
    local function setup()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")

        local jumpVelocity = 120
        local airBoost = false

        pcall(function()
            settings().Physics.AllowSleep = false
        end)

        humanoid.StateChanged:Connect(function(_, newState)
            if newState == Enum.HumanoidStateType.Jumping and not airBoost then
                airBoost = true
                RunService.RenderStepped:Wait()
                rootPart.Velocity = Vector3.new(0, jumpVelocity, 0)
                task.wait(0.3)
                airBoost = false
            end
        end)
    end

    player.CharacterAdded:Connect(function()
        task.wait(1)
        setup()
    end)

    if player.Character then
        setup()
    end
end)

-- Anti Ragdoll
createButton(tabFrames.Main, "Anti Ragdoll", 210, function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/onliengamerop/Steal-gui/refs/heads/main/notficationantiragdoll.txt"))()
    end)
end)

-- Speed Boost
local speedBoostEnabled = false
local speedBoostConnection = nil

local function buySpeedCoil()
    local NetModule = ReplicatedStorage:WaitForChild("Packages"):FindFirstChild("Net")
    if not NetModule then return end
    local success, result = pcall(function()
        local Net = require(NetModule)
        local BuyFunction = Net:RemoteFunction("CoinsShopService/RequestBuy")
        return BuyFunction:InvokeServer("Speed Coil")
    end)
end

local function applyLoopSpeed()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")

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

local function equipAndDrop()
    local backpack = player:WaitForChild("Backpack")
    local tool = backpack:FindFirstChild("Speed Coil")
    if tool then
        tool.Parent = player.Character
        task.wait(0.3)
        tool.Parent = workspace
        task.wait(0.2)
        local dropped = workspace:FindFirstChild("Speed Coil")
        if dropped and dropped:FindFirstChild("Handle") then
            local handle = dropped.Handle
            handle.Transparency = 1
            handle.CanCollide = false
        end
    end
end

local function runSpeedBoost()
    task.spawn(function()
        buySpeedCoil()
        task.wait(1)
        speedBoostConnection = applyLoopSpeed()
        task.wait(0.5)
        equipAndDrop()
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

local speedBtn = createButton(tabFrames.Main, "Speed Boost", 260, function()
    speedBoostEnabled = not speedBoostEnabled
    print("Speed Boost toggled, speedBtn:", speedBtn)
    if speedBtn then
        speedBtn.BackgroundColor3 = speedBoostEnabled and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(60, 60, 60)
    else
        warn("speedBtn is nil!")
    end
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

-- New Instant Steal
local instantStealBtn = createButton(tabFrames.Main, "Instant Steal", 310, function()
    print("Instant Steal clicked") -- Debug
    loadstring(game:HttpGet("https://raw.githubusercontent.com/onliengamerop/Steal-gui/refs/heads/main/instantstealbyajjan.lua.txt"))()
end)

-- Anti Trap
createButton(tabFrames.Main, "Anti Trap", 360, function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/onliengamerop/Steal-gui/refs/heads/main/antitrap.lua.txt"))()
    end)
end)

-- Anti Steal
createButton(tabFrames.Main, "Anti Steal", 410, function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/onliengamerop/Steal-gui/refs/heads/main/antisteal.txt"))()
    end)
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
    if activeLockTimeEsp then
        pcall(updateLock)
    end
end)

local lockBtn = createButton(tabFrames.Visual, "Lock Base ESP", 10, function()
    print("Lock Base ESP toggled") -- Debug
    activeLockTimeEsp = not activeLockTimeEsp
    lockBtn.BackgroundColor3 = activeLockTimeEsp and Color3.fromRGB(30, 200, 30) or Color3.fromRGB(60, 60, 60)
end)

-- Player ESP
createButton(tabFrames.Visual, "ESP", 60, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/onliengamerop/Steal-gui/refs/heads/main/esp1.txt"))()
end)

-- Brainrot ESP
createButton(tabFrames.Visual, "Brainrot ESP", 110, function()
    loadstring(game:HttpGet("https://pastebin.com/raw/HbJFXm31"))()
end)

-- ServerHop
createButton(tabFrames.Misc, "ServerHop", 10, function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Youifpg/Steal-a-Brianrot/refs/heads/main/Secrets%20finder.lua"))()
    end)
end)

-- Anti Kick
createButton(tabFrames.Misc, "Anti Kick", 60, function()
    pcall(function()
        loadstring(game:HttpGet("https://pastefy.app/dAjYZBnq/raw"))()
    end)
end)

-- Check Server Version
createButton(tabFrames.Misc, "Check Server Version", 110, function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/onliengamerop/Steal-gui/refs/heads/main/serverversion.txt"))()
    end)
end)

-- Clock Display
local miscText = Instance.new("TextLabel")
miscText.Size = UDim2.new(1, -20, 0, 60)
miscText.Position = UDim2.new(0, 10, 0, 160)
miscText.BackgroundTransparency = 1
miscText.Font = Enum.Font.Gotham
miscText.TextSize = 16
miscText.TextColor3 = Color3.new(1, 1, 1)
miscText.TextWrapped = true
miscText.Parent = tabFrames.Misc

RunService.RenderStepped:Connect(function()
    miscText.Text = "🕒 " .. os.date("%H:%M:%S")
end)

-- Update Misc tab CanvasSize
tabFrames.Misc.CanvasSize = UDim2.new(0, 0, 0, 170)

-- Improved Dragging Function
local function makeDraggable(frame)
    local dragging = false
    local dragInput, dragStart, startPos

    local function updateInput(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            print("Dragging started on " .. frame.Name) -- Debug
            local conn
            conn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    print("Dragging ended on " .. frame.Name) -- Debug
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
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Apply Dragging to Main Frame and Open Button
makeDraggable(mainFrame)
makeDraggable(openButton)

-- Toggle GUI Function
local function toggleGUI(visible)
    mainFrame.Visible = visible
    print("GUI toggled: " .. tostring(visible)) -- Debug
end

-- Connect Open and Close Buttons
openButton.MouseButton1Click:Connect(function()
    print("Open button clicked") -- Debug
    toggleGUI(true)
end)

closeButton.MouseButton1Click:Connect(function()
    print("Close button clicked") -- Debug
    toggleGUI(false)
end)