defmodule Philosopher do
  @moduledoc """
  """
  def sleep(0) do :ok end
  def sleep(t) do :timer.sleep(:rand.uniform(t)) end

  def start(hunger, right, left, name, ctrl, seed) do
    spawn_link(fn -> initialize(hunger, right, left, name, ctrl, seed) end)
  end

  @doc """
  https://elixirforum.com/t/is-it-necessary-or-useful-to-call-rand-seed-in-tests/42016
  """
  def initialize(hunger, right, left, name, ctrl, seed) do
    :rand.seed(:exsss, {seed, seed, seed})
    dream(hunger, right, left, name, ctrl)
  end

  def dream(0, _, _, name, ctrl) do
    IO.puts("#{name} is done eating")
    send(ctrl, :done)
  end
  def dream(hunger, right, left, name, ctrl) do
    IO.puts("#{name} is hungry")
    sleep(400)
    eat(hunger, right, left, name, ctrl)
  end

  def eat(hunger, right, left, name, ctrl) do
    IO.puts("#{name} is eating")

    case Chopstick.request(right, 200) do
      :ok ->
        IO.puts("#{name} right received a chopstick!")
        case Chopstick.request(left, 200) do
          :ok ->
            IO.puts("#{name} left received a chopstick!")
            done(hunger, right, left, name, ctrl)
          :timeouted ->
            IO.puts("#{name} left chopstick timeouted!")
            Chopstick.release(right)
            sleep(200)
            eat(hunger, right, left, name, ctrl)
        end
      :timeouted ->
        IO.puts("#{name} right chopstick timeouted!")
        sleep(200)
        eat(hunger, right, left, name, ctrl)
    end
  end

  def done(hunger, right, left, name, ctrl) do
    IO.puts("#{name} has finished eating")

    sleep(200)
    Chopstick.release(right)
    Chopstick.release(left)

    dream(hunger - 1, right, left, name, ctrl)
  end
end
