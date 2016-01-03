defmodule Rapidax.Client.Http do
  import Rapidax.Base
  import Rapidax.Client

  @client_struct struct_fields ++ [:username, :password]

  defstruct @client_struct
  def client_struct, do: @client_struct

  def query(client, resource) do
    parse_response(get(build_url(client, resource), [], hackney_options(client) ++ get_options(resource)))
  end

  def create(client, resource) do
    parse_response(post(build_url(client, resource), post_options(resource), %{}, hackney_options(client)))
  end

  def update(client, resource) do
    do_update(client, resource, client.use_patch)
  end
  defp do_update(client, resource, false) do
    parse_response(put(build_url(client, resource), post_options(resource), %{}, hackney_options(client)))
  end
  defp do_update(client, resource, true) do
    parse_response(patch(build_url(client, resource), post_options(resource), %{}, hackney_options(client)))
  end

  def destroy(client, resource) do
    parse_response(delete(build_url(client, resource), [], hackney_options(client) ++ get_options(resource)))
  end

  defp hackney_options(client), do: [hackney: basic_auth(client.username, client.password)]

  defp basic_auth(nil, nil), do: []
  defp basic_auth(username, password), do: [basic_auth: {username, password}]
end
