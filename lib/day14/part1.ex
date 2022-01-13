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
    |> collect(1, @fuel, %{})
    |> IO.inspect
    |> elem(0)
  end

  def collect(_, amount, @ore, collected), do: {amount, put(collected, @ore, amount)}

  def collect(reactions, amount, chemical, collected) do
    {count, chemicals} = Map.get(reactions, chemical)
    present = Map.get(collected, chemical, 0)

    if present >= amount do
      {0, take(collected, chemical, amount)}
    else
      multiplier = ceil((amount - present) / count)

      {ore, latest} = Enum.reduce(chemicals, {0, collected}, &get_chemical(reactions, multiplier, &1, &2))
      {ore, put(latest, chemical, count * multiplier)}
    end
  end

  defp get_chemical(reactions, multiplier, {amount, chemical}, {ore, collected}) do
    {o, c} = collect(reactions, multiplier * amount, chemical, collected)
    {o + ore, take(c, chemical, multiplier * amount)}
  end

  def take(collected, chemical, amount), do: collected |> Map.update!(chemical, &(&1 - amount))

  def put(collected, chemical, amount), do: collected |> Map.update(chemical, amount, &(&1 + amount))

  defp to_map(reactions) do
    reactions
    |> Enum.map(fn {input, {amount, chemical}} -> {chemical, {amount, input}} end)
    |> Enum.into(%{})
  end
end
