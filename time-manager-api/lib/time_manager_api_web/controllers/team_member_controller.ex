defmodule TimeManagerApiWeb.TeamMemberController do
  use TimeManagerApiWeb, :controller

  alias TimeManagerApi.Membership
  alias TimeManagerApi.Membership.TeamMember

  action_fallback TimeManagerApiWeb.FallbackController

  def index(conn, _params) do
    team_members = Membership.list_team_members()
    render(conn, :index, team_members: team_members)
  end

  def create(conn, %{"team_member" => team_member_params}) do
    with {:ok, %TeamMember{} = team_member} <- Membership.create_team_member(team_member_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/team_members/#{team_member}")
      |> render(:show, team_member: team_member)
    end
  end

  def show(conn, %{"id" => id}) do
    team_member = Membership.get_team_member!(id)
    render(conn, :show, team_member: team_member)
  end

  def update(conn, %{"id" => id, "team_member" => team_member_params}) do
    team_member = Membership.get_team_member!(id)

    with {:ok, %TeamMember{} = team_member} <- Membership.update_team_member(team_member, team_member_params) do
      render(conn, :show, team_member: team_member)
    end
  end

  def delete(conn, %{"id" => id}) do
    team_member = Membership.get_team_member!(id)

    with {:ok, %TeamMember{}} <- Membership.delete_team_member(team_member) do
      send_resp(conn, :no_content, "")
    end
  end
end
