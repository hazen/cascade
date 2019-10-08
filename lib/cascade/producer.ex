defmodule Cascade.Producer do
  use GenStage

  def start_link(state \\ nil) do
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  @spec init(any) :: {:producer, any}
  def init(state) do
    {:producer, state}
  end

  @spec handle_demand(integer, any) :: {:noreply, list(), any}
  def handle_demand(demand, state) do
    events =
      1..demand
      |> Enum.map(fn _ -> {:event, Enum.random(-10_000..10_000)} end)
      |> IO.inspect(label: "[producer] Produced ")

    {:noreply, events, state}
  end
end
