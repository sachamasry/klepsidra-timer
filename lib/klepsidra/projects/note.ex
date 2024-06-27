defmodule Klepsidra.Projects.Note do
  @moduledoc """
  Defines the schema for the project `notes` entity, annotations
  of ongoing management of projects.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @type t :: %__MODULE__{
          note: String.t(),
          project_id: integer
        }
  schema "project_notes" do
    field :note, :string
    field :project_id, :id

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:note, :project_id])
    |> validate_required([:note])
  end
end
