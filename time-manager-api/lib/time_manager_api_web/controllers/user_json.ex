defmodule TimeManagerApiWeb.UserJSON do
  alias TimeManagerApi.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      role: user.role,
      fullname: user.fullname,
      username: user.username,
      clock: user.clock
      #password_hash: user.password_hash
    }
  end
  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
