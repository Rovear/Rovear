local player = game.Players.LocalPlayer
local character

-- Function to handle player respawn or falling detection.
local function onCharacterAdded(char)
	character = char

	-- Monitor the player's position.
	while character.Parent do
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		if rootPart and rootPart.Position.Y < -100 then
			-- Teleport player to a safe location (adjust coordinates as needed).
			rootPart.CFrame = CFrame.new(0, 10, 0)
		end
		wait(0.1) -- Check every 0.1 seconds.
	end
end

-- Listen for the player's character being added.
player.CharacterAdded:Connect(onCharacterAdded)

-- Handle existing character when the game starts.
if player.Character then
	onCharacterAdded(player.Character)
end
