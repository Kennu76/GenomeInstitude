defmodule Database.Router do
  use Database.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Database do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # This implements the data as a resource
    resources "/datas", DataController
    # These implement the uploading
    get "/upload", UploadController, :upload_form
    post "/upload", UploadController, :upload
  end

  # Other scopes may use custom stacks.
  # scope "/api", Database do
  #   pipe_through :api
  # end
end
