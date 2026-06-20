import re

with open("/home/amiel/.config/hypr/binds.lua", "r") as f:
    lines = f.readlines()

out = []
for line in lines:
    line = line.rstrip()
    
    # hl.bindm -> hl.bind(..., {mouse = true})
    m = re.match(r'^(\s*)hl\.bindm\("([^"]*)",\s*"([^"]*)",\s*"movewindow"\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + {m.group(3)}", hl.dsp.window.drag(), {{ mouse = true }})')
        continue

    m = re.match(r'^(\s*)hl\.bindm\("([^"]*)",\s*"([^"]*)",\s*"resizewindow"\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + {m.group(3)}", hl.dsp.window.resize(), {{ mouse = true }})')
        continue

    # hl.bind("MOD", "KEY", "exec", cmd)
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*"([^"]*)",\s*"exec",\s*(.*)\)', line)
    if m:
        mod = m.group(2)
        key = m.group(3)
        cmd = m.group(4)
        prefix = f"{mod} + {key}" if mod else key
        out.append(f'{m.group(1)}hl.bind("{prefix}", hl.dsp.exec_cmd({cmd}))')
        continue

    # hl.bind("MOD", tostring(i), "workspace", tostring(i))
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*tostring\(([^)]+)\),\s*"workspace",\s*tostring\(([^)]+)\)\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + " .. {m.group(3)}, hl.dsp.focus({{ workspace = {m.group(4)} }}))')
        continue

    # hl.bind("SUPER", "0", "workspace", "10")
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*"([^"]*)",\s*"workspace",\s*"([^"]*)"\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + {m.group(3)}", hl.dsp.focus({{ workspace = {m.group(4)} }}))')
        continue

    # hl.bind("MOD", tostring(i), "movetoworkspace", tostring(i))
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*tostring\(([^)]+)\),\s*"movetoworkspace",\s*tostring\(([^)]+)\)\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + " .. {m.group(3)}, hl.dsp.window.move({{ workspace = {m.group(4)} }}))')
        continue

    # hl.bind("MOD", "KEY", "movetoworkspace", "10")
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*"([^"]*)",\s*"movetoworkspace",\s*"([^"]*)"\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + {m.group(3)}", hl.dsp.window.move({{ workspace = {m.group(4)} }}))')
        continue

    # hl.bind("SUPER", "W", "killactive")
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*"([^"]*)",\s*"killactive"\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + {m.group(3)}", hl.dsp.window.close())')
        continue

    # hl.bind("MOD", "KEY", "fullscreen")
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*"([^"]*)",\s*"fullscreen"\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + {m.group(3)}", hl.dsp.window.fullscreen())')
        continue

    # togglefloating
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*"([^"]*)",\s*"togglefloating"\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + {m.group(3)}", hl.dsp.window.float({{ action = "toggle" }}))')
        continue

    # exit
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*"([^"]*)",\s*"exit"\)', line)
    if m:
        out.append(f'{m.group(1)}hl.bind("{m.group(2)} + {m.group(3)}", hl.dsp.exit())')
        continue

    # moveactive, resizeactive, cyclenext, movefocus, swapwindow, pseudo, pin
    # For unsupported or other commands, let's just rewrite as string action if supported, or exec hyprctl dispatch
    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*"([^"]*)",\s*"([^"]*)",\s*"([^"]*)"\)', line)
    if m:
        mod = m.group(2)
        key = m.group(3)
        action = m.group(4)
        args = m.group(5)
        prefix = f"{mod} + {key}" if mod else key
        if action == "movefocus":
            dir_map = {"l": "left", "r": "right", "u": "up", "d": "down"}
            out.append(f'{m.group(1)}hl.bind("{prefix}", hl.dsp.focus({{ direction = "{dir_map.get(args, args)}" }}))')
        elif action == "workspace":
             out.append(f'{m.group(1)}hl.bind("{prefix}", hl.dsp.focus({{ workspace = "{args}" }}))')
        else:
             out.append(f'{m.group(1)}hl.bind("{prefix}", hl.dsp.exec_cmd("hyprctl dispatch {action} {args}"))')
        continue

    m = re.match(r'^(\s*)hl\.bind\("([^"]*)",\s*"([^"]*)",\s*"([^"]*)"\)', line)
    if m:
        mod = m.group(2)
        key = m.group(3)
        action = m.group(4)
        prefix = f"{mod} + {key}" if mod else key
        if action == "pseudo":
            out.append(f'{m.group(1)}hl.bind("{prefix}", hl.dsp.window.pseudo())')
        elif action == "pin":
            out.append(f'{m.group(1)}hl.bind("{prefix}", hl.dsp.window.pin())')
        else:
            out.append(f'{m.group(1)}hl.bind("{prefix}", hl.dsp.exec_cmd("hyprctl dispatch {action}"))')
        continue

    out.append(line)

with open("/home/amiel/.config/hypr/binds.lua", "w") as f:
    f.write("\n".join(out) + "\n")
