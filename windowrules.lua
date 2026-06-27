-- Window rules for wofi launcher
hl.window_rule({
	name = "wofi-rules",
	match = { class = "^wofi$" },
	float = true,
	center = true,
	size = "500 400",
})

-- Make GNOME Calculator float instead of tile
hl.window_rule({
	name = "gnome-calculator",
	match = { class = "^(org\\.gnome\\.Calculator)$" },
	float = true,
	size = "360 630",
	center = true,
})

-- Window rules for overskride
hl.window_rule({
	name = "overskride",
	match = { class = "^io\\.github\\.kaii_lb\\.Overskride$" },
	float = true,
	center = true,
	size = "700 600",
})
-- Window rules for clipboard manager (clipmgr)
hl.window_rule({
	name = "clipmgr-float",
	match = { class = "^clipmgr$" },
	float = true,
	center = true,
	size = "800 600",
})

-- Layer rules for walker
hl.config({
	layerrule = {
		"blur, wofi",
		"ignorealpha 0.1, wofi",
	},
})

-- Window rules for waybar-launched kitty terminals
hl.window_rule({
	name = "waybar-kitty",
	match = { class = "^waybar-kitty$" },
	float = true,
	center = true,
	size = "800 600",
})

--hl.window_rule({
--	name = "waybar-sigye",
--	match = { class = "^waybar-sigye$" },
--	float = true,
--	center = true,
--	size = "600 300",
--	})
