hl.on("hyprland.start", function()
	-- local f = io.open("/tmp/hldump.txt", "w")
	-- for k,v in pairs(hl.dsp) do
	--    f:write(tostring(k) .. "\n")
	-- end
	-- if type(hl.dsp.window) == "table" then
	--    f:write("window:\n")
	--    for k,v in pairs(hl.dsp.window) do f:write(tostring(k) .. "\n") end
	-- end
	-- f:close()
	hl.exec_cmd("/home/amiel/.config/hypr/scripts/portal-start.sh &")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &")
	hl.exec_cmd("nm-applet &")
	hl.exec_cmd("blueman-applet &")
	hl.exec_cmd("waybar &")
	-- hl.exec_cmd("hyprpaper &")
	hl.exec_cmd("elephant &")
	-- hl.exec_cmd("walker --gapplication-service &")
	hl.exec_cmd("swaybg -i /home/amiel/.config/hypr/wallpapers/jap2.jpg -m fill &")
	hl.exec_cmd("dunst &")
	hl.exec_cmd("hyprsunset &")
	-- hl.exec_cmd("cclipd -s 2 -t \"image/png\" -t \"image/*\" -t \"text/plain;charset=utf-8\" -t \"text/*\" -t \"*\" &")
	hl.exec_cmd("wl-paste --type text --watch cliphist store &")
	hl.exec_cmd("wl-paste --type image --watch cliphist store &")
	-- hl.exec_cmd("python3 /home/amiel/.config/hypr/scripts/clipmgr.py daemon &")

	-- Start Ollama
	hl.exec_cmd("systemctl --user start ollama || ollama serve &")
	hl.exec_cmd("systemctl --user start hypridle.service &")
	hl.exec_cmd("/home/amiel/.config/hypr/scripts/sync-others.sh watch &")

	-- Start PicoClaw in background (optional)
	-- hl.exec_cmd("foot -e sh -c 'picoclaw agent 2>/dev/null' &")

	-- Start Docker
	-- h1.exec_cmd("docker start oracle-xe &")
end)
