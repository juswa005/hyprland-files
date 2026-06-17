-- Window rules for wofi launcher
hl.window_rule("match:class ^wofi$", "float 1")
hl.window_rule("match:class ^wofi$", "center 1")
hl.window_rule("match:class ^wofi$", "size 500 400")

-- Make GNOME Calculator float instead of tile
hl.window_rule("match:class ^(org\\.gnome\\.Calculator)$", "float 1")
hl.window_rule("match:class ^(org\\.gnome\\.Calculator)$", "size 360 630")
hl.window_rule("match:class ^(org\\.gnome\\.Calculator)$", "center 1")

-- Window rules for overskride
hl.window_rule("match:class ^io\\.github\\.kaii_lb\\.Overskride$", "float 1")
hl.window_rule("match:class ^io\\.github\\.kaii_lb\\.Overskride$", "center 1")
hl.window_rule("match:class ^io\\.github\\.kaii_lb\\.Overskride$", "size 500 400")
