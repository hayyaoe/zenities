-- Window Rules

-- Ignore maximize request from all apps
hl.window_rule({
	name = "supress-maximize-events",
	match = {class=".*"},

	suppress_event = "maximize",
})

-- Fix dragging issue with xwayland
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})


