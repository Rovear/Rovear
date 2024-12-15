-- Access PlayerGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 5)

if not playerGui then
	error("PlayerGui not found! Script terminated.")
end

-- Obtain ScreenGui
local screenGui = playerGui:WaitForChild("ScreenGui", 5)
if not screenGui then
	error("ScreenGui not found! Script terminated.")
end

-- Locate Pannel (Frame)
local pannel = screenGui:FindFirstChild("Pannel")
if not pannel or not pannel:IsA("Frame") then
	error("Pannel not found or is not a Frame! Script terminated.")
end

-- Enable ClipsDescendants on Pannel so notes don't overflow
pannel.ClipsDescendants = true

-- Define the image IDs for each note
local imageIds = {
	"rbxassetid://98414606871978", -- Image for Note1
	"rbxassetid://99284842825850", -- Image for Note2
	"rbxassetid://99284842825850", -- Image for Note3
	"rbxassetid://98414606871978"  -- Image for Note4
}

-- Layout config
local totalNotes = #imageIds
local noteWidth = 1 / totalNotes  -- fraction of Pannel's width each note occupies
local bottomHeight = 0.2         -- each note takes up 20% of Pannel's height at bottom

for i, assetId in ipairs(imageIds) do
	local noteName = "Note" .. i

	-- Either find the existing ImageLabel or create a new one
	local imageLabel = pannel:FindFirstChild(noteName)
	if not imageLabel then
		imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = noteName
		imageLabel.Parent = pannel
	end

	if imageLabel and imageLabel:IsA("ImageLabel") then
		-- Assign the image
		imageLabel.Image = assetId
		imageLabel.BackgroundTransparency = 1
		imageLabel.ScaleType = Enum.ScaleType.Fit

		-- Stretch them side by side along bottom
		imageLabel.AnchorPoint = Vector2.new(0, 1)    -- Anchor by the bottom edge
		imageLabel.Position = UDim2.new(noteWidth*(i-1), 0, 1, 0)  -- place them bottom-aligned
		imageLabel.Size = UDim2.new(noteWidth, 0, bottomHeight, 0) -- fill horizontal fraction, use 'bottomHeight' for vertical size

		-- Remove any existing UIAspectRatioConstraint so they fill fully
		local aspectConstraint = imageLabel:FindFirstChild("UIAspectRatioConstraint")
		if aspectConstraint then
			aspectConstraint:Destroy()
		end
	else
		warn("Could not find or is not an ImageLabel:", noteName)
	end
end
