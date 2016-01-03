defmodule Rapidax.ResourceTest do
  use ExUnit.Case
  doctest Rapidax.Resource

  test "resource with name" do
    resource = %Rapidax.Resource{name: "users"}
    assert Rapidax.Resource.url(resource) == "/users"
  end

  test "resource with url" do
    resource = %Rapidax.Resource{name: "users", url: "user"}
    assert Rapidax.Resource.url(resource) == "/user"
  end

  test "resource with id" do
    resource = %Rapidax.Resource{name: "users", id: "victorlcampos"}
    assert Rapidax.Resource.url(resource) == "/users/victorlcampos"
  end

  test "resource with extension" do
    resource = %Rapidax.Resource{name: "users", id: "victorlcampos"}
    assert Rapidax.Resource.url(resource, "xml") == "/users/victorlcampos.xml"
  end

  test "resource with resource" do
    resource = %Rapidax.Resource{name: "repos", belongs: %Rapidax.Resource { name: "users", id: "victorlcampos" }}
    assert Rapidax.Resource.url(resource) == "/users/victorlcampos/repos"
  end

  test "resource with resource with id" do
    resource = %Rapidax.Resource{name: "repos", id: "3", belongs: %Rapidax.Resource { name: "users", id: "victorlcampos" }}
    assert Rapidax.Resource.url(resource) == "/users/victorlcampos/repos/3"
  end

  test "resource with resource with resource" do
    resource = %Rapidax.Resource{name: "commits", belongs: %Rapidax.Resource { name: "repos", id: "3", belongs: %Rapidax.Resource { name: "users", id: "victorlcampos" } }}
    assert Rapidax.Resource.url(resource) == "/users/victorlcampos/repos/3/commits"
  end
end
