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
    |> collect(0, [{1, @fuel}], %{})
  end

  def collect(_, ore, [], _), do: ore

  def collect(reactions, ore, [{amount, @ore} | needed], leftovers),
    do: collect(reactions, ore + amount, needed, leftovers)

  def collect(reactions, ore, [{amount, chemical} | needed], leftovers) do
    {count, chemicals} = Map.get(reactions, chemical)
    present = Map.get(leftovers, chemical, 0)

    if present >= amount do
      collect(reactions, ore, needed, take(leftovers, chemical, amount))
    else
      required = amount - present
      batch = ceil(required / count)

      collect(
        reactions,
        ore,
        Enum.reduce(chemicals, needed, fn {a, c}, n -> [{a * batch, c} | n] end),
        Map.put(leftovers, chemical, count * batch - required)
      )
    end
  end

  def take(leftovers, chemical, amount), do: leftovers |> Map.update!(chemical, &(&1 - amount))

  defp to_map(reactions) do
    reactions
    |> Enum.map(fn {input, {amount, chemical}} -> {chemical, {amount, input}} end)
    |> Enum.into(%{})
  end
end
