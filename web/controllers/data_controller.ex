defmodule Database.DataController do
  use Database.Web, :controller
  # The Rummage dependency needs to be used here in this controller
  use Rummage.Phoenix.Controller
  alias Database.Data
  # This function eventually queries all the data with the rummage data and renders it in the index.html
  def index(conn, params) do
    datas = Repo.all(Data)
    {query, rummage} = Data
      |> Data.rummage(params["rummage"])
    
    datas = query
      |> Repo.all
    render(conn, "index.html", datas: datas, rummage: rummage)
  end

  
end
