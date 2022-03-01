defmodule Test do
  def demo() do
    small(-0.00001, 0.642, 0.008)
  end

  # -2.4, 1.3, 2.2
  # -0.001, 0.765, 0.013
  # -0.001, 0.663, 0.008
  # -0.00001, 0.642, 0.008
  def save() do
    big(-0.00001, 0.642, 0.008)
  end
  def small(x0, y0, xn) do
    width = 720
    height = 480
    depth = 256 * 3
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("running.ppm", image)
  end

  def big(x0, y0, xn) do
    width = 2560
    height = 1440
    depth = 256 * 3
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("Zoomed Spiral.ppm", image)
  end
end
