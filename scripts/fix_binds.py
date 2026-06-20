import re

with open("/home/amiel/.config/hypr/binds.lua", "r") as f:
    lines = f.readlines()

out = []
for line in lines:
    line = line.rstrip()
    
    # We need to find lines like hl.bind("SUPER SHIFT + K", ...
    # And change it to hl.bind("SUPER + SHIFT + K", ...
    
    # Match the whole string argument for hl.bind: hl.bind("MODS + KEY", ...
    m = re.match(r'^(\s*hl\.bind\(")([^"]+)(".*)', line)
    if m:
        bind_str = m.group(2)
        rest = m.group(3)
        # bind_str looks like "SUPER SHIFT + RETURN"
        # Split by '+'
        parts = [p.strip() for p in bind_str.split('+')]
        
        if len(parts) >= 1:
            # The first part is modifiers separated by space "SUPER SHIFT"
            mods = parts[0].split()
            # If there's more parts (the key)
            if len(parts) > 1:
                # e.g., parts[1] is 'RETURN'
                new_bind_str = " + ".join(mods + parts[1:])
            else:
                new_bind_str = " + ".join(mods)
            
            # fix ~
            if new_bind_str.endswith("+ ~"):
                new_bind_str = new_bind_str[:-1] + "grave"
            if new_bind_str == "~":
                new_bind_str = "grave"
                
            out.append(f'{m.group(1)}{new_bind_str}{rest}')
        else:
            out.append(line)
    else:
        out.append(line)

with open("/home/amiel/.config/hypr/binds.lua", "w") as f:
    f.write("\n".join(out) + "\n")
