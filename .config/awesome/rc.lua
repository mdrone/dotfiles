-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
--local scratch = require("scratch")


-- Widget midget
vicious = require("vicious")
-- Widget midget
homedir = "/home/cl0wn"

-- Initialize widget
-- Register widget
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "| RAM $1% ($2MB/$3MB) | ", 13)

batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat, 
    function(batwidget, args)
        if args[1] == "-"  then
            return '| bat: ' .. args[1] ..  ' <span color="red">' .. args[2] .. "</span>% " .. args[3] .. ' hh:mm |'
        else
            return '| bat: ' .. args[1] .. " " .. args[2] .. "% " .. args[3] .. ' hh:mm |'
        end
    end, 61, "BAT0")
--vicious.register(batwidget, vicious.widgets.bat, "| bat: $1 $2% $3 hh:mm | ", 61, "BAT0")

cpuwidget = wibox.widget.textbox()
vicious.register(cpuwidget, vicious.widgets.cpu, "| CPU $1% |", 3)

netwidget = wibox.widget.textbox()
vicious.register(netwidget, vicious.widgets.net, "| eth0: rx ${eth0 rx_mb} mb tx ${eth0 tx_mb} mb |", 3)

--vpnwidget = wibox.widget.textbox()
--vicious.register(vpnwidget, vicious.widgets.net, " | tun0: rx ${tun0 rx_mb} mb tx ${tun0 tx_mb} mb |", 3)

netleftwidget = wibox.widget.textbox()
vicious.register(netleftwidget, vicious.widgets.net, "| wlan0: rx ${wlan0 rx_mb} mb tx ${wlan0 tx_mb} mb |", 3)

wifiwidget = wibox.widget.textbox()
vicious.register(wifiwidget, vicious.widgets.wifi, 
    function(wifiwidget, args)
        if args["{ssid}"] == "N/A" then
            return ' | ssid <span color="red">'.. args["{ssid}"] .. '</span> |'
        else
            return ' | ssid <span color="green">'.. args["{ssid}"] .. '</span> |'
        end
    end, 11, "wlan0")
--vicious.register(wifiwidget, vicious.widgets.wifi, ' | ssid ${ssid} |', 11, "wlan0")

volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume,
    function(volumewidget, args)
        return "| Volume: " .. args[1] .. "% " .. args[2] .. " |"
    end, 2, "Master")

mpdwidget = wibox.widget.textbox()
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (mpdwidget, args)
        if args["{state}"] == "Stop" then 
            return ""
        else 
            return '| '.. args["{Artist}"]..' - '.. args["{Title}"].. ' |'
        end
    end, 10)

            --return '| <span color="red">'.. args["{Artist}"]..'</span> - '.. args["{Title}"].. ' |'
            --return "| - |"
--mpdwidget = wibox.widget.textbox()
--vicious.register(mpdwidget, vicious.widgets.mpd,
--    function (mpdwidget, args)
--        if args["{state}"] == "Stop" then 
--            return " - "
--        else 
--            return args["{Artist}"]..' - '.. args["{Title}"]
--        end
--    end, 10)

--vicious.widgets.net
-- provides state and usage statistics of all network interfaces
-- returns a table with string keys, using net interfaces as a base:
-- {eth0 carrier}, {eth0 rx_b}, {eth0 tx_b}, {eth0 rx_kb}, {eth0 tx_kb},
-- {eth0 rx_mb}, {eth0 tx_mb}, {eth0 rx_gb}, {eth0 tx_gb}, {eth0 down_b},
-- {eth0 up_b}, {eth0 down_kb}, {eth0 up_kb}, {eth0 down_mb},
-- {eth0 up_mb}, {eth0 down_gb}, {eth0 up_gb}, {eth1 rx_b} etc.

-- vicious.widgets.wifi
-- provides wireless information for a requested interface
-- takes the network interface as an argument, i.e. "wlan0"
-- returns a table with string keys: {ssid}, {mode}, {chan}, {rate},
-- {link}, {linp} and {sign}


--volumewidget = wibox.widget.textbox()
--vicious.register(volumewidget, vicious.widgets.volume,
--    function(volumewidget, args)
--        local label = { ["♫"] = "O", ["♩"] = "M" }
--        return "Volume: " .. args[1] .. "% State: " .. label[args[2]]
--    end, 2, "Master")






-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(homedir .. "/.config/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
terminal = "termite"
myshell = "zsh"
executemultiplexer = "\"(tmux -q has-session && exec tmux attach-session -d -t$USER@$HOSTNAME) || exec tmux new-session -n$USER -s$USER@$HOSTNAME\""
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
-- }}}

-- {{{ Tags
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}
myawesomesysmenu = {
	{ "screensvr", terminal .. " -e 'cmatrix'" },
	{ "shutdown", "shutdown now" },
	{ "reboot", "reboot" },
	{ "lock", "i3lock -i " .. homedir .."/Pictures/lockscreen.png -n" } 
}
myawesomeremotemenu = {
	{ "VNC", "vncviewer" },
	{ "putty", "putty" }
}
myawesomemultimediamenu = {
	{ "DVB-TV", "vlc " .. homedir .. "/tv/dvb.xspf" },
	{ "Music", terminal .. " -e 'ncmpc'" },
	{ "Video", "gnome-mplayer" }
}
myawesomechatmenu = {
	{ "mumble", "mumble" },
	{ "VoIP", "jitsi" },
	{ "IM", "pidgin" },
	{ "IRC", "hexchat" }
}
myawesomenetmenu = {
	{ "uzbl-tabbed", "uzbl-tabbed" },
	{ "opera", "opera" },
	{ "firefox", "firefox" },
	{ "thunder", "thunderbird" }
}
myawesomeetcmenu = {
	{ "vBox", "virtualbox" },
	{ "file", "thunar" },
	{ "pdfviewer", "evince" },
	{ "restart tor", terminal .. " -e su -c 'systemctl restart tor'" }
}
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
									{ "etc", myawesomeetcmenu },
									{ "www mail", myawesomenetmenu },
									{ "chat", myawesomechatmenu },
									{ "multimedia", myawesomemultimediamenu },
									{ "remote", myawesomeremotemenu },
									{ "system", myawesomesysmenu }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox


-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
myawesomewibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                    )

mytasklist = {}
local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "www", "code" }, s, awful.layout.layouts[2])
    awful.tag.add("mume", {
        layout = awful.layout.suit.max,
        screen = s,
    })
    awful.tag.add("etc", {
        layout = awful.layout.suit.tile,
        screen = s,
    })

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }

    -- My own awesome wibox Bottom widgets
    s.myawesomewibox = awful.wibar({ position = "bottom", screen = s })

    local left_myawesomelayout = wibox.layout.fixed.horizontal()
    left_myawesomelayout:add(wifiwidget)
    left_myawesomelayout:add(netleftwidget)
    --left_myawesomelayout:add(vpnwidget)
    left_myawesomelayout:add(batwidget)

    local right_myawesomelayout = wibox.layout.fixed.horizontal()
    right_myawesomelayout:add(mpdwidget)
    right_myawesomelayout:add(volumewidget)
    right_myawesomelayout:add(netwidget)
    right_myawesomelayout:add(cpuwidget)
    right_myawesomelayout:add(memwidget)
    --right_myawesomelayout:add(batwidget)

    local myawesomelayout = wibox.layout.align.horizontal()
    myawesomelayout:set_left(left_myawesomelayout)
    myawesomelayout:set_right(right_myawesomelayout)
    
    s.myawesomewibox:set_widget(myawesomelayout)
    -- My own awesome wibox
end)
 -- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(terminal) end),
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal .. " -e " .. "'bash" .. " -c " .. executemultiplexer .. "'") end),
    awful.key({ modkey,           }, "s", function () awful.spawn("terminator -e screen") end),
    --awful.key({ modkey,           }, "s", function () awful.spawn(terminal .. " -e screen w3m") end),
    awful.key({ modkey,           }, "^",      function () scratch.drop(terminal .. " -e " .. myshell, "top", "center", 0.7, 0.25, "sticky") end),
    awful.key({ modkey, "Shift"   }, "o", 	  function () awful.spawn("opera") end),
    awful.key({ modkey, "Shift"   }, "w", 	  function () awful.spawn(terminal .. " -e " .. "'bash -c " .. "\"tmux new-session -n weechat -s weechat" .. " weechat-curses\"'") end),
    awful.key({ modkey,           }, "d", 	  function () awful.spawn(terminal .. " -e dvtm") end),
    awful.key({                   }, "Print", function () awful.spawn("scrot -e 'mv $f ~/screenshots/ 3>/dev/null'") end),
    --awful.key({ modkey, "Shift"   }, "p", 	  function () awful.spawn(homedir .. "/Downloads/tor-browser_en-US/Browser/start-tor-browser") end),
    awful.key({ modkey,           }, "v", 	  function () awful.spawn(terminal .. " -e ranger") end),
    awful.key({ modkey, "Shift"   }, "v", 	  function () awful.spawn(terminal .. " -e vifm") end),
    --awful.key({ modkey, "Shift"   }, "u", 	  function () awful.spawn("uzbl-tabbed") end),
    awful.key({ modkey, "Shift"   }, "u", 	  function () awful.spawn("luakit") end),
    awful.key({ modkey, "Shift"   }, "m", 	  function () awful.spawn(terminal .. " -e mutt") end),
    awful.key({ modkey, "Shift"   }, "f", 	  function () awful.spawn("firefox") end),
    awful.key({ modkey, "Control" }, "l", 	  function () awful.spawn("i3lock") end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
	awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
	awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
--keynumber = 0
--for s = 1, screen.count() do
--   keynumber = math.min(9, math.max(#tags[s], keynumber))
--end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     switchtotag = true } },
    { rule = { class = "XTerm" },
      callback = function(c)
        awful.client.toggletag(tags[1][3])
      end },
    --{ rule = { class = "URxvt" },
      --callback = function(c)
        --awful.client.toggletag(tags[1][4])
      --end },
    --{ rule = { class = "URxvt" },
    --properties = { tag = tags[1][2] } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Uzbl-tabbed" },
      properties = { screen = 1, tag = "www" } },
    { rule = { class = "Opera" },
      properties = { screen = 1, tag = "www" } },
    { rule = { class = "Firefox" },
      properties = { screen = 1, tag = "www" } },
    { rule = { class = "Thunderbird" },
      properties = { screen = 1, tag = "www" } },
    { rule = { class = "Hexchat" },
      properties = { screen = 1, tag = "www" } },
    { rule = { class = "Pidgin" },
      properties = { screen = 1, tag = "www" } },
    { rule = { class = "Skype" },
      properties = { maximized_vertical = true, maximized_horzontal = true } },
    { rule = { class = "Rhythmbox" },
      properties = { screen = 1, tag = "mume" } },
    { rule = { class = "Vlc" },
      properties = { screen = 1, tag = "mume" } },
    { rule = { class = "Eclipse" },
      properties = { screen = 1, tag = "code" } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { maximized_vertical = true, maximized_horzontal = true, tag = tags[1][2] } },
}
-- }}}



-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

--client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
--client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
