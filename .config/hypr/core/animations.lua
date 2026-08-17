-- animations config

-- curve definition
hl.curve("basic", { type = "bezier", points = { {0.05, 0.8}, {0.1, 1} } })

-- animations
hl.animation({ leaf = "global",     enabled = true, speed = 8, bezier= "default"})
hl.animation({ leaf = "windows",    enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "default", style = "popin 95%"})
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "windowsMove",enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default", style = "slidevert" })
