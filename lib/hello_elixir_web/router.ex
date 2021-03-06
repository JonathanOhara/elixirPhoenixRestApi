defmodule HelloElixirWeb.Router do
  use HelloElixirWeb, :router

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

  scope "/api", HelloElixirWeb do
    pipe_through :api

    get "/persons", PersonController, :list
    get "/persons/:id", PersonController, :findOne

    post "/persons", PersonController, :insert

    put "/persons/:id", PersonController, :update

    delete "/persons/:id", PersonController, :delete
  end

end
