local wezterm = require 'wezterm';

local function hsl(color, saturation, brightness)
    return string.format("hsl:%d %d %d", color, saturation, brightness) 
end

local colors = {
    Background = hsl(250,50,15),
    Primary = {
        shade0 = hsl(250,100, 25),
        shade1 = hsl(250,100, 35),
        shade2 = hsl(250,100, 55),
        shade3 = hsl(250,100, 85),
    },
    Secondary = {
        shade0 = hsl(300, 75, 20),
        shade1 = hsl(300, 75, 40),
        shade2 = hsl(300, 75, 60),
        shade3 = hsl(300, 75, 80),
    },
    Tertiary = {
        shade0 = hsl(50, 75, 40),
        shade1 = hsl(50, 75, 50),
        shade2 = hsl(50, 75, 60),
        shade3 = hsl(50, 75, 70),
    },
    Quartenary = {
        shade0 = hsl(0, 100, 20),
        shade1 = hsl(0, 100, 40),
        shade2 = hsl(0, 100, 60),
        shade3 = hsl(0, 100, 80),
    },
    Quintary = {
        shade0 = hsl(170, 100, 20),
        shade1 = hsl(170, 100, 40),
        shade2 = hsl(170, 100, 60),
        shade3 = hsl(170, 100, 80),
    }
}

return {
    default_prog = { 'powershell.exe', '-NoLogo' },
    font = wezterm.font_with_fallback {
        'Recursive',
        { family = 'Recursive', weight = "Bold", stretch = "SemiCondensed" },
        'Symbols Nerd Font Mono',
        'Segoe UI Emoji' 
    },
    window_background_opacity = 1,
    font_size = 18.0,
    colors = {

        foreground = colors.Secondary.shade3,
        background = colors.Background,

        cursor_bg = colors.Quintary.shade2,
        cursor_fg = colors.Quartenary.shade0,

        selection_fg = colors.Quintary.shade2,
        selection_bg = colors.Quartenary.shade0,

        scrollbar_thumb = colors.Tertiary.shade0,

        split = colors.Secondary.shade0,

        ansi = {
            colors.Primary.shade0,
            colors.Secondary.shade0,
            colors.Quintary.shade1,
            colors.Tertiary.shade1,
            colors.Primary.shade1,
            colors.Quartenary.shade1,
            colors.Secondary.shade1,
            hsl(250, 20, 40),
        },
        brights = {
            colors.Primary.shade2,
            colors.Secondary.shade2,
            colors.Quintary.shade3,
            colors.Tertiary.shade3,
            colors.Primary.shade3,
            colors.Quartenary.shade3,
            colors.Secondary.shade3,
            hsl(250, 20, 80),
        },


        compose_cursor = 'orange',

        -- Colors for copy_mode and quick_select
        -- available since: 20220807-113146-c2fee766
        -- In copy_mode, the color of the active text is:
        -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
        -- 2. selection_* otherwise
        copy_mode_active_highlight_bg = { Color = '#000000' },
        -- use `AnsiColor` to specify one of the ansi color palette values
        -- (index 0-15) using one of the names "Black", "Maroon", "Green",
        --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
        -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
        copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
        copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
        copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

        quick_select_label_bg = { Color = 'peru' },
        quick_select_label_fg = { Color = '#ffffff' },
        quick_select_match_bg = { AnsiColor = 'Navy' },
        quick_select_match_fg = { Color = '#ffffff' },
    }  
}
