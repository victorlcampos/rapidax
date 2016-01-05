defmodule Rapidax.ResourceTest do
  use ExUnit.Case
  doctest Rapidax.Resource

  defmodule Resource do
    use Rapidax.Resource
  end

  test "resource with name" do
    resource = %Resource{name: "users"}
    assert Rapidax.Resource.url(resource) == "/users"
  end

  test "resource with id" do
    resource = %Resource{name: "users", id: "victorlcampos"}
    assert Rapidax.Resource.url(resource) == "/users/victorlcampos"
  end

  test "resource with extension" do
    resource = %Resource{name: "users", id: "victorlcampos"}
    assert Rapidax.Resource.url(resource, "xml") == "/users/victorlcampos.xml"
  end

  test "resource with resource" do
    resource = %Resource{name: "repos", belongs: %Resource{ name: "users", id: "victorlcampos" }}
    assert Rapidax.Resource.url(resource) == "/users/victorlcampos/repos"
  end

  test "resource with resource with id" do
    resource = %Resource{name: "repos", id: "3", belongs: %Resource{ name: "users", id: "victorlcampos" }}
    assert Rapidax.Resource.url(resource) == "/users/victorlcampos/repos/3"
  end

  test "resource with resource with resource" do
    resource = %Resource{name: "commits", belongs: %Resource{ name: "repos", id: "3", belongs: %Resource{ name: "users", id: "victorlcampos" } }}
    assert Rapidax.Resource.url(resource) == "/users/victorlcampos/repos/3/commits"
  end
end
