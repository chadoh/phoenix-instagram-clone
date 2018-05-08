defmodule InstagramClone.Post do
  use InstagramClone.Web, :model

  schema "posts" do
    field :title, :string
    field :content, :string
    belongs_to :user, InstagramClone.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :content])
    |> validate_required([:title, :content])
  end
end