local wezterm = require("wezterm")

local act = wezterm.action

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    return "Wezterm"
end)

return {
    --exit_behavior='Hold',
    window_close_confirmation = "AlwaysPrompt", --不用确认关闭
    enable_tab_bar = false, --不显示bar
    enable_scroll_bar = false, --不显示滚动条
    adjust_window_size_when_changing_font_size = false,
    --window_decorations = "INTEGRATED_BUTTONS|RESIZE",--去掉标题栏
    --use_fancy_tab_bar = true,

    colors = {
        cursor_bg = "#c0caf5",
        cursor_fg = "#ffffff",
        cursor_border = "#c0caf5",
    },

    integrated_title_button_alignment ="Right",
    integrated_title_button_color = "Auto",
    integrated_title_button_style = "Windows",
    integrated_title_buttons = { 'Hide', 'Maximize', 'Close' },


    color_scheme = "tokyonight_storm",
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 }, --窗口边距

    window_background_opacity = 1, --背景不透明度

    freetype_load_target = "Light", --抗锯齿
    freetype_render_target = "HorizontalLcd",

    font = wezterm.font("SauceCodePro Nerd Font Mono", { weight = "Regular", stretch = "Normal", style = "Normal" }),
    font_rules = {
        {
            italic = true,
            font = wezterm.font(
            "SauceCodePro Nerd Font Mono",
            { weight = "Regular", stretch = "Normal", style = "Italic" }
            ),
        },
        {
            intensity = "Bold",
            font = wezterm.font(
            "SauceCodePro Nerd Font Mono",
            { weight = "Bold", stretch = "Normal", style = "Normal" }
            ),
        },
        {
            intensity = "Bold",
            italic = true,
            font = wezterm.font(
            "SauceCodePro Nerd Font Mono",
            { weight = "Bold", stretch = "Normal", style = "Italic" }
            ),
        },
    },
    font_size = 17,
    keys = {
        { key = 'v', mods = 'ALT', action = wezterm.action.PasteFrom 'Clipboard'},
        { key = 'c', mods = 'ALT', action =  wezterm.action.CopyTo 'Clipboard'},
        { key = 'v', mods = 'SHIFT|CTRL', action = wezterm.action.PasteFrom 'Clipboard'},
        { key = 'c', mods = 'SHIFT|CTRL', action =  wezterm.action.CopyTo 'Clipboard'},


        { key = 'z', mods = 'SHIFT|ALT', action = wezterm.action.DecreaseFontSize },
        { key = 'a', mods = 'SHIFT|ALT', action = wezterm.action.IncreaseFontSize },
        { key = 'r', mods = 'SHIFT|ALT', action = wezterm.action.ResetFontSize },

        { key = 'u', mods = 'SHIFT|ALT', action = wezterm.action.ScrollByLine(-1) },
        { key = 'd', mods = 'SHIFT|ALT', action = wezterm.action.ScrollByLine(1) },
        { key = 'u', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(-0.5) },
        { key = 'd', mods = 'SHIFT|CTRL', action =wezterm.action.ScrollByPage(0.5) },

        --{ key = 'f', mods = 'ALT',action = act.Search {Regex = '[a-f0-9]{6,}',},},
        --{ key = 'f', mods = 'ALT',action = act.Search { CaseSensitiveString = 'hash' },},
        { key = 'f', mods = 'SHIFT|ALT',action = act.Search { CaseInSensitiveString = '' },},
        { key = 'g', mods = 'SHIFT|ALT', action = wezterm.action.ActivateCopyMode },

        { key = 'x', mods = 'SHIFT|ALT', action = wezterm.action.CloseCurrentTab { confirm = true }, },
        { key = 'c', mods = 'SHIFT|ALT', action = wezterm.action.CloseCurrentPane { confirm = true },},

        { key = 'v', mods = 'SHIFT|ALT',action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },},
        { key = 's', mods = 'SHIFT|ALT',action = wezterm.action.SplitVertical},
        { key = 'm', mods = 'SHIFT|ALT',action = wezterm.action.TogglePaneZoomState,},

        { key = 'o', mods = 'SHIFT|ALT', action = act.SpawnTab 'CurrentPaneDomain',},
        { key = 'p', mods = 'SHIFT|ALT', action = act.ActivateTabRelative(-1) },
        { key = 'n', mods = 'SHIFT|ALT', action = act.ActivateTabRelative(1) },

        { key = 'h', mods = 'SHIFT|ALT',action = act.ActivatePaneDirection 'Left',},
        { key = 'l', mods = 'SHIFT|ALT',action = act.ActivatePaneDirection 'Right',},
        { key = 'k', mods = 'SHIFT|ALT',action = act.ActivatePaneDirection 'Up',},
        { key = 'j', mods = 'SHIFT|ALT',action = act.ActivatePaneDirection 'Down',},

        { key = 'h', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Left', 5 },},
        { key = 'j', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Down', 5 },},
        { key = 'k', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Up', 5 } },
        { key = 'l', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Right', 5 },},
    },
    --    default_prog = { 'C:/Program Files/nu/bin/nu.exe' },
    --    default_cwd = "D:/"
}

