-- Cheating
_ACTIVE_TAB = 0;

local wezterm = require'wezterm'

local module = {}

function module.alter_config(config)
	wezterm.on(
		'format-tab-title',
		function (tab, tabs, panes, config, hover, max_width)
			-- TODO: use [tabs] instead of a global variable
			-- Figure out how [tabs] works, fix documentation if needed
			--	-- Seemingly, not an array, but a table
			--	-- Cannot iterate with pairs()

			local indicatorLine = '▌';
			local indicatorColor = '#636750';




			if _ACTIVE_TAB + 1 == tab.tab_index then
				indicatorLine = ''
			end

			-- default to gray
			local Background =  '#333333';
			local Forground = '#4C5039';

			if hover then
				indicatorColor = '#a3a790';
				Forground = '#8C9089';
			end

			if tab.is_active then
				_ACTIVE_TAB = tonumber(tab.tab_index);
				Background = '#A9B665';
			end

			return {
				-- ::before
				{ Background = { Color = Background} },
				{ Foreground = { Color = indicatorColor } },
				{ Text = indicatorLine},
				-- content
				{ Background = { Color = Background} },
				{ Foreground = { Color = Forground} },
				{ Text = ' ' .. tab.active_pane.foreground_process_name:gsub('.*/', '') .. ' '},
				-- ::after
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

	config.window_background_opacity = 0.95

	config.use_fancy_tab_bar = false;


	-- I Hate You.
	config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}

	config.font_size = 9;
end

return module;
