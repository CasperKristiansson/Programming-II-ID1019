defmodule Philosopher do
  @moduledoc """
  """
  def sleep(0) do :ok end
  def sleep(t) do :timer.sleep(:rand.uniform(t)) end

  def start(hunger, right, left, name, ctrl) do
    spawn_link(fn -> dream(hunger, right, left, name, ctrl) end)
  end

  def dream(0, _, _, name, ctrl) do
    IO.puts("#{name} is done eating")
    send(ctrl, :done)
  end

  def dream(hunger, right, left, name, ctrl) do
    IO.puts("#{name} is hungry")
    sleep(1000)
    eat(hunger, right, left, name, ctrl)
  end

  def eat(hunger, right, left, name, ctrl) do
    IO.puts("#{name} is eating")

    case Chopstick.request(right) do
      :ok ->
        IO.puts("#{name} right received a chopstick!")
        case Chopstick.request(left) do
          :ok ->
            IO.puts("#{name} left received a chopstick!")
            done(hunger, right, left, name, ctrl)
        end
    end
  end

  def done(hunger, right, left, name, ctrl) do
    IO.puts("#{name} has finished eating")

    sleep(1000)
    Chopstick.return(right)
    Chopstick.return(left)

    dream(hunger - 1, right, left, name, ctrl)
  end
end
