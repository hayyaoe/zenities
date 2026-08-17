-- input configs here

-- keyborad and mouse settings
hl.config({
	input = {
		kb_layout="us",
		kb_variant="",
		kb_model="",
		kb_options="",
		kb_rules="",
	
		follow_mouse=1,

		touchpad = {
			natural_scroll=true,
		},
	},
})

-- swipe gesture
hl.gesture({
	fingers=3,
	direction="horizontal",
	action="workspace",
})

-- mouse  (per device setting)
hl.device({
	name="epic-mouse-v1",
	sensitivity=0.45,
	accel_profile=flat,
})
