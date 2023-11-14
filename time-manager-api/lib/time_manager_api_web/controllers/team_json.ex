defmodule TimeManagerApiWeb.TeamJSON do
  alias TimeManagerApi.Groups.Team
  alias TimeManagerApi.Repo
  alias TimeManagerApi.Accounts.User
  @doc """
  Renders a list of teams.
  """
  def index(%{teams: teams}) do
    %{data: for(team <- teams, do: data(team))}
  end

  @doc """
  Renders a single team.
  """
  def show(%{team: team}) do
    %{data: data(team)}
  end

  defp data(%Team{} = team) do
      manager_info = case Repo.get(User, team.manager_id) do
        %User{} = user -> %{id: user.id, email: user.email, fullname: user.fullname, role: user.role}
        _ -> nil
      end
    %{
      id: team.id,
      name: team.name,
      manager_info: manager_info
    }
  end

  # defp data(%Team{} = team) do
  #   manager_info = case team.user do
  #     nil -> nil
  #     manager_id ->
  #       case Repo.get(User, manager_id) do
  #         %User{} = user -> %{id: user.id, email: user.email, fullname: user.fullname, role: user.role}
  #         _ -> nil
  #       end
  #   end
  #   %{
  #     id: team.id,
  #     name: team.name,
  #     manager: manager_info
  #   }
  # end

end
