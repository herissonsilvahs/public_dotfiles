local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local BAR_HEIGHT = 5
local BAR_WIDTH = 8
local widget = {}

-- local myslider = wibox.widget {
--   id = 'slider',
--   max_value = 100,
--   bar_shape = gears.shape.rounded_rect,
--   bar_height = BAR_HEIGHT,
--   maximum = 100,
--   forced_width = BAR_WIDTH,
--   forced_height = 5,
--   color = '#e5e5e5',
--   background_color = '#ffffff11',
--   handle_color = beautiful.bg_normal,
--   handle_shape = gears.shape.circle,
--   handle_border_color = beautiful.border_color,
--   handle_border_width = 1,
--   value = 0,
--   widget = wibox.widget.progressbar,
-- }

local myarclabel = wibox.widget {
  id = 'arclabel',
  markup = '',
  align  = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
  font = 'Hack Nerd Font Bold 6'
}

local myarc = wibox.widget {
  myarclabel,
  id = 'arc',
  max_value = 100,
  min_value = 0,
  thickness = 3,
  bg = '#ffffff44',
  rounded_edge = true,
  start_angle = 1.57,
  forced_height = 24,
  border_color = '#dddddd',
  border_width = 1,
  forced_width = 24,
  widget = wibox.container.arcchart,
  paddings = 1
}

-- local slider_container = {
--   myslider,
--   forced_width = BAR_WIDTH,
--   layout = wibox.container.rotate,
--   direction = 'east',
-- }

local ICON_PATH = os.getenv("HOME") .. '/.config/awesome/icons/'

myarc:connect_signal(
  'property::value',
  function()
    awful.spawn('amixer -D pulse sset Master ' .. myarc.value .. '%')
  end
)

-- myslider:connect_signal(
--   'property::value',
--   function()
--     awful.spawn('amixer -D pulse sset Master ' .. myslider.value .. '%')
--   end
-- )

local volicon = {
  id = 'icon',
  resize = false,
  image = ICON_PATH .. 'audio-volume-high-symbolic.svg',
  widget = wibox.widget.imagebox
}

local volbutton = {
  volicon,
  valign = 'center',
  visible = with_icon,
  layout = wibox.container.place,
}

awful.widget.watch(
  [[bash -c "amixer -D pulse sget Master"]],
  1,
  function(_, stdout)
    -- local mute = string.match(stdout, '%[(o%D%D?)%]')
    local volume = string.match(stdout, '(%d?%d?%d)%%')
    -- myslider:set_value(tonumber(volume))
    myarc:set_value(tonumber(volume))
    myarclabel:set_markup_silently(volume)
    collectgarbage('collect')
  end
)

widget.volup = function()
  local stdout = io.popen("amixer -D pulse sget Master")
  local result = stdout:read("*all")
  stdout:close()
  local volume = string.match(result, '(%d?%d?%d)%%')

  if tonumber(volume) < 100 then
    awful.spawn('amixer -D pulse sset Master ' .. tonumber(volume) + 5 .. '%')
  else
    awful.spawn('amixer -D pulse sset Master ' .. 100 .. '%')
  end
end

widget.voldown = function()
  local stdout = io.popen("amixer -D pulse sget Master")
  local result = stdout:read("*all")
  stdout:close()
  local volume = string.match(result, '(%d?%d?%d)%%')

  if tonumber(volume) > 5 then
    awful.spawn('amixer -D pulse sset Master ' .. tonumber(volume) - 5 .. '%')
  else
    awful.spawn('amixer -D pulse sset Master ' .. 0 .. '%')
  end
end

widget.slider_bar = wibox.widget {
  volbutton,
  myarc,
  layout = wibox.layout.fixed.horizontal,
  spacing = 8
}

return widget