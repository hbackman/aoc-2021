#  def parse (instruction) do
#    case instruction do
#      {"forward", v} -> [v, 0]
#      {"down",    v} -> [0, v]
#      {"up",      v} -> [0, -v]
#    end
#  end
#
#  def _solve_position (input) do
#    Enum.reduce(
#      Enum.map(input, fn ins ->
#            ins
#              |> split
#              |> parse
#          end),
#      [0, 0],
#      fn ([dx, dy], [x, y])
#        -> [x + dx, y + dy]
#      end
#    )
#  end