cCr = cCr or {}
local LAM2 = LibAddonMenu2

function cCr.createSettingsWindow()
	local panelData = {
		type = "panel",
		name = cCr.name,
		displayName = cCr.name,
		author = "Eragon49",
		version = tostring(cCr.version),
		registerForRefresh = true,
		registerForDefaults = true,
	}
	local ctrlOptionsPanel = LAM2:RegisterAddonPanel("cCrSettings", panelData)

	local optionsData = {
		
		{
			type = "checkbox",
			name = "Lock UI",
			tooltip = "Unlock to move the Interface",
			default = cCr.defaults.locked,
			getFunc = function() return cCr.savedVars.locked end,
			setFunc = function(newValue)
				cCr.savedVars.locked = newValue
				cCr.lock(newValue)
			end,
		},
		{
			type = "header",
			name = "Portal Timer"
		},
		{
			type = "checkbox",
			name = "Show portal timer",
			tooltip = "Show timer how long until portal wipe",
			default = cCr.defaults.portalTimer,
			getFunc = function() return cCr.savedVars.portalTimer end,
			setFunc = function(newValue)
				cCr.savedVars.portalTimer = newValue
				cCr.lock(cCr.savedVars.locked)
			end,
		},
		{
			type = "checkbox",
			name = "Show upstairs",
			tooltip = "Show the timer even if not in portal",
			default = cCr.defaults.upstairs,
			getFunc = function() return cCr.savedVars.upstairs end,
			setFunc = function(newValue)
				cCr.savedVars.upstairs = newValue
			end,
		},
		{
			type = "colorpicker",
			name = "Notification Color",
			default = function() return unpack(cCr.defaults.color.portalTimerNoti_Color) end,
			getFunc = function() return unpack(cCr.savedVars.color.portalTimerNoti_Color) end,
			setFunc = function(r, g, b, a)
				cCr.savedVars.color.portalTimerNoti_Color = {r, g, b, a}
				cCr.refreshUI()
			end,
		},
		{
			type = "colorpicker",
			name = "Timer Color",
			default = function() return unpack(cCr.defaults.color.portalTimer_Color) end,
			getFunc = function() return unpack(cCr.savedVars.color.portalTimer_Color) end,
			setFunc = function(r, g, b, a)
				cCr.savedVars.color.portalTimer_Color = {r, g, b, a}
				cCr.refreshUI()
			end,
		},
		{
			type = "checkbox",
			name = "Show time until next portal",
			tooltip = "After portal is done show timer until next portal appears",
			default = cCr.defaults.untilNext,
			getFunc = function() return cCr.savedVars.untilNext end,
			setFunc = function(newValue)
				cCr.savedVars.untilNext = newValue
			end,
		},
		{
			type = "header",
			name = "Portal Orb tracker"
		},
		{
			type = "checkbox",
			name = "Show orb tracker",
			tooltip = "Track the orbs in portal",
			default = cCr.defaults.portalOrbs,
			getFunc = function() return cCr.savedVars.portalOrbs end,
			setFunc = function(newValue)
				cCr.savedVars.portalOrbs = newValue
				cCr.lock(cCr.savedVars.locked)
			end,
		},
		{
			type = "colorpicker",
			name = "Background Color",
			default = function() return unpack(cCr.defaults.color.portalOrbsBackground_Color) end,
			getFunc = function() return unpack(cCr.savedVars.color.portalOrbsBackground_Color) end,
			setFunc = function(r, g, b, a)
				cCr.savedVars.color.portalOrbsBackground_Color = {r, g, b, a}
				cCr.refreshUI()
			end,
		},
		--[[{
			type = "slider",
			name = GetString(SI_JOGROUP_OORALPHA),
			min = 10,
			max = 100,
			step = 5,
			default = (Jo.defaults.opacity.oorAlpha*100),
			getFunc = function() return zo_round(Jo.savedVars.opacity.oorAlpha*100) end,
			setFunc = function(newValue)
				Jo.savedVars.opacity.oorAlpha = zo_roundToNearest((newValue/100), .01)
				Jo.UpdateUnits()
			end,
		},
		{
			type = "dropdown",
			name = "Sort by",
			choices = {
				"index",
				"role",
			},
			default = Jo.defaults.ordening.sort,
			getFunc = function() return Jo.savedVars.ordening.sort end,
			setFunc = function(newValue)
				Jo.savedVars.ordening.sort = newValue
				Jo.ReAnchor()
			end,
		},
		{
			type = "colorpicker",
			name = "Shield colour",
			default = function() return unpack(Jo.defaults.colours.shield) end,
			getFunc = function() return unpack(Jo.savedVars.colours.shield) end,
			setFunc = function(r, g, b, a)
				Jo.savedVars.colours.shield = {r, g, b, a}
				Jo.CustomizeUnits()
			end,
		},
		{
			type = "header",
			name = SI_JOGROUP_SHOWHIDE
		},]]--	
	}
	LAM2:RegisterOptionControls("cCrSettings", optionsData)

end