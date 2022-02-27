defmodule Dinner do
  def start(), do: spawn(fn -> init() end)

  def init() do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()

    seed = 500

    Philosopher.start(5, c1, c2, "Arendt", ctrl, seed)
    Philosopher.start(5, c2, c3, "Hypatia", ctrl, seed + 10)
    Philosopher.start(5, c3, c4, "Simone", ctrl, seed + 20)
    Philosopher.start(5, c4, c5, "Elisabeth", ctrl, seed + 30)
    Philosopher.start(5, c5, c1, "Ayn", ctrl, seed + 40)
    wait(5, [c1, c2, c3, c4, c5])
  end

  def wait(0, chopsticks) do
    Enum.each(chopsticks, fn(c) -> Chopstick.quit(c) end)
  end
  def wait(n, chopsticks) do
    receive do
      :done ->
        wait(n - 1, chopsticks)
      :abort ->
        Process.exit(self(), :kill)
    end
  end
end
