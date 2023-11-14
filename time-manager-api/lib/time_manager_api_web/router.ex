defmodule TimeManagerApiWeb.Router do
  use TimeManagerApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/api", TimeManagerApiWeb do
    pipe_through :api

    #resources "/users", UserController, only: [:create, :show]
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    get "/account_details", UserController, :show_account
    post "/account_details", UserController, :show_account2
    post "/account_update", UserController, :update
    post "/pass_update", UserController, :update_pass
    post "/clock_in", UserController, :clock_in
    post "/clock_out", UserController, :clock_out

    resources "/admin/users", UserController, except: [:new, :edit]
    post "/admin/users/set_role", UserController, :update_role

    resources "/teams", TeamController, except: [:new, :edit]
    resources "/team_members", TeamMemberController, except: [:new, :edit]
    resources "/workingtimes", WorkingtimeController, except: [:new, :edit]
    resources "/clocks", ClockController, except: [:new, :edit]
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:time_manager_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: TimeManagerApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
