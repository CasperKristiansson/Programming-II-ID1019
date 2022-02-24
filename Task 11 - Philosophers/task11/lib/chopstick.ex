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
      :relase ->
        available()
      :quit ->
        :ok
    end
  end

  def request({:id, stick}) do
    send(stick, {:request, self()})
    receive do
      :granted ->
        :ok
    end
  end

  def request({:id, stick}, timeout) do
    send(stick, {:request, self()})
    receive do
      :granted ->
        :ok
      after timeout ->
        :timeouted
    end
  end

  def quit({:id, stick}) do
    send(stick, :quit)
  end

  def release({:id, stick}) do
    send(stick, :relase)
  end
end
