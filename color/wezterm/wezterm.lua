local wezterm = require("wezterm")
local act = wezterm.action
local action_callback = wezterm.action_callback

local fonts="SauceCodePro Nerd Font Mono"
local size=20

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    return "Wezterm"
end)

local nf = wezterm.nerdfonts
local GLYPH_SEMI_CIRCLE_LEFT = nf.ple_left_half_circle_thick
local GLYPH_SEMI_CIRCLE_RIGHT = nf.ple_right_half_circle_thick
--local GLYPH_SEMI_CIRCLE_LEFT = ""
--local GLYPH_SEMI_CIRCLE_RIGHT = ""

local M = {}
local __cells__ = {}

local colors = {
   default   = { bg = '#49556a', fg = '#1c1b19' },
   is_active = { bg = '#68a0e1', fg = '#11111b' },
   hover     = { bg = '#587d8c', fg = '#1c1b19' },
}

local _set_process_name = function(s)
   local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
   return a:gsub('%.exe$', '')
end

local _set_title = function(process_name, base_title, max_width, inset)
   local title
   inset = inset or 5

   if process_name:len() > 0 then
      title = process_name .. ' ~ ' .. base_title
   else
      title = base_title
   end
   if title:len() > max_width - inset then
      local diff = title:len() - max_width + inset
      title = wezterm.truncate_right(title, title:len() - diff)
   end
   return title
end

local _check_if_admin = function(p)
   if p:match('^Administrator: ') then
      return true
   end
   return false
end

local _push = function(bg, fg, attribute, text)
   table.insert(__cells__, { Background = { Color = bg } })
   table.insert(__cells__, { Foreground = { Color = fg } })
   table.insert(__cells__, { Attribute = attribute })
   table.insert(__cells__, { Text = text })
end

wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, hover, max_width)
    __cells__ = {}
    local bg
    local fg
    local process_name = _set_process_name(tab.active_pane.foreground_process_name)
    local is_admin = _check_if_admin(tab.active_pane.title)
    local title = _set_title(process_name, tab.active_pane.title, max_width, (is_admin and 8))

    if tab.is_active then
        bg = colors.is_active.bg
        fg = colors.is_active.fg
    elseif hover then
        bg = colors.hover.bg
        fg = colors.hover.fg
    else
        bg = colors.default.bg
        fg = colors.default.fg
    end
    local has_unseen_output = false
    for _, pane in ipairs(tab.panes) do
        if pane.has_unseen_output then
            has_unseen_output = true
            break
        end
    end
    _push('rgb(36, 40, 59)', bg, { Intensity = 'Bold' }, " " .. GLYPH_SEMI_CIRCLE_LEFT)
    _push(bg, fg, { Intensity = 'Bold' }, ' ' .. title)
    _push(bg, fg, { Intensity = 'Bold' }, ' ')
    _push('rgb(36, 40, 59)', bg, { Intensity = 'Bold' }, GLYPH_SEMI_CIRCLE_RIGHT)
    return __cells__
end)

return {
    --exit_behavior='Hold',
    audible_bell="Disabled",
    window_close_confirmation = "NeverPrompt", --不用确认关闭
    enable_tab_bar = true, --是否隐藏bar
    hide_tab_bar_if_only_one_tab = false,--只有一个tabs是否隐藏
    use_fancy_tab_bar = false,
    window_decorations = "INTEGRATED_BUTTONS|RESIZE",
    enable_scroll_bar = false, --不显示滚动条
    adjust_window_size_when_changing_font_size = false, --控制绘制边框粗细
    initial_rows = 24,
    initial_cols = 80,

    colors = {
        cursor_bg = "#c0caf5",
        cursor_fg = "#ffffff",
        cursor_border = "#c0caf5",
    },

    integrated_title_button_alignment ="Right",
    integrated_title_button_color = "Auto",
    --integrated_title_button_style = "Windows",
    integrated_title_buttons = { 'Hide', 'Maximize', 'Close' },


    color_scheme = "tokyonight_storm",
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 }, --窗口边距

    window_background_opacity = 1, --背景不透明度

    freetype_load_target = "HorizontalLcd", --抗锯齿
    freetype_render_target = "HorizontalLcd",
    front_end = "OpenGL",
    hide_mouse_cursor_when_typing=true,
    custom_block_glyphs = false,



    font = wezterm.font(fonts, { weight = "Regular", stretch = "Normal", style = "Normal" }),
    font_rules = {
        {
            italic = true,
            font = wezterm.font(
            fonts,
            { weight = "Regular", stretch = "Normal", style = "Italic" }
            ),
        },
        {
            intensity = "Bold",
            font = wezterm.font(
            fonts,
            { weight = "Bold", stretch = "Normal", style = "Normal" }
            ),
        },
        {
            intensity = "Bold",
            italic = true,
            font = wezterm.font(
            fonts,
            { weight = "Bold", stretch = "Normal", style = "Italic" }
            ),
        },
    },
    font_size = size,
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

        { key = 'c', mods = 'SHIFT|ALT', action = wezterm.action.CloseCurrentTab { confirm = false }, },
        { key = 'w', mods = 'SHIFT|ALT', action = wezterm.action.CloseCurrentPane { confirm = false },},

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
        { key = 'p', mods = 'SHIFT|CTRL', action = wezterm.action.ShowLauncherArgs{flags='LAUNCH_MENU_ITEMS'}},

        {
            key = 'q',
            mods = 'SHIFT|ALT',
            action = action_callback(function(win, pane)
                local tab = win:active_tab()
                for _, p in ipairs(tab:panes()) do
                    if p:pane_id() ~= pane:pane_id() then
                        p:activate()
                        win:perform_action(wezterm.action.CloseCurrentPane{confirm = false},p)
                    end
                end
            end),
        },

        {
            key = "x",
            mods = "SHIFT|ALT",
            action = wezterm.action_callback(function(win, _)
                local tab = win:active_tab()
                local activeTabId = tab:tab_id()
                local muxWin = win:mux_window()
                local tabs = muxWin:tabs()
                for _, t in ipairs(tabs) do
                    if t:tab_id() ~= activeTabId then
                        t:activate()
                        for _, p in ipairs(t:panes()) do
                            win:perform_action(wezterm.action.CloseCurrentPane({ confirm = false }), p)
                        end
                    end
                end
            end),
        },
    },

    --default_prog = { 'C:/Program Files/nu/bin/nu.exe' },
    --default_cwd = "D:/",
        --launch_menu = {
        --{ label = 'nushell', args = { 'C:/Program Files/nu/bin/nu.exe'  }, },
        --{ label = 'Powershell', args = { 'powershell.exe'  }, },
        --{ label='Mingw64',args={'C:/msys64/msys2_shell.cmd','-defterm','-here','-no-start','-mingw64'},},
        --{ label='ucrt64',args={'C:/msys64/msys2_shell.cmd','-defterm','-here','-no-start','-ucrt64'},},
        --{ label='Wsl',args={'wsl'},},
    --},

}
