defmodule Klepsidra.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects,
             primary_key: false,
             comment:
               "Projects are a complex collection of tasks, which are expected to take a non-trivial amount of time to complete"
           ) do
      add :id, :uuid,
        primary_key: true,
        null: false,
        comment: "UUID-based project primary key"

      add :name, :string,
        null: false,
        comment: "Human-readable project name"

      add :description, :text,
        comment: "Any other project details, which may be useful in the future"

      add :status, :string,
        comment:
          "Indicates current project status, can be one of 'Open', 'Completed' or 'Cancelled'"

      add :project_type, :string,
        comment:
          "Indicates the type, and 'customer' of the project, e.g. 'External', 'Internal', 'Other', etc."

      add :priority, :string,
        comment:
          "Indicates overall project priority, with respect to other projects. Can be one of 'Low', 'Medium', and 'High'"

      add :business_partner_id, references(:business_partners, on_delete: :nothing, type: :uuid),
        comment: "Foreign key linking the project to a customer"

      add :expected_start_date, :date,
        comment:
          "An indicator of when the project is expected to be started, based on a priori projections"

      add :expected_end_date, :date,
        comment:
          "An indicator of when project completion is expected, based on a priori projections"

      add :actual_start_date, :date, comment: "A record of when the project was actually started"

      add :actual_end_date, :date,
        comment:
          "A record of when the project was acually completed, useful for post-project analysis"

      add :estimated_duration, :integer,
        comment:
          "An aggregate expected project duration, denominated in `estimated_duration_time_unit` increments, based on a priori projections"

      add :estimated_duration_time_unit, :string,
        comment:
          "The time unit increment in which the duration in `estimated_duration` is denominated"

      add :billable, :boolean,
        default: false,
        null: false,
        comment: "Is the time spent completing this project billable to the customer?"

      add :estimated_total_billable_amount, :decimal,
        comment:
          "The estimated aggregate amount billable to the customer for the completion of this project"

      add :active, :boolean,
        default: true,
        null: false,
        comment:
          "Is this project considered active? An inactive project may yet be incomplete, but will not show up in lists and select controls"

      timestamps()
    end

    create unique_index(:projects, [:name], comment: "Unique index on the project `name` field")

    create index(:projects, [:status], comment: "Index on the project `status` field")

    create index(:projects, [:project_type], comment: "Index on the project `project_type` field")

    create index(:projects, [:priority], comment: "Index on the project `priority` field")

    create index(:projects, [:business_partner_id],
             comment: "Index on the project `business_partner_id` field"
           )

    create index(:projects, [:billable], comment: "Index on the project `billable` field")

    create index(:projects, [:active], comment: "Index on the project `active` field")

    create index(:projects, [:inserted_at],
             comment:
               "Secondary index of the project `inserted_at` field, for chronological ordering"
           )
  end
end
