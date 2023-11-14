defmodule TimeManagerApiWeb.UserController do
  use TimeManagerApiWeb, :controller

  alias TimeManagerApi.Accounts
  alias TimeManagerApi.Accounts.User

  action_fallback TimeManagerApiWeb.FallbackController
  alias TimeManagerApi.Guardian

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
      {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_resp_cookie("jwt", token, [http_only: true, max_age: 2592000])
      |> render("jwt.json", jwt: token)
      # conn
      # |> put_status(:created)
      # |> put_resp_header("location", ~p"/api/users/#{user}")
      # |> put_resp_cookie("jwt", token, [http_only: true, max_age: 3600])
      # |> render(:show, user: user)
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn
        |> put_resp_cookie("jwt", token, [http_only: true, max_age: 2592000])
        |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def show(conn, %{"id" => id}) do
    #user = Accounts.get_user!(id)
    case Guardian.decode_and_verify(conn.req_cookies["jwt"]) do
      {:ok, claims} ->
        sub_value = Map.get(claims, "sub")
        IO.puts("sub: #{sub_value}")
        user = Accounts.get_user!(id)
        render(conn, :show, user: user)
      _ ->
        conn
        |> put_status(:unauthorized)
        |> halt()
    end
  end
  def show_account(conn, _params) do
    #user = Accounts.get_user!(id)
    case Guardian.decode_and_verify(conn.req_cookies["jwt"]) do
      {:ok, claims} ->
        sub_value = Map.get(claims, "sub")
        IO.puts("sub: #{sub_value}")
        user = Accounts.get_user!(sub_value)
        render(conn, :show, user: user)
      _ ->
        conn
        |> put_status(:unauthorized)
        |> halt()
    end
  end

  def show_account2(conn, %{"jwt" => jwt}) do
    #user = Accounts.get_user!(id)
    case Guardian.decode_and_verify(jwt) do
      {:ok, claims} ->
        sub_value = Map.get(claims, "sub")
        IO.puts("sub: #{sub_value}")
        user = Accounts.get_user!(sub_value)
        render(conn, :show, user: user)
      _ ->
        conn
        |> put_status(:unauthorized)
        |> halt()
    end
  end

  def update(conn, %{"id" => id, "user" => user_params, "jwt" => jwt}) do
    #case Guardian.decode_and_verify(conn.req_cookies["jwt"]) do
    case Guardian.decode_and_verify(jwt) do
      {:ok, claims} ->
        sub_value = Map.get(claims, "sub")
        user = Accounts.get_user!(sub_value)
        with {:ok, %User{} = user} <- Accounts.update_role(user, user_params) do
          render(conn, :show, user: user)
        end
      _  ->
      conn
        |> put_status(:unauthorized)
        |> halt()
    end
  end

  def update_role(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)
    with {:ok, %User{} = user} <- Accounts.update_role(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def update_pass(conn, %{"id" => id, "user" => user_params,  "jwt" => jwt}) do
    #case Guardian.decode_and_verify(conn.req_cookies["jwt"]) do
    case Guardian.decode_and_verify(jwt) do
      {:ok, claims} ->
        sub_value = Map.get(claims, "sub")
        user = Accounts.get_user!(sub_value)
        with {:ok, %User{} = user} <- Accounts.change_pass(user, user_params) do
          render(conn, :show, user: user)
        end
      _  ->
      conn
        |> put_status(:unauthorized)
        |> halt()
    end
  end



  def clock_in(conn, %{"user" => user_params,  "jwt" => jwt}) do
    #case Guardian.decode_and_verify(conn.req_cookies["jwt"]) do
    case Guardian.decode_and_verify(jwt) do
      {:ok, claims} ->
        sub_value = Map.get(claims, "sub")
        user = Accounts.get_user!(sub_value)
        with {:ok, %User{} = user} <- Accounts.change_clock_in(user, user_params) do
          render(conn, :show, user: user)
        end
      _  ->
      conn
        |> put_status(:unauthorized)
        |> halt()
    end
  end

  def clock_out(conn, %{"user" => user_params,  "jwt" => jwt}) do
    #case Guardian.decode_and_verify(conn.req_cookies["jwt"]) do
    case Guardian.decode_and_verify(jwt) do
      {:ok, claims} ->
        sub_value = Map.get(claims, "sub")
        user = Accounts.get_user!(sub_value)
        with {:ok, %User{} = user} <- Accounts.change_clock_out(user, user_params) do
          render(conn, :show, user: user)
        end
      _  ->
      conn
        |> put_status(:unauthorized)
        |> halt()
    end
  end


  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
