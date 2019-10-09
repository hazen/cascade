defmodule Cascade.Consumer do
  use GenStage

  def start_link(state \\ %{sleep: 1_000}) do
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:consumer, state, []}
  end

  @spec handle_events([term()], term(), term()) :: {:noreply, [term()], term()}
  def handle_events(values, from, state) do
    Enum.each(values, fn {:intermediate, value} ->
      IO.puts("[consumer] from #{inspect(from)} #{value}")
    end)

    # Buy some time to watch the output
    Process.sleep(state.sleep)

    {:noreply, [], state}
  end
end
