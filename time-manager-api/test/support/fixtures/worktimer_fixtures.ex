defmodule TimeManagerApi.WorktimerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerApi.Worktimer` context.
  """

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2023-11-09 08:43:00],
        start: ~N[2023-11-09 08:43:00],
        task_id: 42
      })
      |> TimeManagerApi.Worktimer.create_workingtime()

    workingtime
  end
end
