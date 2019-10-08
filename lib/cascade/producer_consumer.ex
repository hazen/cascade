defmodule Cascade.ProducerConsumer do
  use GenStage

  def start_link(state) do
    GenStage.start_link(__MODULE__, state)
  end

  def init(state) do
    {:producer_consumer, state}
  end

  @spec handle_events(list(), any(), map()) :: {:no_reply, [term()], map()}
  def handle_events(values, from, state) do
    IO.inspect(values, label: "[producer_consumer] from #{inspect(from)} ")

    results =
      Enum.map(values, fn {:event, value} ->
        {:intermediate, value * Map.get(state, :multiplier, 1)}
      end)

    {:no_reply, results, state}
  end
end
