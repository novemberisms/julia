MOUSE_CONTROLLED = true
DRAW_MANDELBROT = true
DRAW_AXES = true

init_a, init_b = -0.74543,0.11301

shader_julia = love.graphics.newShader("shaders/julia.glsl")
shader_mandelbrot = love.graphics.newShader("shaders/mandelbrot.glsl")

active_palette = 1
palettes = {
  nil,  -- default. no palette
  love.graphics.newImage("shaders/pal0.png"),
  love.graphics.newImage("shaders/pal1.png"),
  love.graphics.newImage("shaders/pal2.png"),
}



function love.load()
  love.graphics.setBackgroundColor(255,255,255,255)
  
  screenwidth, screenheight = love.graphics.getDimensions()
  canvas_size = math.min(screenwidth, screenheight)
  
  canvas = love.graphics.newCanvas(canvas_size,canvas_size)
  
  shader_julia:send("max_iterations",1000)
  shader_julia:send("ca",init_a)
  shader_julia:send("cb",init_b)
  
end


function love.draw()
  local cx = init_a
  local cy = init_b
  
  local zero_line = canvas_size / 2
  local edge_line = canvas_size
  
  if MOUSE_CONTROLLED then
    local mousex,mousey = love.mouse.getPosition()
    cx = 4*(mousex-zero_line) / edge_line
    cy = 4*(mousey-zero_line) / edge_line
    shader_julia:send("ca",cx)
    shader_julia:send("cb",cy)
  end
  
  
  love.graphics.setColor(0,0,0,255)
  
  love.graphics.setShader(shader_julia)
  love.graphics.draw(canvas,0,0)
  love.graphics.setShader()
  
  
  if DRAW_MANDELBROT then
    love.graphics.setShader(shader_mandelbrot)
    love.graphics.draw(canvas,0,0)
    love.graphics.setShader()
  end
  love.graphics.setColor(get_opposite_of_background_color())
  if DRAW_AXES then
    love.graphics.line(zero_line,0,zero_line,edge_line)
    love.graphics.line(0,zero_line,edge_line,zero_line)
  end
  local coords = string.format([[
    
    z: %f + (%f)j
    press 'esc' to quit
    press 'm' to toggle mandelbrot on / off
    press 'x' to toggle axes on / off
    press 'space' to cycle through color palettes
  ]],cx,cy)
  love.graphics.print(coords,edge_line,10)
end

function get_opposite_of_background_color()
  local r,g,b,a = love.graphics.getBackgroundColor()
  return 255 - r, 255 - g, 255 - b, a
end

function love.keypressed(key)
  if key == "escape" then love.event.quit() end
  if key == "m" then DRAW_MANDELBROT = not DRAW_MANDELBROT end
  if key == "x" then DRAW_AXES = not DRAW_AXES end
  if key == "space" then
    active_palette = active_palette + 1
    if active_palette > #palettes then active_palette = 1 end
    local p_entry = palettes[active_palette]
    if p_entry then
      shader_julia:send("use_palette",true)
      shader_julia:send("palette",p_entry)
    else
      shader_julia:send("use_palette",false)
    end
  end
end