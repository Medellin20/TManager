defmodule TimeManagerApiWeb.WorkingtimeController do
  use TimeManagerApiWeb, :controller

  alias TimeManagerApi.Worktimer
  alias TimeManagerApi.Worktimer.Workingtime

  action_fallback TimeManagerApiWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Worktimer.list_workingtimes()
    render(conn, :index, workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- Worktimer.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/workingtimes/#{workingtime}")
      |> render(:show, workingtime: workingtime)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = Worktimer.get_workingtime!(id)
    render(conn, :show, workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Worktimer.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Worktimer.update_workingtime(workingtime, workingtime_params) do
      render(conn, :show, workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Worktimer.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Worktimer.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
