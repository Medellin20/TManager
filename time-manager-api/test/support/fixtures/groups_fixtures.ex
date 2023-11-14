defmodule TimeManagerApi.GroupsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerApi.Groups` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TimeManagerApi.Groups.create_team()

    team
  end
end
