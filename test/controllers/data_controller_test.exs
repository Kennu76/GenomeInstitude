defmodule Database.DataControllerTest do
  use Database.ConnCase

  alias Database.Data
  @valid_attrs %{code: "some code", email: "some email", first: "some first", idcode: "some idcode", inst: "some inst", last: "some last", time: "some time"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, data_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing datas"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, data_path(conn, :new)
    assert html_response(conn, 200) =~ "New data"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, data_path(conn, :create), data: @valid_attrs
    data = Repo.get_by!(Data, @valid_attrs)
    assert redirected_to(conn) == data_path(conn, :show, data.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, data_path(conn, :create), data: @invalid_attrs
    assert html_response(conn, 200) =~ "New data"
  end

  test "shows chosen resource", %{conn: conn} do
    data = Repo.insert! %Data{}
    conn = get conn, data_path(conn, :show, data)
    assert html_response(conn, 200) =~ "Show data"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, data_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    data = Repo.insert! %Data{}
    conn = get conn, data_path(conn, :edit, data)
    assert html_response(conn, 200) =~ "Edit data"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    data = Repo.insert! %Data{}
    conn = put conn, data_path(conn, :update, data), data: @valid_attrs
    assert redirected_to(conn) == data_path(conn, :show, data)
    assert Repo.get_by(Data, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    data = Repo.insert! %Data{}
    conn = put conn, data_path(conn, :update, data), data: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit data"
  end

  test "deletes chosen resource", %{conn: conn} do
    data = Repo.insert! %Data{}
    conn = delete conn, data_path(conn, :delete, data)
    assert redirected_to(conn) == data_path(conn, :index)
    refute Repo.get(Data, data.id)
  end
end
