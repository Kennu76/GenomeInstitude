defmodule Database.DataTest do
  use Database.ModelCase

  alias Database.Data

  @valid_attrs %{code: "some code", email: "some email", first: "some first", idcode: "some idcode", inst: "some inst", last: "some last", time: "some time"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Data.changeset(%Data{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Data.changeset(%Data{}, @invalid_attrs)
    refute changeset.valid?
  end
end
