defmodule TimeManagerApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string
    field :role, :string
    field :fullname, :string
    field :clock, :string, default: "0"
    field :password, :string, virtual: true

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :password, :fullname])
    |> validate_required([:email, :username, :password, :fullname])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> put_password_hash
  end

  def changeset2(user, attrs) do
    user
    |> cast(attrs, [:email, :fullname])
    |> validate_required([:email, :fullname, :username])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  def changeset3(user, attrs) do
    user
    |> cast(attrs, [:email, :role])
    |> validate_required([:role])
  end

  def changeset_clock_in(user, attrs) do
    user
    |> cast(attrs, [:email, :clock])
    |> validate_required([:clock])
  end
  def changeset_clock_out(user, attrs) do
    user
    |> cast(attrs, [:email, :clock])
    |> validate_required([:clock])
  end

  def changepass(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> put_password_hash
  end

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]
  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
          changeset
    end
  end

end
