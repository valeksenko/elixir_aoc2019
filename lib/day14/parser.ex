defmodule AoC2019.Day14.Parser do
  import NimbleParsec

  reaction =
    integer(min: 1)
    |> ignore(string(" "))
    |> ascii_string([?A..?Z], min: 1)
    |> reduce({List, :to_tuple, []})

  input =
    reaction
    |> repeat(
      ignore(string(", "))
      |> concat(reaction)
    )
    |> tag(:input)

  output =
    reaction
    |> unwrap_and_tag(:output)

  reactions =
    input
    |> ignore(string(" => "))
    |> concat(output)
    |> eos()

  defparsec(:parse, reactions)

  def parse_reactions(data) do
    data
    |> Enum.map(&parse/1)
    |> Enum.map(&to_reactions/1)
  end

  defp to_reactions({:ok, [input: input, output: output], "", _, _, _}) do
    {input, output}
  end
end
