# Assessment

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `assessment` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:assessment, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/assessment](https://hexdocs.pm/assessment).



Sample Input:
Spearmen#10; Militia#30; FootArcher#20; LightCavalry#1000; HeavyCavalry#120 
Militia#10; Spearmen#10; FootArcher#1000; LightCavalry#120; CavalryArcher#100

Sample Output:
Militia#30; FootArcher#20; Spearmen#10; LightCavalry#1000; HeavyCavalry#120


