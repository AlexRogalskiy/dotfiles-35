local wezterm = require 'wezterm';

return {
    font = wezterm.font("Hack Nerd Font Mono", {weight="Regular",stretch="Expanded"}),
    font_size = 14,
    -- color_scheme = "Dracula+",
    colors = {
        foreground = "#c0caf5",
        background = "#24283b",
        cursor_bg = "#c0caf5",
        cursor_border = "#c0caf5",
        cursor_fg = "#24283b",
        selection_bg = "#364A82",
        selection_fg = "#c0caf5",
        ansi = {"#1D202F", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6"},
        brights = {"#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5"},
    },
    -- default_cwd = "/Users/jun/Documents/workspace",
}
