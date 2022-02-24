defmodule Chopstick do
  @moduledoc """
  """
  def start do
    stick = spawn_link(fn -> available() end)
    {:id, stick}
  end

  def available() do
    receive do
      {:request, from} ->
        send(from, :granted)
        gone()
      :quit ->
        :ok
    end
  end

  def gone() do
    receive do
      :return ->
        available()
      :quit ->
        :ok
    end
  end

  def request(stick) do
    send(stick, {:request, self()})
    receive do
      :granted ->
        :ok
    end
  end

  def quit({:id, stick}) do
    send(stick, :quit)
  end

  def return(stick) do
    send(stick, :return)
  end
end
