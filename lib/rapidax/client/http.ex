defmodule Rapidax.Client.Http do
  defmacro __using__(params) do
    quote do
      import Rapidax.Base
      import Rapidax.Client

      use Rapidax.Client, [:username, :password] ++ unquote(params)

      def query(client, resource) do
        build_url(client, resource)
        |> get([], hackney_options(client) ++ get_options(resource))
        |> parse_response()
      end

      def create(client, resource) do
        build_url(client, resource)
        |> post(post_options(resource), %{}, hackney_options(client))
        |> parse_response
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
  end
end
