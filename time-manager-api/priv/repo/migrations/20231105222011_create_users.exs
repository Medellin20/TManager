defmodule TimeManagerApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :username, :string
      add :password_hash, :string
      add :fullname, :string
      add :role, :string, default: "employee"

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email, :username])
  end
end
