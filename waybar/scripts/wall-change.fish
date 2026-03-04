#!/usr/bin/fish
set DIR "$HOME"'/Pictures/Wallpapers'
# Select Wallpaper
set CHOICE (ls "$DIR" | sed 's/^/  /' | wofi --show dmenu --prompt 'Select Wallpaper' --style "$HOME"'/.cache/wal/colors-wofi.css' --width 400 --height 500 | string collect; or echo)
[ -z "$CHOICE" ] && exit 0
set FILENAME (echo "$CHOICE" | sed 's/^  //' | string collect; or echo)
set FULL_PATH "$DIR"'/'"$FILENAME"
swww img "$FULL_PATH" --transition-type grow --transition-pos center
wal -i "$FULL_PATH" -q
sed -i 's/alpha=ff/alpha=1.0/g' $HOME/.cache/wal/colors-foot.ini
pkill -USR1 foot
cp "$FULL_PATH" "$HOME"'/.cache/wal/target_wallpaper.png'
# 3. FORCE WAYBAR TO RELOAD COLORS
# USR2 tells waybar to reload the CSS specifically
pkill -USR2 waybar
# 4. Optional: If you want your borders to update in Hyprland too
hyprctl reload
# 5. Update Hyprland borders
# We use cut to remove the '#' from the pywal variables
set COLOR4 (echo "$color4" | cut -d'#' -f2 | string collect; or echo)
set COLOR1 (echo "$color1" | cut -d'#' -f2 | string collect; or echo)
set BG (echo "$background" | cut -d'#' -f2 | string collect; or echo)
hyprctl setoption general:col.active_border 'rgb('"$COLOR4"') rgb('"$COLOR1"') 45deg'
hyprctl setoption general:col.inactive_border 'rgba('"$BG"'aa)'
# Kill wofi so it reloads the new pywal colors on next launch
pkill wofi
