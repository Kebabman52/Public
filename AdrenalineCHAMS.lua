  --[[
    By exclusivecm
  ]]--

local plrgrp = game.Workspace:FindFirstChild("Players")

if not plrgrp then
    return
end

local function addHgh(character)
    if character:FindFirstChildOfClass("Highlight") then return end
    
    local highlight = Instance.new("Highlight")
    highlight.OutlineTransparency = 1
    highlight.FillColor = Color3.fromRGB(128, 0, 128)
    
    highlight.Parent = character
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

game.Workspace.Ragdolls.ChildAdded:Connect(function(model)
    if model:IsA("Model") then
        local highlight = model:FindFirstChildOfClass("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end
end)
