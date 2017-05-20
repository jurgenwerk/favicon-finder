# FaviconFetcher

Get the favicon from any website that has one:

```
iex(2)> FaviconFetcher.favicon "github.com"
"https://assets-cdn.github.com/favicon.ico"
```

## Installation

The package can be installed
by adding `favicon_fetcher` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:favicon_fetcher, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/favicon_fetcher](https://hexdocs.pm/favicon_fetcher).

