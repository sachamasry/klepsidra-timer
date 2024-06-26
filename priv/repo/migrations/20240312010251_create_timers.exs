defmodule Klepsidra.Repo.Migrations.CreateTimers do
  use Ecto.Migration

  def change do
    create table(:timers) do
      add :start_stamp, :string
      add :end_stamp, :string
      add :duration, :integer
      add :duration_time_unit, :string
      add :billable, :boolean, default: false, null: false
      add :business_partner_id, references(:business_partners, on_delete: :nothing)
      add :activity_type_id, references(:activity_types, on_delete: :nothing)
      add :billing_rate, :decimal
      add :billing_duration, :integer
      add :billing_duration_time_unit, :string
      add :description, :string
      add :project_id, references(:projects, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:timers, [:start_stamp])
  end
end
