local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local BAR_HEIGHT = 5
local BAR_WIDTH = 8
local brightnesswidget = {}

local brightmyarclabel = wibox.widget {
  id = 'arcbrightlabel',
  markup = '',
  align  = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
  font = 'Hack Nerd Font Bold 6'
}

local brightmyarc = wibox.widget {
  brightmyarclabel,
  id = 'arcbright',
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

local ICON_PATH = os.getenv("HOME") .. '/.config/awesome/icons/'

brightmyarc:connect_signal(
  'property::value',
  function()
    awful.spawn('xbacklight -set ' .. brightmyarc.value)
  end
)

local sunicon = {
  {
    resize = false,
    image = ICON_PATH .. 'brightness.svg',
    widget = wibox.widget.imagebox
  },
  valign = 'center',
  visible = with_icon,
  layout = wibox.container.place,
  forced_width = 28,
  forced_height = 30,
  fill_vertical = true,
  fill_horizontal = true
}

awful.widget.watch(
  [[bash -c "xbacklight -get"]],
  1,
  function(_, bright)
    -- local volume = string.match(stdout, '(%d?%d?%d)%%')
    brightmyarc:set_value(tonumber(bright))
    brightmyarclabel:set_markup_silently(math.modf(bright))
    collectgarbage('collect')
  end
)

brightnesswidget.brightup = function()
  local stdout = io.popen("xbacklight -get")
  local bright = stdout:read("*all")
  stdout:close()

  if tonumber(bright) < 100.0 then
    awful.spawn('xbacklight -set ' .. tonumber(bright) + 5)
  else
    awful.spawn('xbacklight -set ' .. 100)
  end
end

brightnesswidget.brightdown = function()
  local stdout = io.popen("xbacklight -get")
  local bright = stdout:read("*all")
  stdout:close()

  if tonumber(bright) > 5.0 then
    awful.spawn('xbacklight -set ' .. tonumber(bright) - 5)
  else
    awful.spawn('xbacklight -set ' .. 0)
  end
end

brightnesswidget.brightness_bar = wibox.widget {
  sunicon,
  brightmyarc,
  layout = wibox.layout.fixed.horizontal,
}

return brightnesswidget