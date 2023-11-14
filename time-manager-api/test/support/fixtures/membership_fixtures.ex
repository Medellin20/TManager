defmodule TimeManagerApi.MembershipFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerApi.Membership` context.
  """

  @doc """
  Generate a team_member.
  """
  def team_member_fixture(attrs \\ %{}) do
    {:ok, team_member} =
      attrs
      |> Enum.into(%{

      })
      |> TimeManagerApi.Membership.create_team_member()

    team_member
  end
end
