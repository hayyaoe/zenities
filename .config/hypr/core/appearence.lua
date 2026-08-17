-- appearenace config

hl.config({
	general = {
		gaps_in=4,
		gaps_out=8,

		border_size=0,
		
		resize_on_border = false,
		allow_tearing = false,

		layout="dwindle",
	},

	decoration = {
		rounding = 14,

		active_opacity=1.0,
		inactive_opacity=0.9,

		blur = {
			enabled=false,
			vibrancy=0.8,
			contrast=0.6,
			size=8,
			passes=2,
			ignore_opacity=false,
		},

		shadow = {
			enabled=false,
			sharp=false,
		},
		--blurls=gtk-layer-shell,
	},

	cursor = {
		no_hardware_cursors=true
	},

	animations = {
		enabled=true
	},
})
