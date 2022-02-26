defmodule Test do
  def demo() do
    small(-2.4, 1.3, 2.2)
  end
  def small(x0, y0, xn) do
    width = 1920
    height = 1080
    depth = 256
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("running.ppm", image)
  end

  def big(x0, y0, xn) do
    width = 2560
    height = 1440
    depth = 256
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("Red & Yellow.ppm", image)
  end
end
