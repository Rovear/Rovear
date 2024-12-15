-- Get the local player and their PlayerGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 5)
if not playerGui then
	error("PlayerGui not found! Script terminated.")
end

-- Retrieve the EngineGui
local engineGui = playerGui:WaitForChild("EngineGui", 5)
if not engineGui then
	error("EngineGui not found! Script terminated.")
end

-- Locate the Pannel frame
local pannel = engineGui:FindFirstChild("Pannel")
if not pannel or not pannel:IsA("Frame") then
	error("Pannel not found or is not a Frame! Script terminated.")
end

-- Prevent content inside Pannel from showing beyond its boundaries
pannel.ClipsDescendants = true

-- Asset IDs for each note ImageLabel
local imageIds = {
	"rbxassetid://98414606871978", 
	"rbxassetid://99284842825850",
	"rbxassetid://99284842825850",
	"rbxassetid://98414606871978"
}

-- Each note will take up an equal fraction of the width and full height
local totalNotes = #imageIds
local noteWidth = 1 / totalNotes  -- fraction of Pannel's total width

for i, assetId in ipairs(imageIds) do
	local noteName = "Note" .. i

	-- Either find an existing note or create a new one
	local imageLabel = pannel:FindFirstChild(noteName)
	if not imageLabel then
		imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = noteName
		imageLabel.Parent = pannel
	end

	if imageLabel and imageLabel:IsA("ImageLabel") then
		-- Configure the appearance and image asset
		imageLabel.Image = assetId
		imageLabel.BackgroundTransparency = 1
		imageLabel.ScaleType = Enum.ScaleType.Fit

		-- Fill the entire height, flush at the bottom
		imageLabel.AnchorPoint = Vector2.new(0, 1)                 -- anchor bottom edge
		imageLabel.Position = UDim2.new(noteWidth * (i - 1), 0, 1, 0)
		imageLabel.Size = UDim2.new(noteWidth, 0, 1, 0)            -- occupy full height

		-- Remove any aspect ratio constraint to let them fully fill the space
		local aspectConstraint = imageLabel:FindFirstChild("UIAspectRatioConstraint")
		if aspectConstraint then
			aspectConstraint:Destroy()
		end
	else
		warn("Could not find or is not an ImageLabel:", noteName)
	end
end
