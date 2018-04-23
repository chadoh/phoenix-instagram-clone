defmodule InstagramClone.UserView do
  use InstagramClone.Web, :view
  alias InstagramClone.User

  def first_name(%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
