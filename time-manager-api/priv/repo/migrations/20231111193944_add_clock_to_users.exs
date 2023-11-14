defmodule TimeManagerApi.Repo.Migrations.AddClockToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :clock, :string, default: "0"
    end
  end
end
