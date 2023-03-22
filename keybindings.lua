local wezterm = require'wezterm'
local action = wezterm.action

local module = {}

function module.alter_config(config)

	-- I Disagree With All The Defaults
	config.disable_default_key_bindings = true

	-- set Leader key to CTRL+a
	-- Use CTRL+a, let go of the keys, then press any specified key to call function
	config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

	config.key_tables = {

		-- Defines the keys that are active in our resize-pane mode.
		resize_pane = {
			{ key = 'h', action = action.AdjustPaneSize { 'Left', 1 } },
			{ key = 'l', action = action.AdjustPaneSize { 'Right', 1 } },
			{ key = 'k', action = action.AdjustPaneSize { 'Up', 1 } },
			{ key = 'j', action = action.AdjustPaneSize { 'Down', 1 } },
			-- Exit the mode by pressing escape or q
			{ key = 'Escape', action = 'PopKeyTable' },
			{ key = 'q', action = 'PopKeyTable' },
		}
	}

	config.keys = {

		-- -------- --
		-- <Leader> --
		-- -------- --

		-- enter resize-pane mode
		{
			key = 'r',
			mods = 'LEADER',
			action = action.ActivateKeyTable {
				name = 'resize_pane',
				one_shot = false,
			},
		},
		{
			key ='v',
			mods = 'LEADER',
			action = action.SplitVertical {
				domain="CurrentPaneDomain"
			}
		},
		{
			key ='V',
			mods = 'LEADER',
			action = action.SplitHorizontal {
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
			action = action.SpawnTab 'CurrentPaneDomain'
		},
		{
			key = 'N',
			mods = 'LEADER',
			action = action.ActivateTabRelative(-1)
		},
		{
			key = 'n',
			mods = 'LEADER',
			action = action.ActivateTabRelative(1)
		},
		{
			key = 't',
			mods = 'LEADER',
			action = action.ShowTabNavigator
		},
		{
			key = 'h',
			mods = 'LEADER',
			action = action.ActivatePaneDirection 'Left'
		},
		{
			key = 'j',
			mods = 'LEADER',
			action = action.ActivatePaneDirection 'Down'
		},
		{
			key = 'k',
			mods = 'LEADER',
			action = action.ActivatePaneDirection 'Up'
		},
		{
			key = 'l',
			mods = 'LEADER',
			action = action.ActivatePaneDirection 'Right'
		},
		{
			key = 'p',
			mods = 'LEADER',
			action = action.PasteFrom 'Clipboard'
		},
		{ -- TODO: bind copy mode keys
			key = 'Y',
			mods = "LEADER",
			action = action.ActivateCopyMode
		},
		{
			key = 'L',
			mods = 'LEADER',
			action = action.ShowDebugOverlay
		},
		{
			key = 'z',
			mods = 'LEADER',
			action = action.TogglePaneZoomState
		},
		{
			key = '.',
			mods ='LEADER',
			action = action.ActivateCommandPalette
		}
	}
end

return module;
