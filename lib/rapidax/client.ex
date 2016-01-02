defmodule Rapidax.Client do
  import Rapidax.Base
  alias Rapidax.Resource

  defstruct [:site, :method, :use_patch, :extension]

  def resources(client, resource) do
    case get(build_url(client, resource)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
        {:error, body}
      {:ok, %HTTPoison.Response{status_code: 404, body: body}} ->
        {:not_found, body }
    end
  end

  defp build_url(client, resource) do
    client.site <> Resource.url(resource, client.extension)
  end
end
