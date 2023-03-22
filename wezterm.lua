
local wezterm = require 'wezterm'

local config = { }

-- Uncomment to debug key presses
-- config.debug_key_events = true

-- Dangerous. Assuming newer (nightly) wezterm version.
config = wezterm.config_builder()

-- ------------------ --
--       Modules      --
-- ------------------ --

require'keybindings'.alter_config(config);

require'aesthetics'.alter_config(config);

-- ------------------ --
--   General Config   --
-- ------------------ --

config.default_prog = { '/usr/bin/fish' }

wezterm.on(
	'update-right-status',
	function(window, _)
		local name = window:active_key_table()
		if name then
			name = 'Key Table: ' .. name
		end
		window:set_right_status(name or '')
	end
)

-- More like brokeland amiright?? I am ashamed of myself
-- Only needed with Nvidia graphics cards
config.enable_wayland = false

-- causes some graphical glitching when under heavy load
-- config.front_end = "WebGpu";

return config;
