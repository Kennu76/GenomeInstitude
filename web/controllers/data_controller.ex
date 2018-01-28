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

  
end
