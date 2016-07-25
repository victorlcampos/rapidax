defmodule Rapidax.Client do
  alias Rapidax.Resource

  defmacro __using__(params) do
    quote do
      defstruct [:site, :use_patch, :extension] ++ unquote(params)
    end
  end

  def parse_response({:ok   , %HTTPoison.Response{status_code: 200, body: body}})       , do: {:ok, body}
  def parse_response({:ok   , %HTTPoison.Response{status_code: 201, body: body}})       , do: {:ok, body}
  def parse_response({:ok   , %HTTPoison.Response{status_code: 404, body: body}})       , do: {:not_found, body }
  def parse_response({:ok   , %HTTPoison.Response{status_code: _status, body: body}})   , do: {:error, body}
  def parse_response({:error, %HTTPoison.Error{id: _id, reason: reason}})               , do: {:error, reason}

  def build_url(client, resource) do
    client.site <> Resource.url(resource, client.extension)
  end

  def get_options(resource) , do: [params: Resource.params(resource)]
  def post_options(resource), do: {:form, resource.params}
end
