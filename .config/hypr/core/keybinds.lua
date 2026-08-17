-- Keybinds

local mainMod = "SUPER"

-- close active apps
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- window keybinds
hl.bind(mainMod .. " + V", hl.dsp.window.float({action = "toggle"}))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({action = "toggle"}))

-- window focus
hl.bind(mainMod .. " + left", hl.dsp.focus({direction = "left"}))
hl.bind(mainMod .. " + right", hl.dsp.focus({direction = "right"}))
hl.bind(mainMod .. " + up", hl.dsp.focus({direction = "up"}))
hl.bind(mainMod .. " + down", hl.dsp.focus({direction = "down"}))

-- window move and resize using mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), {mouse = "true"})
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), {direction = "true"})

-- window resize using keyboard
hl.bind("ALT + N", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("left", hl.dsp.window.resize({x=-10, y=0, relative=true}), {repeating=true})
	hl.bind("right", hl.dsp.window.resize({x=10, y=0, relative=true}), {repeating=true})
	hl.bind("up", hl.dsp.window.resize({x=0, y=10, relative=true}), {repeating=true})
	hl.bind("down", hl.dsp.window.resize({x=0, y=-10, relative=true}), {repeating=true})

	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- (floatig) window move using keyboard
hl.bind("ALT + M", hl.dsp.submap("move"))

hl.define_submap("move", function()
	hl.bind("left", hl.dsp.window.move({x=-10, y=0, relative=true}), {repeating=true})
	hl.bind("right", hl.dsp.window.move({x=10, y=0, relative=true}), {repeating=true})
	hl.bind("up", hl.dsp.window.move({x=0, y=10, relative=true}), {repeating=true})
	hl.bind("down", hl.dsp.window.move({x=0, y=-10, relative=true}), {repeating=true})

	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- workspace switching
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({workspace = i}))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({workspace = i}))
end

-- workspace scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({workspace = "e+1"}))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({workspace = "e-1"}))

-- laptop multimedia keybinds
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && qs ipc call volume update"), {locked=true, repeating=true})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%- && qs ipc call volume update"), {locked=true, repeating=true})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && qs ipc call volume update"), {locked=true, repeating=true})
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute -l 1 @DEFAULT_AUDIO_SOURCE@ toggle && qs ipc call mic update"), {locked=true, repeating=true})
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+ && qs ipc call brightness update"), {locked=true, repeating=true})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%- && qs ipc call brightness update"), {locked=true, repeating=true})

