defmodule Rapidax.Base do
  use HTTPoison.Base

  def process_url(url), do: url

  def process_response_body(body) do
    body
    |> Poison.decode!
  end
end
