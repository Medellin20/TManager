defmodule TimeManagerApi.WorktimerTest do
  use TimeManagerApi.DataCase

  alias TimeManagerApi.Worktimer

  describe "workingtimes" do
    alias TimeManagerApi.Worktimer.Workingtime

    import TimeManagerApi.WorktimerFixtures

    @invalid_attrs %{start: nil, end: nil, task_id: nil}

    test "list_workingtimes/0 returns all workingtimes" do
      workingtime = workingtime_fixture()
      assert Worktimer.list_workingtimes() == [workingtime]
    end

    test "get_workingtime!/1 returns the workingtime with given id" do
      workingtime = workingtime_fixture()
      assert Worktimer.get_workingtime!(workingtime.id) == workingtime
    end

    test "create_workingtime/1 with valid data creates a workingtime" do
      valid_attrs = %{start: ~N[2023-11-09 08:43:00], end: ~N[2023-11-09 08:43:00], task_id: 42}

      assert {:ok, %Workingtime{} = workingtime} = Worktimer.create_workingtime(valid_attrs)
      assert workingtime.start == ~N[2023-11-09 08:43:00]
      assert workingtime.end == ~N[2023-11-09 08:43:00]
      assert workingtime.task_id == 42
    end

    test "create_workingtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Worktimer.create_workingtime(@invalid_attrs)
    end

    test "update_workingtime/2 with valid data updates the workingtime" do
      workingtime = workingtime_fixture()
      update_attrs = %{start: ~N[2023-11-10 08:43:00], end: ~N[2023-11-10 08:43:00], task_id: 43}

      assert {:ok, %Workingtime{} = workingtime} = Worktimer.update_workingtime(workingtime, update_attrs)
      assert workingtime.start == ~N[2023-11-10 08:43:00]
      assert workingtime.end == ~N[2023-11-10 08:43:00]
      assert workingtime.task_id == 43
    end

    test "update_workingtime/2 with invalid data returns error changeset" do
      workingtime = workingtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Worktimer.update_workingtime(workingtime, @invalid_attrs)
      assert workingtime == Worktimer.get_workingtime!(workingtime.id)
    end

    test "delete_workingtime/1 deletes the workingtime" do
      workingtime = workingtime_fixture()
      assert {:ok, %Workingtime{}} = Worktimer.delete_workingtime(workingtime)
      assert_raise Ecto.NoResultsError, fn -> Worktimer.get_workingtime!(workingtime.id) end
    end

    test "change_workingtime/1 returns a workingtime changeset" do
      workingtime = workingtime_fixture()
      assert %Ecto.Changeset{} = Worktimer.change_workingtime(workingtime)
    end
  end
end
