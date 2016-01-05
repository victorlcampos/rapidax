defmodule Rapidax.Resource do
  defmacro __using__(params) do
    quote do
      defstruct [:name, :belongs, :id, params: []] ++ unquote(params)
    end
  end

  def url(resource, extension \\ nil)
  def url(resource, nil), do: "/" <> do_url(resource.name, resource.id, resource.belongs, "")
  def url(resource, extension), do: url(resource, nil) <> "." <> extension

  defp do_url(name, nil, nil, next_resource_url), do: name <> next_resource_url
  defp do_url(name, id, nil, next_resource_url)  , do: name <> "/" <> id <> next_resource_url

  defp do_url(name, id, resource, next_resource_url) do
    do_url(resource.name, resource.id, resource.belongs, "/" <> do_url(name, id, nil, next_resource_url))
  end

  def params(resource), do: resource.params
end
