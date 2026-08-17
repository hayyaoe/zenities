-- config main mod
local mainMod = "SUPER"

-- load apps
local apps = require("user.apps")

-- open terminal emulator
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(apps.terminal))

-- open app launcher
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(apps.menu))

-- open browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(apps.browser))

-- open file manager 
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(apps.terminal .. " -e " .. apps.file_manager))

