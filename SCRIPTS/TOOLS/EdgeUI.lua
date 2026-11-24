-- EdgeUI alpha. A read-only interface study for 128x64 EdgeTX radios.
local screens = { "HOME", "MODEL", "TELEMETRY", "RADIO" }
local selected = 1

local function drawHeader(title)
  lcd.drawFilledRectangle(0, 0, 128, 11)
  lcd.drawText(3, 1, title, INVERS)
  lcd.drawText(122, 1, "A", INVERS + RIGHT)
end

local function drawHome()
  lcd.drawText(4, 14, "EDGE UI", DBLSIZE)
  lcd.drawText(4, 34, "A clearer radio workspace")
  lcd.drawText(4, 47, "Press ENT to explore")
end

local function drawModel()
  local info = model and model.getInfo and model.getInfo()
  local name = info and info.name or "No model"
  lcd.drawText(4, 16, "ACTIVE MODEL", SMLSIZE)
  lcd.drawText(4, 27, name)
  lcd.drawText(4, 43, "Read-only preview", SMLSIZE)
end

local function drawList()
  for index, title in ipairs(screens) do
    local y = 13 + (index - 1) * 11
    lcd.drawText(4, y, title, index == selected and INVERS or 0)
  end
end

local page = 0

local function init()
  selected = 1
  page = 0
end

local function run(event)
  if event == EVT_VIRTUAL_EXIT or event == EVT_EXIT_BREAK then
    if page == 0 then return 1 end
    page = 0
  elseif page == 0 then
    if event == EVT_VIRTUAL_NEXT or event == EVT_ROT_RIGHT then
      selected = selected % #screens + 1
    elseif event == EVT_VIRTUAL_PREV or event == EVT_ROT_LEFT then
      selected = (selected - 2) % #screens + 1
    elseif event == EVT_VIRTUAL_ENTER or event == EVT_ENTER_BREAK or event == EVT_ROT_BREAK then
      page = selected
    end
  end

  lcd.clear()
  drawHeader(page == 0 and "EXPLORE" or screens[page])
  if page == 1 then
    drawHome()
  elseif page == 2 then
    drawModel()
  elseif page == 0 then
    drawList()
  else
    lcd.drawText(4, 21, "Layout preview")
  end
  lcd.drawText(4, 55, page == 0 and "ENT open" or "RTN back", SMLSIZE)
  return 0
end

return { init = init, run = run }
