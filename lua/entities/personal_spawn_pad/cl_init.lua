include("shared.lua")

local beammat = Material("models/props_combine/portalball001_sheet")
local offset_vector = Vector(0, 0, 30)

function ENT:Draw()
	self:DrawModel()

	local selfpos = self:GetPos()
	
	render.SetMaterial(beammat)
	render.DrawBeam(selfpos, selfpos + offset_vector, 9, 0, 0.9, color_white)
end