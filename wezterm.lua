local wezterm = require 'wezterm';
local vaporlush = require 'vaporlush';

-- Shade unicode character for tab separators (matching tmux style)
local SHADE = '▓'
local NVIM_LOGO = wezterm.nerdfonts.custom_neovim
local act = wezterm.action

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- application name of the active pane.
local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end

    -- Get the process name
    local process_name = tab_info.active_pane.foreground_process_name
    if process_name then
        -- Extract just the process name without path
        process_name = process_name:match("([^/\\]+)$") or process_name

        -- If it's WSL, parse the actual command from the title
        if process_name == "wsl.exe" or process_name == "wslhost.exe" then
            local pane_title = tab_info.active_pane.title
            -- Try to extract the command from common title patterns
            -- Pattern like "nvim file.lua" or "bash" or "user@host:~ command"
            local command = pane_title:match("^(%S+)") or pane_title
            command = command:match("([^:@]+)$") or command

            -- Check if it's nvim
            if command == "nvim" then
                return NVIM_LOGO
            end
            return command
        end

        -- Check if it's specifically nvim
        if process_name == "nvim" or process_name == "nvim.exe" then
            return NVIM_LOGO
        end
        return process_name
    end
    return tab_info.active_pane.title
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local edge_background = vaporlush.background
        local background      = vaporlush.background
        local foreground      = vaporlush.foreground

        if tab.is_active then
            background = '#352ff5'  -- primary2
            foreground = '#ffb68c'  -- quartary3
        elseif hover then
            background = '#0b03fc'  -- primary1
            foreground = '#fa34a1'  -- secondary2
        end

        local edge_foreground = background
        local title = tab_title(tab)
        title = wezterm.truncate_right(title, max_width - 2)

        return {
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SHADE },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = title },
            { Background = { Color = edge_background } },
            { Foreground = { Color = edge_foreground } },
            { Text = SHADE },
        }
    end
)

return {
    --default_prog = { 'powershell.exe', '-NoLogo' },
    default_prog = { 'wsl.exe', '-d', 'Ubuntu-22.04' },
    --default_cwd = "~",
    font = wezterm.font_with_fallback {
        { family = "MartianMono Nerd Font Propo", weight = "Regular" },
		{ family = "Noto Color Emoji", weight = "Regular" },
    },
    window_background_opacity = 1,
    text_background_opacity = 1,
    win32_system_backdrop = "Acrylic",
    hide_tab_bar_if_only_one_tab = false,
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
    tab_max_width = 18,
    window_frame = {
        active_titlebar_bg = vaporlush.background,
        font_size = 14.5,
    },
    tab_bar_at_bottom = false,
    use_fancy_tab_bar = false,
    tab_bar_style = {
        window_hide = '',
        window_hide_hover = '',
        window_maximize = '',
        window_maximize_hover = '',
        window_close = '',
        window_close_hover = '',
    },
	-- this is not needed anymore.
	-- i use fts switcher written by my self now lol
	--
    -- ssh_domains = {
    --     {
    --         -- This name identifies the domain
    --         name = 'snickers2',
    --         -- The hostname or address to connect to. Will be used to match settings
    --         -- from your ssh config file
    --         remote_address = 'kalilarosa.xyz',
    --         -- The username to use on the remote host
    --         username = 'kalilarosa',
    --     },
    -- },
    font_size = 13.5,
    keys = {
        { key = 'q', mods = 'CTRL|ALT|SHIFT', action = act.CloseCurrentPane { confirm = true }, },
        { key = 'c', mods = 'CTRL|ALT|SHIFT', action = act.SpawnTab 'CurrentPaneDomain', },
        { key = '\\', mods = 'CTRL|ALT|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
        { key = '-', mods = 'CTRL|ALT|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' }, },
        { key = 'h', mods = 'CTRL|ALT|SHIFT', action = act.ActivatePaneDirection 'Left', },
        { key = 's', mods = 'CTRL|ALT|SHIFT', action = act.ActivatePaneDirection 'Right', },
        { key = 'n', mods = 'CTRL|ALT|SHIFT', action = act.ActivatePaneDirection 'Up', },
        { key = 't', mods = 'CTRL|ALT|SHIFT', action = act.ActivatePaneDirection 'Down', }
    },
    colors = vaporlush
}
