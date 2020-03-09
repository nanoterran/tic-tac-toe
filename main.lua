window_width = love.graphics.getWidth()
window_height = love.graphics.getHeight()
line_width = 10

function draw_background()
  love.graphics.setLineWidth(line_width)
  love.graphics.setLineStyle('smooth')
  love.graphics.line(0, (window_height / 3), window_width, (window_height / 3))
  love.graphics.line(0, 2 * (window_height / 3), window_width, 2* (window_height / 3))

  love.graphics.line((window_width / 3), 0, (window_width / 3), window_height)
  love.graphics.line(2 * (window_width / 3), 0, 2 * (window_width / 3), window_height)
end

function love.draw()
  draw_background()
end