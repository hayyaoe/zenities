-- Auto Start Config

hl.on("hyprland.start", function() 
	-- Notify UWSM that the compositor is initialized
	hl.exec_cmd("uwsm finalize")
	
	hl.exec_cmd("uwsm app -- qs")
end)
