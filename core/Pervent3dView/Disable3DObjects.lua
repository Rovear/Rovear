game.Workspace.DescendantAdded:Connect(function(obj)
	if obj:IsA("BasePart") then
		-- Make parts invisible and non-collidable.
		obj.Transparency = 1
		obj.CanCollide = false
	end
end)
