defmodule Philosopher do
  @moduledoc """
  """
  def sleep(0) do :ok end
  def sleep(t) do :timer.sleep(:rand.uniform(t)) end

  def start(hunger, right, left, name, ctrl, seed) do
    spawn_link(fn -> dream(hunger, right, left, name, ctrl, seed) end)
  end

  def dream(0, _, _, name, ctrl, _) do
    IO.puts("#{name} is done eating")
    send(ctrl, :done)
  end
  def dream(hunger, right, left, name, ctrl, seed) do
    IO.puts("#{name} is hungry")
    sleep(seed)
    eat(hunger, right, left, name, ctrl, seed)
  end

  def eat(hunger, right, left, name, ctrl, seed) do
    IO.puts("#{name} is eating")

    case Chopstick.request(right, seed) do
      :ok ->
        IO.puts("#{name} right received a chopstick!")
        case Chopstick.request(left, seed) do
          :ok ->
            IO.puts("#{name} left received a chopstick!")
            done(hunger, right, left, name, ctrl, seed)
          :timeouted ->
            IO.puts("#{name} left chopstick timeouted!")
            Chopstick.release(right)
            sleep(seed)
            eat(hunger, right, left, name, ctrl, seed)
        end
      :timeouted ->
        IO.puts("#{name} right chopstick timeouted!")
        sleep(seed)
        eat(hunger, right, left, name, ctrl, seed)
    end
  end

  def done(hunger, right, left, name, ctrl, seed) do
    IO.puts("#{name} has finished eating")

    sleep(seed)
    Chopstick.release(right)
    Chopstick.release(left)

    dream(hunger - 1, right, left, name, ctrl, seed)
  end
end
