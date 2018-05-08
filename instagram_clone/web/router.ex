defmodule InstagramClone.Router do
  use InstagramClone.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug InstagramClone.Auth, repo: InstagramClone.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", InstagramClone do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/posts", PostController
    resources "/comments", CommentController
  end
end
