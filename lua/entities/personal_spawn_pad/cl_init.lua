include("shared.lua")

local beammat = Material("models/props_combine/portalball001_sheet")
local offset_vector = Vector(0, 0, 30)

function ENT:Draw()
	self:DrawModel()

	local selfpos = self:GetPos()
	
	render.SetMaterial(beammat)
	render.DrawBeam(selfpos, selfpos + offset_vector, 9, 0, 0.9, color_white)
end

surface.CreateFont("Spawnpad_Font", {
	font = "Arial", 
	antialias = true, 
	size = 35
})

hook.Add("HUDPaint", "SpawnPad_Text", function()
	local visible_entity = LocalPlayer():GetEyeTrace().Entity

	if IsValid(visible_entity) and visible_entity:GetClass() == "personal_spawn_pad" then
		draw.SimpleText(
			visible_entity:GetNW2String("SpawnPadOwner") .. "'s Spawn Pad",
			"Spawnpad_Font",
			ScrW() / 2,
			ScrH() / 2 + 150,
			color_white,
			TEXT_ALIGN_CENTER,
			TEXT_ALIGN_CENTER
		)
	end
end)