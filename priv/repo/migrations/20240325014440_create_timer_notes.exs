defmodule Klepsidra.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:timer_notes,
             primary_key: false,
             comment: "Table to store activity timer annotations and running comments"
           ) do
      add :id, :uuid,
        primary_key: true,
        null: false,
        comment: "UUID-based timer notes primary key"

      add :note, :text, comment: "Note or commentary on the activity timer"

      add :user_id, :integer,
        comment: "Unique identifier of the system user annotating the activity timer"

      add :timer_id, references(:timers, on_delete: :nothing),
        comment: "Foreign key referencing the activity timer"

      timestamps()
    end

    create index(:timer_notes, [:timer_id],
             comment: "Index with the `timer_id` as the main indexed key"
           )
  end
end
