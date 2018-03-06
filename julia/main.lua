MOUSE_CONTROLLED = true
DRAW_MANDELBROT = true
DRAW_AXES = false

init_a, init_b = -0.74543,0.11301

shader_julia = love.graphics.newShader("shaders/julia.glsl")

julia_palette = love.graphics.newImage("shaders/pal2.png")

shader_mandelbrot = love.graphics.newShader("shaders/mandelbrot.glsl")





function love.load()
  love.graphics.setBackgroundColor(255,255,255,255)
  
  screenwidth, screenheight = love.graphics.getDimensions()
  canvas_size = math.min(screenwidth, screenheight)
  
  canvas = love.graphics.newCanvas(canvas_size,canvas_size)
  control_canvas = love.graphics.newCanvas(1,1)
  
  
  
  --shader_julia:send("palette",julia_palette)
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
  
  if DRAW_MANDELBROT then
    love.graphics.setShader(shader_mandelbrot)
    love.graphics.draw(canvas,0,0)
    love.graphics.setShader()
  end
  
  love.graphics.setShader(shader_julia)
  love.graphics.draw(canvas,0,0)
  love.graphics.setShader()
  
  if DRAW_AXES then
    love.graphics.line(zero_line,0,zero_line,edge_line)
    love.graphics.line(0,zero_line,edge_line,zero_line)
  end
  local coords = string.format([[
    z: %f + (%f)j
    press 'esc' to quit
    press 'm' to toggle mandelbrot on / off
  ]],cx,cy)
  love.graphics.print(coords,edge_line,10)
end

function love.keypressed(key)
  if key == "escape" then love.event.quit() end
  if key == "m" then DRAW_MANDELBROT = not DRAW_MANDELBROT end
end