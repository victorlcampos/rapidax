defmodule Rapidax.Resource do
  @resource_struct [:name, :url, :belongs, :id, params: []]

  defstruct @resource_struct
  def resource_struct, do: @resource_struct

  def url(resource, extension \\ nil)
  def url(resource, nil), do: "/" <> do_url(resource.name, resource.url, resource.id, resource.belongs, "")
  def url(resource, extension), do: url(resource, nil) <> "." <> extension

  defp do_url(name, nil, nil, nil, next_resource_url), do: name <> next_resource_url
  defp do_url(name, nil, id , nil, next_resource_url), do: name <> "/" <> id <> next_resource_url

  defp do_url(_name, url, nil, nil, next_resource_url), do: url <> next_resource_url
  defp do_url(name, url, id, nil, next_resource_url)  , do: url <> "/" <> id <> next_resource_url

  defp do_url(name, url, id, resource, next_resource_url) do
    do_url(resource.name, resource.url, resource.id, resource.belongs, "/" <> do_url(name, url, id, nil, next_resource_url))
  end

  def params(resource), do: resource.params
end
