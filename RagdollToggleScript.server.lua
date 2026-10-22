-- Ragdoll Toggle Script

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local function toggleRagdoll(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not humanoid:GetStateEnabled(Enum.HumanoidStateType.Ragdoll))
        if humanoid:GetStateEnabled(Enum.HumanoidStateType.Ragdoll) then
            humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
        else
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
end

local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        local userInput = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed and input.KeyCode == Enum.KeyCode.Q then
                toggleRagdoll(character)
            end
        end)
        
        character:WaitForChild("Humanoid").Died:Connect(function()
            userInput:Disconnect()
        end)
    end)
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Connect to existing players
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end