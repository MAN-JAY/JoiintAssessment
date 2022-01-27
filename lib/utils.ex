defmodule Assessment.Utils do
  defmacro const(const_name, const_value) do
    quote do
      def unquote(const_name)(), do: unquote(const_value)
    end
  end

  def frame() do
    [
      IO.ANSI.clear(), 
      IO.ANSI.cursor(1, 1), 
      Assessment.Constants.joiint_banner,
      '\n',
      "Assessment | Joiint\n"
    ] |> Enum.join() |> IO.write
  end

end
