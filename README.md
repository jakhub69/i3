# i3 config

> an os is a tool. its job is to manage files and run programs. any graphical bloat is absolutely useless. save ram wherever you are.

highly optimized, minimal, and lightweight i3wm setup. no desktop environment bloat, no heavy compositors eating cpu cycles, and zero background telemetry. built strictly for raw performance, maximum responsiveness, and high-fps gaming (pushing 800+ fps in cs2 on a ryzen 7 5700x3d and rtx 4070). x11 still rules.

![](https://i.imgur.com/P7nblkL.png)

## features
- zero-bloat philosophy: stripped down to free up every possible system resource.
- smart autotiling: uses autotiling to dynamically switch window split directions (horizontal/vertical) based on window geometry—perfect for dual 1440p monitors.
- custom system monitor: a lightweight bash script hooked to a hotkey that fetches system stats (ram, disk, cpu, gpu usage + temp) directly from /proc/stat and nvidia-smi without heavy polling daemons.
- industrial dunst styling: sharp, border-focused, rectangular notification blocks using a monospace font with zero useless transparency or rounded corners.
- media-aware screen management: configured with caffeine to prevent display sleeping only when audio or full-screen streams are active.

## components
- window manager: i3wm (raw, manual tiling under x11)
- notifications: dunst (custom text-only notification daemon)
- layout automation: autotiling (python script for automatic binary splits)
- font: gomononerdfont / monospace

## keybindings

### core / apps
- `$mod + q` -> kill focused window
- `$mod + e` -> launch file manager
- `$mod + d` -> launch rofi in desktop run mode
- `$mod + return` -> launch terminal
- `$mod + shift + space` -> launch rofi in command run mode
- `$mod + shift + x` -> restart i3 in-place
- `$mod + shift + l` -> exit i3 (log out)

### system utilities & notifications
- `$mod + shift + s` -> take screenshot of a selected area, save to ~/obrazy/, copy to clipboard + send dunst notification
- `$mod + shift + f` -> trigger custom system info script
- `$mod + shift + v` -> send notification with current volume
- `$mod + shift + w` -> send notification with live weather from wttr.in
- `$mod + shift + d` -> send notification with day, date, and time
- `$mod + shift + u` -> send notification with system uptime from /proc/uptime

### window & display layout
- `$mod + shift + left` -> move current container to the left monitor
- `$mod + shift + right` -> move current container to the right monitor
- `$mod + a` -> toggle floating mode for focused window
- `$mod + [up/down/left/right]` -> enter resize mode
