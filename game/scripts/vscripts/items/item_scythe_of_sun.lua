item_scythe_of_sun = class({})

LinkLuaModifier("modifier_item_scythe_of_sun", "items/modifier_item_scythe_of_sun.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_scythe_of_sun_hex", "items/modifier_item_scythe_of_sun.lua", LUA_MODIFIER_MOTION_NONE)

function item_scythe_of_sun:GetIntrinsicModifierName()
	return "modifier_item_scythe_of_sun"
end

if IsServer() then
	function item_scythe_of_sun:OnSpellStart()
		local target = self:GetCursorTarget()
		if not target:TriggerSpellAbsorb(self) then
			ParticleManager:CreateParticle("particles/arena/items_fx/scythe_of_sun.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
			target:EmitSound("DOTA_Item.Sheepstick.Activate")

			if target:IsIllusion() then
				target:Kill(ability, caster)
			else
				target:TriggerSpellReflect(self)
				target:AddNewModifier(self:GetCaster(), self, "modifier_item_scythe_of_sun_hex", {duration = self:GetSpecialValueFor("hex_duration")})
			end
		end
	end
end
