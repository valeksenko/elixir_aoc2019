defmodule Mix.Tasks.Day do
  use Mix.Task

  @notrim ~w[4 6]
  @nosplit ~w[16 19 20 22]

  @shortdoc "Run a spefic day with its input"

  def run([day, part]) do
    module =
      Module.safe_concat(~w[ Elixir AoC2020 Day#{String.pad_leading(day, 2, "0")} Part#{part} ])

    file =
      ["_#{part}", ""]
      |> Enum.map(&"data/day#{String.pad_leading(day, 2, "0")}#{&1}.txt")
      |> Enum.find(&File.exists?(&1))

    case File.read(file) do
      {:ok, content} ->
        apply(module, :run, [to_content(day, content)])
    end
    |> IO.puts()
  end

  defp to_content(day, content) do
    if Enum.member?(@nosplit, day) do
      content
    else
      content |> String.split("\n", trim: !Enum.member?(@notrim, day))
    end
  end
end
