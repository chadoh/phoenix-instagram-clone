defmodule InstagramClone.Comment do
  use InstagramClone.Web, :model

  schema "comments" do
    field :content, :string
    belongs_to :user, InstagramClone.User
    belongs_to :post, InstagramClone.Post

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
