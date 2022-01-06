defmodule AoC2019.Day14.Part1 do
  import AoC2019.Day14.Parser

  @fuel "FUEL"
  @ore "ORE"

  @behaviour AoC2019.Day

  @impl AoC2019.Day
  def run(data) do
    data
    |> parse_reactions()
    |> to_map()
    |> ore(1, @fuel, %{})
  end

  def ore(_, amount, @ore, _), do: {@ore, amount}

  def ore(reactions, amount, chemical, collected) do
    {count, chemicals} = Map.get(reactions, chemical)

    total =
      chemicals
      |> Enum.map(fn {a, c} -> ore(reactions, a, c, collected) end)
      |> Enum.sum()

    IO.inspect({chemical, amount, count, total, total * ceil(amount / count)})
    total * ceil(amount / count)
  end

  defp to_map(reactions) do
    reactions
    |> Enum.map(fn {input, {amount, chemical}} -> {chemical, {amount, input}} end)
    |> Enum.into(%{})
  end
end
