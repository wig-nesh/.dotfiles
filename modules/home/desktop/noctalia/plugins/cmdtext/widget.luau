local running = false

function update()
  noctalia.setUpdateInterval(noctalia.getConfig("interval_ms") or 60000)
  barWidget.setGlyph(noctalia.getConfig("glyph") or "terminal")
  barWidget.setGlyphColor(noctalia.getConfig("glyph_color") or "error")

  if running then
    return
  end
  running = true
  noctalia.runAsync(noctalia.getConfig("command") or "", function(result)
    running = false
    local text = (result.stdout or ""):gsub("%s+$", "")
    barWidget.setText(text)
    barWidget.setTooltip(text)
  end)
end
