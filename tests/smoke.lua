INVERS, RIGHT, DBLSIZE, SMLSIZE, SOLID = 1, 2, 4, 8, 0
EVT_VIRTUAL_NEXT, EVT_VIRTUAL_PREV = 10, 11
EVT_VIRTUAL_ENTER, EVT_VIRTUAL_EXIT = 12, 13
EVT_EXIT_BREAK, EVT_ROT_RIGHT, EVT_ROT_LEFT = 14, 15, 16
EVT_ENTER_BREAK, EVT_ROT_BREAK = 17, 18

local drawn = {}
lcd = {
  clear = function() drawn = {} end,
  drawText = function(_, _, value) drawn[#drawn + 1] = value end,
  drawFilledRectangle = function() end,
  drawLine = function() end,
}
model = { getInfo = function() return { name = "Pocket test model" } end }
getRSSI = function() return 0 end
getVersion = function() return "2.12", "pocket" end

local tool = dofile("SCRIPTS/TOOLS/EdgeUI.lua")
local function includes(value)
  for _, text in ipairs(drawn) do
    if text == value then return true end
  end
  return false
end

tool.init()
assert(tool.run(0) == 0 and includes("EXPLORE"))
assert(tool.run(EVT_VIRTUAL_ENTER) == 0 and includes("CURRENT MODEL"))
assert(tool.run(EVT_VIRTUAL_EXIT) == 0 and includes("EXPLORE"))
tool.run(EVT_VIRTUAL_NEXT)
assert(tool.run(EVT_VIRTUAL_ENTER) == 0 and includes("Pocket test model"))
tool.run(EVT_VIRTUAL_EXIT)
tool.run(EVT_VIRTUAL_NEXT)
assert(tool.run(EVT_VIRTUAL_ENTER) == 0 and includes("No signal"))
getRSSI = function() return nil end
assert(tool.run(0) == 0 and includes("No signal"))
tool.run(EVT_VIRTUAL_EXIT)
tool.run(EVT_VIRTUAL_NEXT)
assert(tool.run(EVT_VIRTUAL_ENTER) == 0 and includes("2.12"))
tool.run(EVT_VIRTUAL_EXIT)
assert(tool.run(EVT_VIRTUAL_EXIT) == 1)
print("EdgeUI smoke test passed")
