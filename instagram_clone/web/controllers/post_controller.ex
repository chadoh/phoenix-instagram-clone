defmodule InstagramClone.PostController do
  use InstagramClone.Web, :controller

  alias InstagramClone.Repo
  alias InstagramClone.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    changeset =
      Repo.get(InstagramClone.User, InstagramClone.Auth.session(conn))
      |> build_assoc(:posts)
      |> Post.changeset(post_params)
    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    query = from c in InstagramClone.Comment, where: c.post_id == ^id
    post = Repo.get!(Post, id)
    comments = Repo.all(query)
    render(conn, "show.html", post: post, comments: comments)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    IO.inspect(post.user_id)
    if InstagramClone.Auth.session(conn) == post.user_id do

      # Here we use delete! (with a bang) because we expect
      # it to always work (and if it does not, it will raise).
      Repo.delete!(post)

      conn
      |> put_flash(:info, "Post deleted successfully.")
      |> redirect(to: post_path(conn, :index))
    else
      conn
      |> put_flash(:info, "nope.")
      |> redirect(to: page_path(conn, :index))
    end
  end
end
