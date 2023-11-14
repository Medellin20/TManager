defmodule TimeManagerApiWeb.TeamMemberJSON do
  alias TimeManagerApi.Membership.TeamMember

  @doc """
  Renders a list of team_members.
  """
  def index(%{team_members: team_members}) do
    %{data: for(team_member <- team_members, do: data(team_member))}
  end

  @doc """
  Renders a single team_member.
  """
  def show(%{team_member: team_member}) do
    %{data: data(team_member)}
  end

  defp data(%TeamMember{} = team_member) do
    %{
      id: team_member.id
    }
  end
end
