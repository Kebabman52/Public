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
    highlight.OutlineTransparency = 1 -- / Removed Outlines cuz of peformance
    highlight.FillColor = Color3.fromRGB(128, 0, 128) -- / Change color here
    
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
