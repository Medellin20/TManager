defmodule TimeManagerApi.Membership.TeamMember do
  use Ecto.Schema
  import Ecto.Changeset

  schema "team_members" do

    field :user_id, :id
    field :team_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(team_member, attrs) do
    team_member
    |> cast(attrs, [:user_id, :team_id])
    |> validate_required([:user_id, :team_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:team_id)
  end
end
