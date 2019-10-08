defmodule Cascade.Consumer do
  use GenStage

  def start_link(state) do
    GenStage.start_link(__MODULE__, state)
  end

  def init(state) do
    {:consumer, state}
  end

  def handle_event(values, state) do
    Enum.each(values, fn {:intermediate, value} -> IO.puts("[consumer] #{value}") end)
    {:no_reply, state}
  end
end
