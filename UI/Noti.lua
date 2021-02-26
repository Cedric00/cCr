cCr = cCr or {}
local wim = GetWindowManager()

local sf = 1/GetSetting(SETTING_TYPE_UI, UI_SETTING_CUSTOM_SCALE)

cCr.portalTimeNoti = {}
cCr.portalOrbsNoti = {}

function cCr.refreshUI()
	local noti = cCr.portalTimeNoti
	
	--noti.text:SetColor(unpack(cCr.savedVars.color.portalTimer_Color))
	local notiColor = cCr.savedVars.color.portalTimerNoti_Color
	local timerColor = cCr.savedVars.color.portalTimer_Color
	local notiColorString = string.format("%.2x%.2x%.2x", zo_round(notiColor[1] * 255), zo_round(notiColor[2] * 255), zo_round(notiColor[3] * 255))
	local timerColorString = string.format("%.2x%.2x%.2x", zo_round(timerColor[1] * 255), zo_round(timerColor[2] * 255), zo_round(timerColor[3] * 255))
	
	noti.text:SetText(string.format("|c%sPortal:|r |c%s90.0|r", notiColorString, timerColorString))
	
	local orbBackgroundColor = cCr.savedVars.color.portalOrbsBackground_Color
	cCr.portalOrbsNoti.backdrop:SetCenterColor(orbBackgroundColor[1], orbBackgroundColor[2], orbBackgroundColor[3], orbBackgroundColor[4])
	
end

function cCr.createNotification()
	local portalTimerTLW = {}

	portalTimerTLW = wim:CreateTopLevelWindow()
	portalTimerTLW:SetDimensions(340, 60)
	portalTimerTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, cCr.savedVars.position.portalTimer_X, cCr.savedVars.position.portalTimer_Y)
	portalTimerTLW:SetMovable(not cCr.savedVars.locked)
	portalTimerTLW:SetMouseEnabled(not cCr.savedVars.locked)
	portalTimerTLW:SetClampedToScreen(true)
	portalTimerTLW:SetHidden(cCr.savedVars.locked)

	portalTimerTLW.backdrop = wim:CreateControl(nil, portalTimerTLW, CT_BACKDROP)
	portalTimerTLW.backdrop:SetAnchorFill()
	portalTimerTLW.backdrop:SetDrawLayer(1)
	portalTimerTLW.backdrop:SetHidden(false)
	portalTimerTLW.backdrop:SetCenterColor(1, 1, 1, 0)
	if cCr.savedVars.locked then
		portalTimerTLW.backdrop:SetEdgeColor(0, 0, 0, 0)
	else
		portalTimerTLW.backdrop:SetEdgeColor(1, 1, 1, 1)
	end
	portalTimerTLW.backdrop:SetEdgeTexture(nil, 1, 1, (2*sf))

	
	
	portalTimerTLW.text = wim:CreateControl(nil, portalTimerTLW, CT_LABEL)
	portalTimerTLW.text:SetAnchor(CENTER, portalTimerTLW, CENTER)
	portalTimerTLW.text:SetDrawLayer(2)
	portalTimerTLW.text:SetDrawLevel(1)
	portalTimerTLW.text:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
	portalTimerTLW.text:SetVerticalAlignment(TEXT_ALIGN_BOTTOM)
	portalTimerTLW.text:SetAlpha(0.9)
	--portalTimerTLW.text:SetColor(unpack(cCr.savedVars.color.portalTimer_Color))
	--portalTimerTLW.text:SetFont("$(BOLD_FONT)|$(KB_40)|thick-outline")
	portalTimerTLW.text:SetFont("$(BOLD_FONT)|$(KB_40)|soft-shadow-thick")	--fav.
	--portalTimerTLW.text:SetFont("$(BOLD_FONT)|$(KB_20)|thick-outline")
	
	local notiColor = cCr.savedVars.color.portalTimerNoti_Color
	local timerColor = cCr.savedVars.color.portalTimer_Color
	local notiColorString = string.format("%.2x%.2x%.2x", zo_round(notiColor[1] * 255), zo_round(notiColor[2] * 255), zo_round(notiColor[3] * 255))
	local timerColorString = string.format("%.2x%.2x%.2x", zo_round(timerColor[1] * 255), zo_round(timerColor[2] * 255), zo_round(timerColor[3] * 255))
	
	portalTimerTLW.text:SetText(string.format("|c%sPortal:|r |c%s90.0|r", notiColorString, timerColorString))
	
	
	cCr.portalTimeNoti = portalTimerTLW


	local portalOrbTLW = {}
	portalOrbTLW = wim:CreateTopLevelWindow()
	portalOrbTLW:SetDimensions(220, 60)
	portalOrbTLW:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, cCr.savedVars.position.portalOrbs_X, cCr.savedVars.position.portalOrbs_Y)
	portalOrbTLW:SetMovable(not cCr.savedVars.locked)
	portalOrbTLW:SetMouseEnabled(not cCr.savedVars.locked)
	portalOrbTLW:SetClampedToScreen(true)
	portalOrbTLW:SetHidden(cCr.savedVars.locked)
	
	portalOrbTLW.backdrop = wim:CreateControl(nil, portalOrbTLW, CT_BACKDROP)
	portalOrbTLW.backdrop:SetAnchorFill()
	portalOrbTLW.backdrop:SetDrawLayer(1)
	portalOrbTLW.backdrop:SetHidden(false)
	portalOrbTLW.backdrop:SetCenterColor(1, 1, 1, 0.5)
	if cCr.savedVars.locked then
		portalOrbTLW.backdrop:SetEdgeColor(0, 0, 0, 0)
	else
		portalOrbTLW.backdrop:SetEdgeColor(1, 1, 1, 1)
	end
	portalOrbTLW.backdrop:SetEdgeTexture(nil, 1, 1, (2*sf))
	
	
	--Orb 1--
	portalOrbTLW.texture1 = wim:CreateControl(nil, portalOrbTLW, CT_TEXTURE)
	portalOrbTLW.texture1:SetAnchor(CENTER, portalOrbTLW, CENTER, -60, 0)
	portalOrbTLW.texture1:SetDrawLayer(2)
	portalOrbTLW.texture1:SetDrawLevel(1)
	portalOrbTLW.texture1:SetAlpha(0.4)
	portalOrbTLW.texture1:SetTexture("cCr/UI/OrbImage_Hidden.dds")
	portalOrbTLW.texture1:SetHidden(false)
	portalOrbTLW.texture1:SetDimensions(45, 45)
	--Checkmark1--
	portalOrbTLW.checkmark1 = wim:CreateControl(nil, portalOrbTLW, CT_TEXTURE)
	portalOrbTLW.checkmark1:SetAnchor(CENTER, portalOrbTLW, CENTER, -60, 0)
	portalOrbTLW.checkmark1:SetDrawLayer(2)
	portalOrbTLW.checkmark1:SetDrawLevel(2)
	portalOrbTLW.checkmark1:SetAlpha(0.9)
	portalOrbTLW.checkmark1:SetTexture("cCr/UI/Checkmark.dds")
	portalOrbTLW.checkmark1:SetHidden(true)
	portalOrbTLW.checkmark1:SetDimensions(80, 80)
	--Orb 2--
	portalOrbTLW.texture2 = wim:CreateControl(nil, portalOrbTLW, CT_TEXTURE)
	portalOrbTLW.texture2:SetAnchor(CENTER, portalOrbTLW, CENTER, 0, 0)
	portalOrbTLW.texture2:SetDrawLayer(2)
	portalOrbTLW.texture2:SetDrawLevel(1)
	portalOrbTLW.texture2:SetAlpha(0.9)
	portalOrbTLW.texture2:SetTexture("cCr/UI/OrbImage.dds")
	portalOrbTLW.texture2:SetHidden(false)
	portalOrbTLW.texture2:SetDimensions(45, 45)
	--Checkmark2--
	portalOrbTLW.checkmark2 = wim:CreateControl(nil, portalOrbTLW, CT_TEXTURE)
	portalOrbTLW.checkmark2:SetAnchor(CENTER, portalOrbTLW, CENTER, 0, 0)
	portalOrbTLW.checkmark2:SetDrawLayer(2)
	portalOrbTLW.checkmark2:SetDrawLevel(2)
	portalOrbTLW.checkmark2:SetAlpha(0.9)
	portalOrbTLW.checkmark2:SetTexture("cCr/UI/Checkmark.dds")
	portalOrbTLW.checkmark2:SetHidden(true)
	portalOrbTLW.checkmark2:SetDimensions(80, 80)
	--Orb 3--
	portalOrbTLW.texture3 = wim:CreateControl(nil, portalOrbTLW, CT_TEXTURE)
	portalOrbTLW.texture3:SetAnchor(CENTER, portalOrbTLW, CENTER, 60, 0)
	portalOrbTLW.texture3:SetDrawLayer(2)
	portalOrbTLW.texture3:SetDrawLevel(1)
	portalOrbTLW.texture3:SetAlpha(0.9)
	portalOrbTLW.texture3:SetTexture("cCr/UI/OrbImage.dds")
	portalOrbTLW.texture3:SetHidden(false)
	portalOrbTLW.texture3:SetDimensions(45, 45)
	--Checkmark3--
	portalOrbTLW.checkmark3 = wim:CreateControl(nil, portalOrbTLW, CT_TEXTURE)
	portalOrbTLW.checkmark3:SetAnchor(CENTER, portalOrbTLW, CENTER, 60, 0)
	portalOrbTLW.checkmark3:SetDrawLayer(2)
	portalOrbTLW.checkmark3:SetDrawLevel(2)
	portalOrbTLW.checkmark3:SetAlpha(0.9)
	portalOrbTLW.checkmark3:SetTexture("cCr/UI/Checkmark.dds")
	portalOrbTLW.checkmark3:SetHidden(false)
	portalOrbTLW.checkmark3:SetDimensions(80, 80)
	
	
	cCr.portalOrbsNoti = portalOrbTLW


end