local wibox = require("wibox")
local awful = require("awful")
local naughty = require("naughty")

volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")
prev_id = 0
function update_volume(widget , command )
   awful.util.spawn_with_shell( command )
   os.execute("sleep 0.01")
   local status = awful.util.pread("eval ~/bin/vol-control.sh getVol")
   -- local volume = tonumber(string.match(status, "(%d?%d?%d)%%"))
   local volume = string.gsub(status, "%%" ,"♫")
   local volume = string.gsub(volume, "-" ,"♫")
   -- volume = string.format("%3d♫ ", volume)
   -- status = string.match(status, "%[(o[^%]]*)%]")
   -- if string.find(status, "on", 1, true) then
   -- end
   widget:set_markup("| "..volume)
   nev = naughty.notify({
          text     = ""
                .. string.format("Volume: %s" , awful.util.pread("eval ~/bin/vol-control.sh getVol | head -1 | tr '\n' ' '"))
        , timeout  = 1
        , position = "top_right"
        , font     = "Ubuntu Mono 28"
        , replaces_id = prev_id
    })
   prev_id = nev.id;
end
volume_widget:buttons(awful.util.table.join(
     awful.button({ }, 1, function() update_volume(volume_widget, "~/bin/vol-control.sh toggle" ) end),
     awful.button({ }, 4, function() update_volume(volume_widget, "~/bin/vol-control.sh louder" ) end),
     awful.button({ }, 5, function() update_volume(volume_widget, "~/bin/vol-control.sh softer" ) end)
            ))
update_volume(volume_widget)

-- mytimer = timer({ timeout = 1 })
-- mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
-- mytimer:start()
