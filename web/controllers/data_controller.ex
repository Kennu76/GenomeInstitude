defmodule Database.DataController do
  use Database.Web, :controller
  use Rummage.Phoenix.Controller
  alias Database.Data

  def index(conn, params) do
    datas = Repo.all(Data)
    {query, rummage} = Data
      |> Data.rummage(params["rummage"])
    
    datas = query
      |> Repo.all
    render(conn, "index.html", datas: datas, rummage: rummage)
  end

  def new(conn, _params) do
    changeset = Data.changeset(%Data{})
    render(conn, "form.html", changeset: changeset)
  end

  def create(conn, %{"data" => data_params}) do
    changeset = Data.changeset(%Data{}, data_params)

    case Repo.insert(changeset) do
      {:ok, data} ->
        conn
        |> put_flash(:info, "Data created successfully.")
        |> redirect(to: data_path(conn, :show, data))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    data = Repo.get!(Data, id)
    render(conn, "show.html", data: data)
  end

  def edit(conn, %{"id" => id}) do
    data = Repo.get!(Data, id)
    changeset = Data.changeset(data)
    render(conn, "edit.html", data: data, changeset: changeset)
  end

  def update(conn, %{"id" => id, "data" => data_params}) do
    data = Repo.get!(Data, id)
    changeset = Data.changeset(data, data_params)

    case Repo.update(changeset) do
      {:ok, data} ->
        conn
        |> put_flash(:info, "Data updated successfully.")
        |> redirect(to: data_path(conn, :show, data))
      {:error, changeset} ->
        render(conn, "edit.html", data: data, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    data = Repo.get!(Data, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(data)

    conn
    |> put_flash(:info, "Data deleted successfully.")
    |> redirect(to: data_path(conn, :index))
  end
end
