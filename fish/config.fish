### --- SETTINGS --- ###
set -g fish_greeting ""

### --- PATH --- ###
fish_add_path "$HOME/.local/bin"

### --- PYWAL COLORS --- ###
# Sync colors on startup
if test -f ~/.cache/wal/colors.sh
    babelfish <~/.cache/wal/colors.sh >~/.cache/wal/colors.fish
    source ~/.cache/wal/colors.fish
end

# Send sequences to terminal for pywal support
if test -f ~/.cache/wal/sequences
    cat ~/.cache/wal/sequences &
end

### --- ABBREVIATIONS & ALIASES --- ###
abbr -a xi 'doas xbps-install -S'
abbr -a xu 'doas xbps-install -Su'
abbr -a xr 'doas xbps-remove -R'
abbr -a xs 'xbps-query -Rs'

alias ls='ls --color=auto'
alias vim='nvim'
alias vi='nvim'
alias spotify='dbus-run-session spotify'
alias tlauncher='java -jar ~/Games/TLauncher/starter-core.jar'

function dots-push
    set -l current_dir (pwd)
    cd ~/Void-Hyprland
    git add .
    git commit -m "Update dots: (date +%Y-%m-%d_%H:%M)"
    git push origin main
    cd $current_dir
end

### --- PROGRAMS --- ###

# Initialize Starship Prompt (ONLY ONCE)
if type -q starship
    starship init fish | source
end
