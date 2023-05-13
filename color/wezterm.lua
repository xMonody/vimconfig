local wezterm = require("wezterm")
return {
    colors = {
        cursor_bg = "#52ad70",
        cursor_fg = "black",
        cursor_border = "#52ad70",
    },

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
    },
    --default_prog = { 'powershell' },

}
