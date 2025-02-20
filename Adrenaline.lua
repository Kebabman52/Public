  --[[
    By exclusivecm
  ]]--
local localPlayer = game.Players.LocalPlayer
local plrgrp = game.Workspace:FindFirstChild("Players")
if not plrgrp then return end

local function addHgh(character)
    if character:FindFirstChildOfClass("Highlight") then return end
    
    local player = game.Players:GetPlayerFromCharacter(character)
    if not player then return end
    
    local highlight = Instance.new("Highlight")
    highlight.OutlineTransparency = 1
    
    if player.Team == localPlayer.Team and player.Team.Name ==  localPlayer.Team.Name then
        highlight.FillColor = Color3.fromRGB(0, 255, 0)
    elseif player.Team == not localPlayer.Team and player.Team.Name == not localPlayer.Team.Name then
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
    end
    highlight.Parent = character
end

for _, character in ipairs(plrgrp:GetChildren()) do
    if character:IsA("Model") then
        local player = game.Players:GetPlayerFromCharacter(character)
        if player and player.Team then addHgh(character)
        end
    end
end

plrgrp.ChildAdded:Connect(function(character)
    if character:IsA("Model") then
        local player = game.Players:GetPlayerFromCharacter(character)
        if player and player.Team then addHgh(character)
        end
    end
end)

game.Workspace.Ragdolls.ChildAdded:Connect(function(model)
    if model:IsA("Model") then
        local highlight = model:FindFirstChildOfClass("Highlight")
        if highlight then highlight:Destroy()
        end
    end
end)

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if character:IsA("Model") then
            if player.Team then addHgh(character)
            end
        end
    end)
end)

for _, player in pairs(game.Players:GetPlayers()) do
    player.CharacterAdded:Connect(function(character)
        if character:IsA("Model") then
            if player.Team then addHgh(character)
            end
        end
    end)
end
