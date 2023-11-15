local wezterm = require("wezterm")

local act = wezterm.action

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  return "Wezterm"
end)


return {
    colors = {
        cursor_bg = "364a82",
        cursor_fg = "black",
        cursor_border = "#52ad70",
    },
	--exit_behavior='Hold',
    window_close_confirmation = "AlwaysPrompt", --不用确认关闭
    enable_tab_bar = false, --不显示bar
    enable_scroll_bar = false, --不显示滚动条
    --window_decorations = "RESIZE",--去掉标题栏
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
        { key = 'v', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard'},
        { key = 'c',mods = 'CTRL', action =  wezterm.action.CopyTo 'Clipboard'},
		{ key = 'q', mods = 'ALT', action = wezterm.action.QuitApplication },
		{ key = 'm', mods = 'ALT', action = wezterm.action.Hide },
		{ key = 'c', mods = 'ALT', action = wezterm.action.CloseCurrentPane { confirm = true },},
		{ key = 'v', mods = 'ALT', action = wezterm.action.ActivateCopyMode },
		
		{ key = 'UpArrow', mods = 'ALT', action = wezterm.action.DecreaseFontSize },
		{ key = 'DownArrow', mods = 'ALT', action = wezterm.action.IncreaseFontSize },
		
		{ key = 'u', mods = 'ALT', action = wezterm.action.ScrollByLine(-1) },
		{ key = 'd', mods = 'ALT', action = wezterm.action.ScrollByLine(1) },
		{ key = 'u', mods = 'ALT|CTRL', action = wezterm.action.ScrollByPage(-0.5) },
		{ key = 'd', mods = 'ALT|CTRL', action =wezterm.action.ScrollByPage(0.5) },
		
		--{ key = 'f', mods = 'ALT',action = act.Search {Regex = '[a-f0-9]{6,}',},},
		--{ key = 'f', mods = 'ALT',action = act.Search { CaseSensitiveString = 'hash' },},
		{ key = 'f', mods = 'ALT',action = act.Search { CaseInSensitiveString = '' },},
		
		{key = 's',mods = 'CTRL|ALT',action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },},
		{key = 'v', mods = 'CTRL|ALT',action = wezterm.action.SplitVertical},
		


		{ key = 'l', mods = 'CTRL|ALT',action = act.ActivatePaneDirection 'Left',},
		{ key = 'h', mods = 'CTRL|ALT',action = act.ActivatePaneDirection 'Right',},
		{ key = 'k', mods = 'CTRL|ALT',action = act.ActivatePaneDirection 'Up',},
		{ key = 'j', mods = 'CTRL|ALT',action = act.ActivatePaneDirection 'Down',},
		
		{ key = 'h', mods = 'ALT', action = act.AdjustPaneSize { 'Left', 5 },},
		{ key = 'j', mods = 'ALT', action = act.AdjustPaneSize { 'Down', 5 },},
		{ key = 'k', mods = 'ALT', action = act.AdjustPaneSize { 'Up', 5 } },
		{ key = 'l', mods = 'ALT', action = act.AdjustPaneSize { 'Right', 5 },},
  
  
    },
    --default_prog = { 'powershell' },
}

