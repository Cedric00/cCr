cCr = cCr or {}

cCr.portalTimerVars = {
	portalEnd = 0,
	portalSpawn = 0,

}

-- Function: cCr.onCombatState
-- callback for Combat State Event
--
function cCr.onCombatState(event, inCombat)
	if inCombat then
		if GetZoneId(GetUnitZoneIndex("player")) == cCr.zoneIDs.TRIAL_CLOUDREST then
			if DoesUnitExist('boss1') and GetUnitName('boss1') == "Z'Maja" then
				cCr.startPortalSpawnTimer(55000)
			end
		end
	end


end

-- Function: cCr.onPortalSpawn
-- callback for Combat Event - filtered for ID of portal spawn
--
function cCr.onPortalSpawn(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,_,sourceUnitId,targetUnitId,abilityId)
	cCr.startPortalTimer()
	cCr.resetOrbs()
end

-- Function: cCr.onPortalEnter_Exit
-- callback for Combat Event - filtered for ID of portal entering/exiting
--
function cCr.onPortalEnter_Exit(eventCode,result,isError,abilityName,abilityGraphic,abilityActionSlotType,sourceName,sourceType,targetName,targetType,hitValue,powerType,damageType,_,sourceUnitId,targetUnitId,abilityId)
	if result==ACTION_RESULT_EFFECT_GAINED_DURATION then
		--Portal entering
		if cCr.savedVars.upstairs and cCr.savedVars.portalTimer then
			cCr.portalTimeNoti:SetHidden(false)
		end
		
		if cCr.savedVars.portalOrbs then
			cCr.portalOrbsNoti:SetHidden(false)
		end
		
	elseif result==ACTION_RESULT_EFFECT_FADED then
		--Portal exiting
		if cCr.savedVars.upstairs and cCr.savedVars.locked then
			cCr.portalTimeNoti:SetHidden(true)
		end
	end
end

-- Function: cCr.onPortalExit
-- callback for Combat Event - filtered for ID of portal exiting
--
function cCr.onPortalExit()
	if cCr.savedVars.upstairs and cCr.savedVars.locked then
		cCr.portalTimeNoti:SetHidden(true)
	end
	cCr.portalOrbsNoti:SetHidden(not cCr.savedVars.locked)
end

-- Function: cCr.onPortalClose
-- callback for Combat Event - filtered for ID of portal closing
--
function cCr.onPortalClose()
	EVENT_MANAGER:UnregisterForUpdate("PortalTimerUpdate")
	cCr.startPortalSpawnTimer(45000)
end

-- Function: cCr.startPortalTimer
-- start the counting of portal timer and set UI visible if not "only upstairs"
--
function cCr.startPortalTimer()
	cCr.portalTimeNoti:SetHidden(not (cCr.savedVars.portalTimer and (cCr.savedVars.upstairs or not cCr.savedVars.locked)))
	cCr.portalTimerVars.portalEnd = GetGameTimeMilliseconds()+75000
	EVENT_MANAGER:RegisterForUpdate("PortalTimerUpdate", 200, cCr.updatePortalTimer)
end

-- Function: cCr.updatePortalTimer
-- update the UI displaying portal time
--
function cCr.updatePortalTimer()
	local notiColor = cCr.savedVars.color.portalTimerNoti_Color
	local timerColor = cCr.savedVars.color.portalTimer_Color
	local notiColorString = string.format("%.2x%.2x%.2x", zo_round(notiColor[1] * 255), zo_round(notiColor[2] * 255), zo_round(notiColor[3] * 255))
	local timerColorString = string.format("%.2x%.2x%.2x", zo_round(timerColor[1] * 255), zo_round(timerColor[2] * 255), zo_round(timerColor[3] * 255))
	local portalTime = (cCr.portalTimerVars.portalEnd-GetGameTimeMilliseconds())
	cCr.portalTimeNoti.text:SetText(string.format("|c%sPortal:|r |c%s%d.%d|r", notiColorString, timerColorString, portalTime/1000, (portalTime-math.floor(portalTime/1000)*1000)/100))
	
	if portalTime <= 0 then
		EVENT_MANAGER:UnregisterForUpdate("PortalTimerUpdate")
		cCr.portalTimeNoti:SetHidden(cCr.savedVars.locked or not cCr.savedVars.portalTimer)
	end
end

-- Function: cCr.startPortalSpawnTimer
-- start the counting until spawn of portal and set UI visible if "show portal spawn"
--
-- timeUntilSpawn - time until the next portal spawns
--
function cCr.startPortalSpawnTimer(timeUntilSpawn)

	cCr.portalTimeNoti:SetHidden(not (cCr.savedVars.untilNext or not cCr.savedVars.locked))
	cCr.portalTimerVars.portalSpawn = GetGameTimeMilliseconds()+timeUntilSpawn
	EVENT_MANAGER:RegisterForUpdate("PortalSpawnTimerUpdate", 200, cCr.updatePortalSpawnTimer)


end

-- Function: cCr.updatePortalSpawnTimer
-- update the UI displaying portal spawn time
--
function cCr.updatePortalSpawnTimer()
	local notiColor = cCr.savedVars.color.portalTimerNoti_Color
	local timerColor = cCr.savedVars.color.portalTimer_Color
	local notiColorString = string.format("%.2x%.2x%.2x", zo_round(notiColor[1] * 255), zo_round(notiColor[2] * 255), zo_round(notiColor[3] * 255))
	local timerColorString = string.format("%.2x%.2x%.2x", zo_round(timerColor[1] * 255), zo_round(timerColor[2] * 255), zo_round(timerColor[3] * 255))
	local portalTime = (cCr.portalTimerVars.portalSpawn-GetGameTimeMilliseconds())
	cCr.portalTimeNoti.text:SetText(string.format("|c%sPortal spawn:|r |c%s%d.%d|r", notiColorString, timerColorString, portalTime/1000, (portalTime-math.floor(portalTime/1000)*1000)/100))
	
	if portalTime <= 0 then
		EVENT_MANAGER:UnregisterForUpdate("PortalSpawnTimerUpdate")
		cCr.portalTimeNoti.text:SetText(string.format("|c%sPortal spawn:|r |c%ssoon|r", notiColorString, timerColorString))
	end
end