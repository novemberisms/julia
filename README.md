# julia
Simple interactive Julia Set explorer made with LOVE2D

If you don't know how Julia sets work, you can [read about them online!](https://en.wikipedia.org/wiki/Julia_set)
# Instructions

* Make sure you have LOVE 0.10.2 installed.
* Double-click the `julia.love` file
* Use the mouse to control the real and imaginary parts of `z`
  * The y position of the mouse controls the imaginary part
  * The x position of the mouse controls the real part
  * The origin is located at the center

# What's the Mandelbrot set doing?
Julia sets are intimately connected to the Mandelbrot set in that if you mouse-over any point inside the Mandelbrot set, the corresponding Julia set for that point will be contiguous (locally connected).

All that is to say, if you mouse-over points within the Mandelbrot set, the corresponding Julia set will look nice and connected. If you bring your mouse outside, then it will look like a sparse set of little islands.

Just play around and explore. What happens when you mouse-over each of the bulbs of the Mandelbrot set? Is there a pattern? When you mouse-over each of the chasms? Math is beautiful.
