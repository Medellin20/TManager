defmodule TimeManagerApi.TimerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManagerApi.Timer` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        task_id: 42,
        time: ~N[2023-11-09 09:26:00]
      })
      |> TimeManagerApi.Timer.create_clock()

    clock
  end
end
