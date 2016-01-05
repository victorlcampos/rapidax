# Rapidax

Based on [Rapidash](https://github.com/Gazler/rapidash)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add rapidax to your list of dependencies in `mix.exs`:

        def deps do
          [{:rapidax, "~> 0.0.3"}]
        end

  2. Ensure rapidax is started before your application:

        def application do
          [applications: [:rapidax]]
        end

## Documentation

This example use https://github.com/typicode/jsonplaceholder#how-to

Full example source code: https://github.com/victorlcampos/rapidax-example

# Modules

```elixir
defmodule RapidaxExample.Client do
  use Rapidax.Client.Http, [site: "http://jsonplaceholder.typicode.com"]
end

defmodule RapidaxExample.Resource.Post do
  use Rapidax.Resource, [name: "posts"]
end

defmodule RapidaxExample.Resource.Comment do
  alias RapidaxExample.Resource.Post

  use Rapidax.Resource, [name: "comments", belongs: %Post{}]
end
```

# Showing a resource

```elixir
  alias RapidaxExample.Client
  alias RapidaxExample.Resource.Post

  {:ok, body} = Rapidax.Client.Http.query(%Client{}, %Post{id: "1"})
```

# Listing resources

```elixir
  alias RapidaxExample.Client
  alias RapidaxExample.Resource.Post

  {:ok, body} = Rapidax.Client.Http.query(%Client{}, %Post{})
```

# Creating a resource

```elixir
  alias RapidaxExample.Client
  alias RapidaxExample.Resource.Post

  {:ok, body} = Rapidax.Client.Http.create(%Client{}, %Post{params: [title: "foo", bar: "bar", userId: 1]})
```

# Updating a resource

```elixir
  alias RapidaxExample.Client
  alias RapidaxExample.Resource.Post

  {:ok, body} = Rapidax.Client.Http.update(%Client{use_patch: false}, %Post{id: "1", params: [id: 1, title: "foo", bar: "bar", userId: 1]})
```

# Updating a resource

```elixir
  alias RapidaxExample.Client
  alias RapidaxExample.Resource.Post

  {:ok, body} = Rapidax.Client.Http.update(%Client{use_patch: true}, %Post{id: "1", params: [title: "foo"]})
```

# Deleting a resource

```elixir
  alias RapidaxExample.Client
  alias RapidaxExample.Resource.Post

  {:ok, body} = Rapidax.Client.Http.destroy(%Client{}, %Post{id: "1"})
```

# Filtering resources

```elixir
  alias RapidaxExample.Client
  alias RapidaxExample.Resource.Post

  {:ok, body} = Rapidax.Client.Http.query(%Client{}, %Post{params: [userId: "1"]})
```

# Nested resources

```elixir
  alias RapidaxExample.Client
  alias RapidaxExample.Resource.Post
  alias RapidaxExample.Resource.Comment

  {:ok, body} = Rapidax.Client.Http.query(%Client{}, %Comment{belongs: %Post{id: "1"}})
```
