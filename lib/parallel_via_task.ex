defmodule Computation do
  def run(x) when x > 0 do
    s = 2_000
    s = x
    IO.puts("sleep=#{x} sleeping=#{s} molly")
    :timer.sleep(s)  # simulates a long-running operation
    x
  end
end

defmodule Aggregator do
  def new, do: 0
  def value(aggregator), do: aggregator

  def add_result(aggregator, result) do
    # :timer.sleep(50)
    aggregator + result
  end
end

defmodule AsyncAwait do
  def run do
    # :rand.seed(:os.timestamp)

    1..10
    |> Enum.map(fn(_) -> :rand.uniform(1000) end)
    |> Enum.map(&Task.async(fn -> Computation.run(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.reduce(Aggregator.new, &Aggregator.add_result(&2, &1))
    |> Aggregator.value
  end
end

defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
