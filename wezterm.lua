
local wezterm = require 'wezterm';

local function hsl(color, saturation, brightness)
    return string.format("hsl:%d %d %d", color, saturation, brightness) 
end

local colors = {
    Background = hsl(250,70,10),
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
    --default_prog = { 'wsl.exe', '-d', 'Ubuntu-22.04'},
    --default_cwd = "~",
    font = wezterm.font_with_fallback {
        "GeistMono Nerd Font",
        'Segoe UI Emoji'
    },
    window_background_opacity = 1,
    font_size = 16.0,
    keys = {
        {
            key = 't',
            mods = 'CTRL|ALT|SHIFT',
            action = wezterm.action.CloseCurrentPane { confirm = true },
        },
        {
            key = 'n',
            mods = 'CTRL|ALT|SHIFT',
            action = wezterm.action.SpawnTab 'DefaultDomain',
        },
    },
    ssh_domains = {
        {
            name = 'efme-linux',
            remote_address = '192.168.11.105',
            username = 'efme',
        },
        {
            name = 'efme-mac',
            remote_address = '192.168.11.130',
            username = 'eFileMadeEasy'
        }
    },
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
