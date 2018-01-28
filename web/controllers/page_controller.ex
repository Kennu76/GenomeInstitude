defmodule Database.PageController do
  use Database.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
