defmodule Cascade.Consumer do
  use GenStage

  def start_link(state \\ nil) do
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [Cascade.ProducerConsumer]}
  end

  @spec handle_events([term()], term(), term()) :: {:noreply, [term()], term()}
  def handle_events(values, from, state) do
    Enum.each(values, fn {:intermediate, value} ->
      IO.puts("[consumer] from #{inspect(from)} #{value}")
    end)

    {:noreply, [], state}
  end
end
