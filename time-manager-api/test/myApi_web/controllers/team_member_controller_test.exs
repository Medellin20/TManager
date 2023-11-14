defmodule TimeManagerApiWeb.TeamMemberControllerTest do
  use TimeManagerApiWeb.ConnCase

  import TimeManagerApi.MembershipFixtures

  alias TimeManagerApi.Membership.TeamMember

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all team_members", %{conn: conn} do
      conn = get(conn, ~p"/api/team_members")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create team_member" do
    test "renders team_member when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/team_members", team_member: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/team_members/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/team_members", team_member: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update team_member" do
    setup [:create_team_member]

    test "renders team_member when data is valid", %{conn: conn, team_member: %TeamMember{id: id} = team_member} do
      conn = put(conn, ~p"/api/team_members/#{team_member}", team_member: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/team_members/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, team_member: team_member} do
      conn = put(conn, ~p"/api/team_members/#{team_member}", team_member: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete team_member" do
    setup [:create_team_member]

    test "deletes chosen team_member", %{conn: conn, team_member: team_member} do
      conn = delete(conn, ~p"/api/team_members/#{team_member}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/team_members/#{team_member}")
      end
    end
  end

  defp create_team_member(_) do
    team_member = team_member_fixture()
    %{team_member: team_member}
  end
end
