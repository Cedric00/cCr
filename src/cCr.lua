cCr = cCr or {}

cCr.name = "cCr"
cCr.varsVersion = 1
cCr.version = 1.1


cCr.zoneIDs = {
	TRIAL_CLOUDREST = 1051,

}


-------------------------------------------------------------------
---------------------------   UI stuff   --------------------------
-------------------------------------------------------------------

-- Function: cCr.lock
-- lock/unlock the UI
--
-- locked - wether to lock or unlock
--
function cCr.lock(locked)
	cCr.setPortalTimerMovable(not locked and cCr.savedVars.portalTimer)
	cCr.setPortalOrbsMovable(not locked and cCr.savedVars.portalOrbs)
end

-- Function: cCr.setPortalTimerMovable
-- make the portal timer movable
--
-- movable - wether portal timer should be allowed to move or not
--
function cCr.setPortalTimerMovable(movable)
	cCr.portalTimeNoti:SetMouseEnabled(movable)
	cCr.portalTimeNoti:SetHidden(not movable)
	cCr.portalTimeNoti:SetMovable(movable)
	if movable then
		cCr.portalTimeNoti.backdrop:SetEdgeColor(1, 1, 1, 1)
	else
		cCr.portalTimeNoti.backdrop:SetEdgeColor(0, 0, 0, 0)
	end
end

-- Function: cCr.setPortalOrbsMovable
-- make the portal orb ui movable
--
-- movable - wether portal orb ui should be allowed to move or not
--
function cCr.setPortalOrbsMovable(movable)
	cCr.portalOrbsNoti:SetMouseEnabled(movable)
	cCr.portalOrbsNoti:SetHidden(not movable)
	cCr.portalOrbsNoti:SetMovable(movable)
	if movable then
		cCr.portalOrbsNoti.backdrop:SetEdgeColor(1, 1, 1, 1)
	else
		cCr.portalOrbsNoti.backdrop:SetEdgeColor(0, 0, 0, 0)
	end
end

-- Function: cCr.SavePosition
-- save UI Elements postion to savedVariables
--
function cCr.SavePosition()
	cCr.savedVars.position.portalTimer_X = zo_round(cCr.portalTimeNoti:GetLeft())
	cCr.savedVars.position.portalTimer_Y = zo_round(cCr.portalTimeNoti:GetTop())
	
	cCr.savedVars.position.portalOrbs_X = zo_round(cCr.portalOrbsNoti:GetLeft())
	cCr.savedVars.position.portalOrbs_Y = zo_round(cCr.portalOrbsNoti:GetTop())

	
	cCr.portalTimeNoti:ClearAnchors()
	cCr.portalTimeNoti:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, cCr.savedVars.position.portalTimer_X, cCr.savedVars.position.portalTimer_Y)
	
	cCr.portalOrbsNoti:ClearAnchors()
	cCr.portalOrbsNoti:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, cCr.savedVars.position.portalOrbs_X, cCr.savedVars.position.portalOrbs_Y)
end

-------------------------------------------------------------------
--------------------------   Init Addon   -------------------------
-------------------------------------------------------------------

-- Function: cCr:Initialize
-- init Addon stuff (saved vars, UI, Events)
--
function cCr:Initialize()
	cCr.savedVars = ZO_SavedVars:NewAccountWide("cCrVariables", cCr.varsVersion, nil, cCr.defaults)
	cCr.registerEvents()
	cCr.createNotification()
	cCr.createSettingsWindow()
	
	cCr.portalTimeNoti:SetHandler("OnMoveStop", cCr.SavePosition)
	cCr.portalOrbsNoti:SetHandler("OnMoveStop", cCr.SavePosition)
end

-- Function: cCr.registerEvents
-- register event callbacks
--
function cCr.registerEvents()
	EVENT_MANAGER:RegisterForEvent(cCr.name.."_combatStateChange", EVENT_PLAYER_COMBAT_STATE, cCr.onCombatState)
	
	EVENT_MANAGER:RegisterForEvent(cCr.name.."_portalSpawn", EVENT_COMBAT_EVENT, cCr.onPortalSpawn)
	EVENT_MANAGER:AddFilterForEvent(cCr.name.."_portalSpawn", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, 103946)
	
	EVENT_MANAGER:RegisterForEvent(cCr.name.."_portalClose", EVENT_COMBAT_EVENT, cCr.onPortalClose)
	EVENT_MANAGER:AddFilterForEvent(cCr.name.."_portalClose", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, 104792)
	
	EVENT_MANAGER:RegisterForEvent(cCr.name.."_portalEnterExit", EVENT_COMBAT_EVENT, cCr.onPortalEnter_Exit)
	EVENT_MANAGER:AddFilterForEvent(cCr.name.."_portalEnterExit", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, 108045)
	EVENT_MANAGER:AddFilterForEvent(cCr.name.."_portalEnterExit", EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER)
	
	EVENT_MANAGER:RegisterForEvent(cCr.name.."_portalEnterExit2", EVENT_COMBAT_EVENT, cCr.onPortalEnter_Exit)
	EVENT_MANAGER:AddFilterForEvent(cCr.name.."_portalEnterExit2", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, 104620)
	EVENT_MANAGER:AddFilterForEvent(cCr.name.."_portalEnterExit2", EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER)
	
	EVENT_MANAGER:RegisterForEvent(cCr.name.."_portalExit", EVENT_COMBAT_EVENT, cCr.onPortalExit)
	EVENT_MANAGER:AddFilterForEvent(cCr.name.."_portalExit", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, 105218)
	EVENT_MANAGER:AddFilterForEvent(cCr.name.."_portalExit", EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER)
	
	
end

-- Function: cCr.OnAddOnLoaded
-- event callbacks for ADD_ON_LOADED
--
function cCr.OnAddOnLoaded(event, addonName)

	if addonName == cCr.name then
		cCr:Initialize()
		
		EVENT_MANAGER:UnregisterForEvent(cCr.name, EVENT_ADD_ON_LOADED)
	end

end



EVENT_MANAGER:RegisterForEvent(cCr.name, EVENT_ADD_ON_LOADED, cCr.OnAddOnLoaded)

