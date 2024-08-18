AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if not tr.Hit then return end

	local spawnpos = tr.HitPos + tr.HitNormal * 16

	local ent = ents.Create("personal_spawn_pad")

	ent:SetPos(spawnpos)
	ent:Spawn()
	ent:Activate()
	ent:GetOwner(self.SpawnPadOwner)

	return ent
end

function ENT:Initialize()
	local selftable = self:GetTable()
	local selfentity = selftable.Entity

	selfentity:SetModel("models/maxofs2d/hover_plate.mdl")
	selfentity:PhysicsInit(SOLID_VPHYSICS)
	selfentity:SetMoveType(MOVETYPE_NONE)
	selfentity:SetSolid(SOLID_VPHYSICS)
	selfentity:SetCollisionGroup(COLLISION_GROUP_WORLD)
	selfentity:DrawShadow(false)
	selfentity:SetMaxHealth(5)
	selfentity:SetHealth(5)

	selftable.HealthAmnt = 75
end

local zapsound = Sound("npc/assassin/ball_zap1.wav")
local pickupsound = Sound("buttons/lever7.wav")

function ENT:OnTakeDamage(dmg)
	local selftable = self:GetTable()
	local selfhealth = selftable.HealthAmnt

	if selfhealth <= 0 then return end

	selfhealth = selfhealth - dmg:GetDamage()

	if selfhealth <= 0 then
		local selfpos = self:GetPos()
		local effect = EffectData()

		effect:SetStart(selfpos)
		effect:SetOrigin(selfpos)

		util.Effect("cball_explode", effect, true, true)
		sound.Play(zapsound, selfpos, 100, 100)

		selftable.Entity:Remove()
	else
		selftable.HealthAmnt = selfhealth
	end
end

function ENT:Use(activator, caller)	
	timer.Simple(0.2, function() 
		if IsValid(activator) and activator == self.SpawnPadOwner then
			activator:Give("personal_spawn_pad_swep")

			sound.Play(pickupsound, self:GetPos(), 100, math.random(120, 150))
			self:Remove()
		end
	end)
end