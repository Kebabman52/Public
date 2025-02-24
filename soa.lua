--[[
    By exclusivecm
    pls join the dc server
    https://discord.gg/8C9jtsXvcy
]]--

local Lightin = game.Lighting
local localPlayer = game.Players.LocalPlayer
local plrgrp = game.Workspace:FindFirstChild("Players")
if not plrgrp then
    warn("dm me on dc no playerfolder") 
    return 
end

local activeConnections = {}

local function addHgh(character)
    if character:FindFirstChildOfClass("Highlight") then return end
    
    local player = game.Players:GetPlayerFromCharacter(character)
    if not player then return end
    
    local highlight = Instance.new("Highlight")
    highlight.OutlineTransparency = 0.7
    highlight.OutlineColor = Color3.fromRGB(80, 0, 255)
    highlight.FillTransparency = 1
    highlight.FillColor = Color3.fromRGB(0, 0, 255)
    highlight.Parent = character
    highlight.DepthMode = "AlwaysOnTop"
    
    local head = character:WaitForChild("Head", 3)
    if not head then return end

    local distanceBillboard = Instance.new("BillboardGui")
    distanceBillboard.Size = UDim2.new(0, 100, 0, 50)
    distanceBillboard.StudsOffset = Vector3.new(0, -7.5, 0)
    distanceBillboard.AlwaysOnTop = true
    distanceBillboard.Parent = head
    
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Size = UDim2.new(1, 0, 1, 0)
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.TextColor3 = Color3.new(1, 1, 1)
    distanceLabel.TextScaled = false
    distanceLabel.Parent = distanceBillboard
    distanceLabel.Font = Enum.Font.RobotoMono

    local nameBillboard = Instance.new("BillboardGui")
    nameBillboard.Size = UDim2.new(0, 100, 0, 50)
    nameBillboard.StudsOffset = Vector3.new(0, 4, 0)
    nameBillboard.AlwaysOnTop = true
    nameBillboard.Parent = head

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextScaled = false
    nameLabel.Text = player.Name
    nameLabel.Parent = nameBillboard
    nameLabel.Font = Enum.Font.RobotoMono
    
    local connection = game:GetService("RunService").RenderStepped:Connect(function()
        if localPlayer.Character and localPlayer.Character:FindFirstChild("Head") then
            local distance = (localPlayer.Character.Head.Position - head.Position).Magnitude
            local textSize = math.clamp(13 - (distance * 0.05), 5, 15)
            
            distanceLabel.Text = string.format("%.1f studs", distance)
            distanceLabel.TextSize = textSize
            nameLabel.TextSize = textSize
        end
    end)

    activeConnections[character] = connection

    character.AncestryChanged:Connect(function(_, parent)
        if not parent then
            if activeConnections[character] then
                activeConnections[character]:Disconnect()
                activeConnections[character] = nil
            end
        end
    end)
end

for _, character in ipairs(plrgrp:GetChildren()) do
    if character:IsA("Model") then
        addHgh(character)
    end
end

plrgrp.ChildAdded:Connect(function(character)
    if character:IsA("Model") then
        addHgh(character)
    end
end)

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if character:IsA("Model") then
            addHgh(character)
        end
    end)
end)

for _, player in pairs(game.Players:GetPlayers()) do
    player.CharacterAdded:Connect(function(character)
        if character:IsA("Model") then
            addHgh(character)
        end
    end)
end

Lightin.GlobalShadows = false
Lightin.ExposureCompensation = 2
Lightin.ColorCorrection.Saturation = 1.3
Lightin.ColorCorrection.Contrast = 0.2
Lightin.ColorCorrection.Brightness = 0.1
Lightin.Atmosphere:Destroy()
