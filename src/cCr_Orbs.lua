cCr = cCr or {}

cCr.portalOrbVars = {
	orbsDiscovered = 0,
	orbsDelivered = 0,

}


-- Function: cCr.onOrbDrop
-- callback for Combat Event - filtered for ID of orb dropping
--
function cCr.onOrbDrop(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,_,sourceUnitId,targetUnitId,abilityId)
	cCr.portalOrbVars.orbsDiscovered = cCr.portalOrbVars.orbsDiscovered+1
	
	cCr.setDiscovered(cCr.portalOrbVars.orbsDiscovered)
	cCr.setDelivered(cCr.portalOrbVars.orbsDelivered)
	
end

-- Function: cCr.onOrbDelivered
-- callback for Combat Event - filtered for ID of orb being delivered
--
function cCr.onOrbDelivered(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,_,sourceUnitId,targetUnitId,abilityId)
	cCr.portalOrbVars.orbsDelivered = cCr.portalOrbVars.orbsDelivered+1
	
	cCr.setDiscovered(cCr.portalOrbVars.orbsDiscovered)
	cCr.setDelivered(cCr.portalOrbVars.orbsDelivered)
	
end

-- Function: cCr.resetOrbs
-- reset counters for orbs
--
function cCr.resetOrbs()
	cCr.portalOrbVars.orbsDiscovered = 0
	cCr.portalOrbVars.orbsDelivered = 0
	
	cCr.setDiscovered(cCr.portalOrbVars.orbsDiscovered)
	cCr.setDelivered(cCr.portalOrbVars.orbsDelivered)
end





-- Function: cCr.setDiscovered
-- sets how many orbs should be shown as discovered on the UI
--
-- discovered - number of discovered orbs
--
function cCr.setDiscovered(discovered)
	cCr.portalOrbsNoti.texture1:SetAlpha(0.4)
	cCr.portalOrbsNoti.texture1:SetTexture("cCr/UI/OrbImage_Hidden.dds")
	cCr.portalOrbsNoti.texture2:SetAlpha(0.4)
	cCr.portalOrbsNoti.texture2:SetTexture("cCr/UI/OrbImage_Hidden.dds")
	cCr.portalOrbsNoti.texture3:SetAlpha(0.4)
	cCr.portalOrbsNoti.texture3:SetTexture("cCr/UI/OrbImage_Hidden.dds")
	
	if discovered >= 1 then
		cCr.portalOrbsNoti.texture1:SetAlpha(0.9)
		cCr.portalOrbsNoti.texture1:SetTexture("cCr/UI/OrbImage.dds")
	end
	
	if discovered >= 2 then
		cCr.portalOrbsNoti.texture2:SetAlpha(0.9)
		cCr.portalOrbsNoti.texture2:SetTexture("cCr/UI/OrbImage.dds")
	end
	
	if discovered >= 3 then
		cCr.portalOrbsNoti.texture3:SetAlpha(0.9)
		cCr.portalOrbsNoti.texture3:SetTexture("cCr/UI/OrbImage.dds")
	end
end

-- Function: cCr.setDelivered
-- sets how many orbs should be shown as delivered on the UI
--
-- delivered - number of delivered orbs
--
function cCr.setDelivered(delivered)
	cCr.portalOrbsNoti.checkmark1:SetHidden(true)
	cCr.portalOrbsNoti.checkmark2:SetHidden(true)
	cCr.portalOrbsNoti.checkmark3:SetHidden(true)
	
	if delivered >= 1 then
		cCr.portalOrbsNoti.checkmark1:SetHidden(false)
	end
	
	if delivered >= 2 then
		cCr.portalOrbsNoti.checkmark2:SetHidden(false)
	end
	
	if delivered >= 3 then
		cCr.portalOrbsNoti.checkmark3:SetHidden(false)
	end
end