defmodule Rapidax.Resource do
  defstruct [:name, :url, :resource, :id]

  def url(resource, extension \\ nil)
  def url(resource, nil), do: do_url(resource.name, resource.url, resource.id, resource.resource, "")
  def url(resource, extension), do: url(resource, nil) <> "." <> extension

  defp do_url(name, nil, nil, nil, previous_url), do: previous_url <> "/" <> name
  defp do_url(name, nil, id , nil, previous_url), do: do_url(name, nil, nil, nil, previous_url) <> "/" <> id

  defp do_url(_name, url, nil, nil, previous_url), do: previous_url <> "/" <> url
  defp do_url(_name, url, id , nil, previous_url), do: do_url(_name, url, nil, nil, previous_url) <> "/" <> id

  defp do_url(name, url, id, resource, previous_url) do
    do_url(resource.name, resource.url, resource.id, resource.resource, do_url(name, url, id, nil, previous_url))
  end
end
