class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :_id, null: false
      t.string :url, null: false
      t.string :external_id, null: false
      t.integer :ticket_type
      t.string :subject, null: false
      t.string :description
      t.integer :priority
      t.integer :status, null: false, default: 0
      t.references :submitter, foreign_key: { to_table: :users }, null: false
      t.references :assignee, foreign_key:  { to_table: :users }
      t.references :organization, foreign_key: true
      t.boolean :has_incidents, null: false, default: false
      t.datetime :due_at
      t.integer :via, null: false

      t.timestamps
    end

    add_index :tickets, :_id, unique: true
  end
end
