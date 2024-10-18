ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Personal Spawn Pad"
ENT.Author			= "Physics Dude"
ENT.Spawnable			= false
ENT.AdminSpawnable		= false

if SERVER then
	ENT.DisableDuplicator = true
	ENT.DoNotDuplicate = true
end

function ENT:CanProperty()
	return false
end

function ENT:CanTool(ply, trace, mode, tool, button)
	if mode == "remover" then return true end

	return false
end

ENT.PhysgunDisabled = true