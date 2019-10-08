defmodule Cascade.ProducerConsumer do
  use GenStage

  def start_link(state \\ %{multiplier: 2.0}) do
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [Cascade.Producer]}
  end

  @spec handle_events(list(), any(), map()) :: {:noreply, [term()], map()}
  def handle_events(values, from, state) do
    results =
      Enum.map(values, fn {:event, value} ->
        IO.inspect(value, label: "[producer_consumer] from #{inspect(from)} got #{value}")
        {:intermediate, value * Map.get(state, :multiplier, 1)}
      end)

    {:noreply, results, state}
  end
end
