function love.conf(c)
  c.identity = "Julia Set Maker"
  c.title = "Julia Set Maker"
  local window = c.screen or c.window -- love 0.9 renamed "screen" to "window"
  window.vsync = false
  window.fullscreen = true
  window.resizable = false      -- Let the window be user-resizable (boolean)(string)
  c.modules.video = false            
  c.modules.thread = true        
  c.modules.physics = false
  c.modules.touch = false
end