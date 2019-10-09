defmodule Cascade do
  @moduledoc """
  Documentation for Cascade.
  """

  @doc """
  Run multiple producers
  """
  def run_multi() do
    {:ok, producer1} = GenStage.start_link(Cascade.Producer, [])
    {:ok, producer2} = GenStage.start_link(Cascade.Producer, [])
    {:ok, prodcom} = GenStage.start_link(Cascade.ProducerConsumer, %{multiplier: 2, sleep: 1_000})
    {:ok, consumer} = GenStage.start_link(Cascade.Consumer, %{sleep: 1_000})

    GenStage.sync_subscribe(consumer, to: prodcom, max_demand: 1)
    GenStage.sync_subscribe(prodcom, to: producer1)
    GenStage.sync_subscribe(prodcom, to: producer2)

    Process.sleep(20_000)
  end
end
