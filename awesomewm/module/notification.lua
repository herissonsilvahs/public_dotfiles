local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = require('beautiful').xresources.apply_dpi

local notification_width = 400

-- Naughty presets

naughty.config.padding = 12
naughty.config.spacing = 12

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = 'top_right'
naughty.config.defaults.ontop = true
naughty.config.defaults.font = 'Hack Nerd Font Regular 10'
--naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.margin = dpi(14)
naughty.config.defaults.hover_timeout = 20
-- naughty.notification.max_width = 300
naughty.config.defaults['icon_size'] = 30
naughty.config.defaults.width = notification_width
-- naughty.config.defaults.opacity = 300

beautiful.notification_opacity = 0.8
beautiful.notification_max_width = notification_width
beautiful.notification_max_height = 600
beautiful.notification_border_width = 0
beautiful.notification_width = notification_widthR
beautiful.notification_icon_size = 20

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({ preset = naughty.config.presets.critical,
                    title = "Oops, an error happened!",
                    text = tostring(err) })
    in_error = false
  end)
end
-- }}}


function log_this(title, msg)
  naughty.notify(
    {
      title = 'LOG: ' .. title,
      text = msg
    }
  )
end

--log_this("Teste", "Só testando açsldddddddddddddddddddddddddddddddddddddddddskdkdslkdlaskdlkalçskdalksdlçklaçskdçlkask dkasdokasdokasçk kaskdçokçaoskd çoaksdçokas")
