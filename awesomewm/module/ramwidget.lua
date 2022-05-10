local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

--free -wh --mega | tail -n +2 | head -1 | awk '{print $2}' total
--free -wh --mega | tail -n +2 | head -1 | awk '{print $3}' used

local memwidget = {}

local ICON_PATH = os.getenv("HOME") .. '/.config/awesome/icons/'

local ramicon = {
  {
    resize = false,
    image = ICON_PATH .. 'ram-color.png',
    widget = wibox.widget.imagebox
  },
  valign = 'center',
  visible = with_icon,
  layout = wibox.container.place,
  forced_width = 34,
  forced_height = 34,
  fill_vertical = true,
  fill_horizontal = true
}

local memtotal = wibox.widget {
  id = 'memtotal',
  markup = '',
  align  = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
  font = 'Hack Nerd Font Regular 9'
}

local memused = wibox.widget {
  id = 'memused',
  markup = '',
  align  = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
  font = 'Hack Nerd Font Regular 9'
}

local mymemarc = wibox.widget {
  id = 'memarc',
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

awful.widget.watch(
  [[bash -c "free -wh --mega | tail -n +2 | head -1 | awk '{print $3}'"]],
  1,
  function(_, bright)
    -- local volume = string.match(stdout, '(%d?%d?%d)%%')
    -- mymemarc:set_value(tonumber(bright))
    memused:set_markup_silently(bright)
    collectgarbage('collect')
  end
)

awful.widget.watch(
  [[bash -c "free -wh --mega | tail -n +2 | head -1 | awk '{print $2}'"]],
  1,
  function(_, bright)
    -- local volume = string.match(stdout, '(%d?%d?%d)%%')
    -- mymemarc:set_value(tonumber(bright))
    memtotal:set_markup_silently(bright)
    collectgarbage('collect')
  end
)

memwidget.memlabel = wibox.widget {
  widget = wibox.container.margin,
  top = 1,
  left = 1,
  {
    -- ramicon,
    -- mymemarc,
    {
      widget = wibox.widget.separator,
      forced_width = 4,
      opacity = 0
    },
    memused,
    {
      markup = ' / ',
      align  = 'center',
      valign = 'center',
      widget = wibox.widget.textbox,
      font = 'Hack Nerd Font Bold 9'
    },
    memtotal,
    layout = wibox.layout.fixed.horizontal,
  }
}


local container_bg = wibox.widget {
  memwidget.memarc,
  widget = wibox.container.background,
  shape =  gears.shape.rectangular_tag,
  forced_width = 120,
  opacity = 1,
  bg = "#555555"
}

memwidget.mem_contained = wibox.widget {
  container_mg,
  widget = wibox.container.margin,
  -- shape =  gears.shape.rectangular_tag,
  forced_width = 120,
  opacity = 0,
  visible = false,
  -- bg = "#555555",
  left = 10,
  top = 10
}

return memwidget
