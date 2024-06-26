defmodule Klepsidra.TimeTracking.ActivityType do
  @moduledoc """
  Defines a schema for the `ActivityType` entity, used to set activity types on timers.

  Activity types are a way to preload billing defaults, to help calculate
  billing amounts at time of invoicing.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  @type t :: %__MODULE__{
          name: String.t(),
          billing_rate: number(),
          active: boolean()
        }
  schema "activity_types" do
    field :name, :string
    field :billing_rate, :decimal
    field :active, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(activity_type, attrs) do
    activity_type
    |> cast(attrs, [:name, :billing_rate, :active])
    |> unique_constraint(:name)
    |> validate_required([:name])
    |> validate_required([:billing_rate])
    |> validate_number(:billing_rate, greater_than_or_equal_to: 0)
  end

  @doc """
  Used across live components to populate select options with activity types.
  """
  @spec populate_activity_types_list() :: [Klepsidra.TimeTracking.ActivityType.t(), ...]
  def populate_activity_types_list() do
    [
      {"", ""}
      | Klepsidra.TimeTracking.list_activity_types()
        |> Enum.map(fn type -> {type.name, type.id} end)
    ]
  end
end
