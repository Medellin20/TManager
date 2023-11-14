defmodule TimeManagerApi.MembershipTest do
  use TimeManagerApi.DataCase

  alias TimeManagerApi.Membership

  describe "team_members" do
    alias TimeManagerApi.Membership.TeamMember

    import TimeManagerApi.MembershipFixtures

    @invalid_attrs %{}

    test "list_team_members/0 returns all team_members" do
      team_member = team_member_fixture()
      assert Membership.list_team_members() == [team_member]
    end

    test "get_team_member!/1 returns the team_member with given id" do
      team_member = team_member_fixture()
      assert Membership.get_team_member!(team_member.id) == team_member
    end

    test "create_team_member/1 with valid data creates a team_member" do
      valid_attrs = %{}

      assert {:ok, %TeamMember{} = team_member} = Membership.create_team_member(valid_attrs)
    end

    test "create_team_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Membership.create_team_member(@invalid_attrs)
    end

    test "update_team_member/2 with valid data updates the team_member" do
      team_member = team_member_fixture()
      update_attrs = %{}

      assert {:ok, %TeamMember{} = team_member} = Membership.update_team_member(team_member, update_attrs)
    end

    test "update_team_member/2 with invalid data returns error changeset" do
      team_member = team_member_fixture()
      assert {:error, %Ecto.Changeset{}} = Membership.update_team_member(team_member, @invalid_attrs)
      assert team_member == Membership.get_team_member!(team_member.id)
    end

    test "delete_team_member/1 deletes the team_member" do
      team_member = team_member_fixture()
      assert {:ok, %TeamMember{}} = Membership.delete_team_member(team_member)
      assert_raise Ecto.NoResultsError, fn -> Membership.get_team_member!(team_member.id) end
    end

    test "change_team_member/1 returns a team_member changeset" do
      team_member = team_member_fixture()
      assert %Ecto.Changeset{} = Membership.change_team_member(team_member)
    end
  end
end
