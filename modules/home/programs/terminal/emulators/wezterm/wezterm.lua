-- local wezterm = require("wezterm")

local is_vim = function(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

local function color_scheme(appearance)
	return "Catppuccin Mocha"
	-- if appearance:find("Dark") then
	-- 	return "Catppuccin Mocha"
	-- else
	-- 	return "Catppuccin Latte"
	-- end
end

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = 14.0
config.color_scheme = color_scheme(wezterm.gui.get_appearance()) -- "Catppuccin Mocha (Gogh)",

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.macos_window_background_blur = 50
config.default_cursor_style = "BlinkingBar"

config.leader = { key = "a", mods = "CTRL" }
config.keys = {
	{ mods = "CMD|SHIFT", key = "a", action = wezterm.action.QuickSelect },
	{ mods = "LEADER", key = "-", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "|", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ mods = "LEADER", key = "f", action = wezterm.action.ToggleFullScreen },
	{ mods = "LEADER", key = "m", action = wezterm.action.TogglePaneZoomState },
	{ mods = "LEADER", key = "r", action = wezterm.action.ReloadConfiguration },
	{ mods = "LEADER", key = "Enter", action = wezterm.action.ActivateCopyMode },
	split_nav("move", "j"),
	split_nav("move", "h"),
	split_nav("move", "k"),
	split_nav("move", "l"),
}

return config
