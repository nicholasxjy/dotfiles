local function yabai(commands)
  for _, cmd in ipairs(commands) do
    os.execute("/opt/homebrew/bin/yabai -m " .. cmd)
  end
end


local function alt(key, commands)
  hs.hotkey.bind(
    { "alt" },
    key,
    function ()
      yabai(commands)
    end
  )
end

local function altShift(key, commands)
  hs.hotkey.bind(
    { "alt", "shift" },
    key,
    function()
      yabai(commands)
    end
  )
end


local function altShiftNumber(number)
  altShift(number, { "window --space " .. number, "space --focus " .. number })
end


local homeRow = { h = "west", j = "south", k = "north", l = "east" }

for key, direction in pairs(homeRow) do
  alt(key, { "window --focus " .. direction })
  altShift(key, { "window --swap " .. direction })
end

alt("f", { "window --toggle zoom-fullscreen" })
alt("m", { "space --toggle mission-control" })
alt("r", { "space --rotate 90" })
alt("t", { "window --toggle float", "window --grid 4:4:1:1:2:2" })
alt("e", { "space --balance" })

alt("'", { "space --layout stack" })
alt(";", { "space --layout bsp" })
alt("tab", { "space --focus recent" })


for i = 1, 9 do
  local num = tostring(i)
  alt(num, { "space --focus " .. num })
  altShiftNumber(num)
end


altShift("a", { "window --resize left:-20:0" })
altShift("d", { "window --resize right:20:0" })
