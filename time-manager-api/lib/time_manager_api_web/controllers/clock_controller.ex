defmodule TimeManagerApiWeb.ClockController do
  use TimeManagerApiWeb, :controller

  alias TimeManagerApi.Timer
  alias TimeManagerApi.Timer.Clock

  action_fallback TimeManagerApiWeb.FallbackController

  def index(conn, _params) do
    clocks = Timer.list_clocks()
    render(conn, :index, clocks: clocks)
  end

  def create(conn, %{"clock" => clock_params}) do
    with {:ok, %Clock{} = clock} <- Timer.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/clocks/#{clock}")
      |> render(:show, clock: clock)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Timer.get_clock!(id)
    render(conn, :show, clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Timer.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Timer.update_clock(clock, clock_params) do
      render(conn, :show, clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Timer.get_clock!(id)

    with {:ok, %Clock{}} <- Timer.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
