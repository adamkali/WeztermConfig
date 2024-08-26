local wezterm = require 'wezterm';

local function hsl(color, saturation, brightness)
    return string.format("hsl:%d %d %d", color, saturation, brightness)
end

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick
local NVIM_LOGO = wezterm.nerdfonts.custom_neovim

local colors = {
    Background = '#2b2042',
    Primary    = { shade0 = hsl(250, 100, 25), shade1 = hsl(250, 100, 35), shade2 = hsl(250, 100, 55), shade3 = hsl(250, 100, 85), },
    Secondary  = { shade0 = hsl(300, 75, 20), shade1 = hsl(300, 75, 40), shade2 = hsl(300, 75, 60), shade3 = hsl(300, 75, 80), },
    Tertiary   = { shade0 = hsl(50, 75, 40), shade1 = hsl(50, 75, 50), shade2 = hsl(50, 75, 60), shade3 = hsl(50, 75, 70), },
    Quartenary = { shade0 = hsl(0, 100, 20), shade1 = hsl(0, 100, 40), shade2 = hsl(0, 100, 60), shade3 = hsl(0, 100, 80), },
    Quintary   = { shade0 = hsl(170, 100, 20), shade1 = hsl(170, 100, 40), shade2 = hsl(170, 100, 60), shade3 = hsl(170, 100, 80), }
}

local act = wezterm.action

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    title = tab_info.active_pane.title
    title = title:gsub('nvim', NVIM_LOGO .. '  ')
    return title
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local edge_background = '#241B2F'
        local background      = colors.Primary.shade0
        local foreground      = '#808080'

        if tab.is_active then
            background = colors.Primary.shade2
            foreground = colors.Quintary.shade3
        elseif hover then
            background = colors.Primary.shade1
            foreground = colors.Quintary.shade2
        end

        local edge_foreground = background
        local title = tab_title(tab)
        title = wezterm.truncate_right(title, max_width - 2)

        return {
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_LEFT_ARROW },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SOLID_RIGHT_ARROW },
        }
    end
)

return {
    --default_prog = { 'powershell.exe', '-NoLogo' },
    default_prog = { 'wsl.exe', '-d', 'Ubuntu-22.04' },
    --default_cwd = "~",
    font = wezterm.font_with_fallback {
        "Maple Mono NF",
        'Segoe UI Emoji'
    },
    window_background_opacity = 1,
    hide_tab_bar_if_only_one_tab = false,
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    tab_max_width = 16,
    window_frame = {
        inactive_titlebar_bg = '#353535',
        active_titlebar_bg = '#241B2F',
        button_fg = '#cccccc',
        button_bg = '#ffffff',
        button_hover_fg = '#ffffff',
        button_hover_bg = colors.Primary.shade0,
        font_size = 12.0,

    },
    font_size = 16,
    keys = {
        { key = 'q', mods = 'CTRL|ALT|SHIFT', action = act.CloseCurrentPane { confirm = true }, },
        { key = 'c', mods = 'CTRL|ALT|SHIFT', action = act.SpawnTab 'CurrentPaneDomain', },
        { key = 'v', mods = 'CTRL|ALT|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
        { key = 'z', mods = 'CTRL|ALT|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
        { key = 'h', mods = 'CTRL|ALT|SHIFT', action = act.ActivatePaneDirection 'Left', },
        { key = 's', mods = 'CTRL|ALT|SHIFT', action = act.ActivatePaneDirection 'Right', },
        { key = 'n', mods = 'CTRL|ALT|SHIFT', action = act.ActivatePaneDirection 'Up', },
        { key = 't', mods = 'CTRL|ALT|SHIFT', action = act.ActivatePaneDirection 'Down', },
    },
    colors = {
        foreground                      = colors.Secondary.shade3,
        background                      = colors.Background,
        cursor_bg                       = colors.Quintary.shade2,
        cursor_fg                       = colors.Quartenary.shade0,
        selection_fg                    = colors.Quintary.shade2,
        selection_bg                    = colors.Quartenary.shade0,
        scrollbar_thumb                 = colors.Tertiary.shade0,
        split                           = colors.Secondary.shade0,
        ansi                            = {
            colors.Primary.shade0,
            colors.Secondary.shade0,
            colors.Quintary.shade1,
            colors.Tertiary.shade1,
            colors.Primary.shade1,
            colors.Quartenary.shade1,
            colors.Secondary.shade1,
            hsl(250, 20, 40),
        },
        brights                         = {
            colors.Primary.shade2,
            colors.Secondary.shade2,
            colors.Quintary.shade3,
            colors.Tertiary.shade3,
            colors.Primary.shade3,
            colors.Quartenary.shade3,
            colors.Secondary.shade3,
            hsl(250, 20, 80),
        },
        compose_cursor                  = 'orange',
        copy_mode_active_highlight_bg   = { Color = '#000000' },
        copy_mode_active_highlight_fg   = { AnsiColor = 'Black' },
        copy_mode_inactive_highlight_bg = { Color = '#52ad70' },
        copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },
        quick_select_label_bg           = { Color = 'peru' },
        quick_select_label_fg           = { Color = '#ffffff' },
        quick_select_match_bg           = { AnsiColor = 'Navy' },
        quick_select_match_fg           = { Color = '#ffffff' },
    }
}
