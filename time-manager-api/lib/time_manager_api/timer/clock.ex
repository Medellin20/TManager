defmodule TimeManagerApi.Timer.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clocks" do
    field :status, :boolean, default: true
    field :time, :naive_datetime
    field :task_id, :integer
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :task_id, :user_id])
    |> validate_required([:time, :status, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
