-- Cheating
_ACTIVE_TAB = 0;

local wezterm = require 'wezterm'
local act = wezterm.action

local config = { }

-- Uncomment to debug key presses
-- config.debug_key_events = true

-- Dangerous. Assuming newer (nightly) wezterm version
--
config = wezterm.config_builder()

config.default_prog = { '/usr/bin/fish' }


wezterm.on(
	'update-right-status',
	function(window, _)
		local name = window:active_key_table()
		if name then
			name = 'TABLE: ' .. name
		end
		window:set_right_status(name or '')
	end
)
-- More like brokeland ammiright?? I am ashamed of myself
config.enable_wayland = false
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

config.key_tables = {

	-- Defines the keys that are active in our resize-pane mode.
	-- Since we're likely to want to make multiple adjustments,
	-- we made the activation one_shot=false. We therefore need
	-- to define a key assignment for getting out of this mode.
	-- 'resize_pane' here corresponds to the name="resize_pane" in
	-- the key assignments above.
	resize_pane = {
		{ key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },
		{ key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },
		{ key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },
		{ key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },
		-- Cancel the mode by pressing escape or q
		{ key = 'Escape', action = 'PopKeyTable' },
		{ key = 'q', action = 'PopKeyTable' },
	}
}

-- I Disagree With All The Defaults
config.disable_default_key_bindings = true

config.keys = {

	-- -------- --
	-- <Leader> --
	-- -------- --

	-- enter resize-pane mode
	{
		key = 'r',
		mods = 'LEADER',
		action = act.ActivateKeyTable {
			name = 'resize_pane',
			one_shot = false,
		},
	},
	{
		key ='v',
		mods = 'LEADER',
		action = act.SplitVertical {
			domain="CurrentPaneDomain"
		}
	},
	{
		key ='V',
		mods = 'LEADER',
		action = act.SplitHorizontal {
			domain="CurrentPaneDomain"
		}
	},
	{
		key = 'x',
		mods = 'LEADER',
		action = wezterm.action.CloseCurrentPane { confirm = true },
	},
	{
		key = 'X',
		mods = 'LEADER',
		action = wezterm.action.CloseCurrentTab { confirm = true },
	},
	{
		key = 'c',
		mods = 'LEADER',
		action = act.SpawnTab 'CurrentPaneDomain'
	},
	{
		key = 'N',
		mods = 'LEADER',
		action = act.ActivateTabRelative(-1)
	},
	{
		key = 'n',
		mods = 'LEADER',
		action = act.ActivateTabRelative(1)
	},
	{
		key = 't',
		mods = 'LEADER',
		action = act.ShowTabNavigator
	},
	{
		key = 'h',
		mods = 'LEADER',
		action = act.ActivatePaneDirection 'Left'
	},
	{
		key = 'j',
		mods = 'LEADER',
		action = act.ActivatePaneDirection 'Down'
	},
	{
		key = 'k',
		mods = 'LEADER',
		action = act.ActivatePaneDirection 'Up'
	},
	{
		key = 'l',
		mods = 'LEADER',
		action = act.ActivatePaneDirection 'Right'
	},
	{
		key = 'p',
		mods = 'LEADER',
		action = act.PasteFrom 'Clipboard'
	},
	{ -- TODO: bind copy mode keys
		key = 'Y',
		mods = "LEADER",
		action = act.ActivateCopyMode
	},
	{
		key = 'L',
		mods = 'LEADER',
		action = act.ShowDebugOverlay
	},
	{
		key = 'z',
		mods = 'LEADER',
		action = act.TogglePaneZoomState
	},
	{
		key = '.',
		mods ='LEADER',
		action = act.ActivateCommandPalette
	}
}

-- ---------- --
-- Aesthetics --
-- ---------- --

wezterm.on(
	'format-tab-title',
	function (tab, tabs, panes, config, hover, max_width)
		-- TODO: use [tabs] instead of a global variable
		-- Figure out how [tabs] works, fix documentation

		local indicatorLine = '▌';

		if tonumber(_ACTIVE_TAB) + 1 == tab.tab_index then
			indicatorLine = ''
		end

		-- default to gray
		local Background =  '#333333';

		if tab.is_active then
			_ACTIVE_TAB = tab.tab_index ;
			Background = '#A9B665';
		end
		return {
			{ Background = { Color = Background} },
			{ Foreground = { Color = '#636750' } },
			{ Text = indicatorLine},
			{ Background = { Color = Background} },
			{ Foreground = { Color = '#4C5039' } },
			{ Text = ' ' .. tab.active_pane.foreground_process_name:gsub('.*/', '') .. ' '},
			{ Background = { Color = '#333333' } },
			{ Foreground = { Color = Background } },
			{ Text = utf8.char(0xe0b0) },
		};

	end
)

config.color_scheme = 'GruvboxDark'


-- config.colors = {
	-- background = '#666667',
	-- foreground = '#666667'
-- }

-- config.window_background_opacity = 0.6

config.use_fancy_tab_bar = false;

-- I Hate You.
config.window_padding = {
	left = 0,
	right = 0,
}

config.font_size = 9;
return config;
