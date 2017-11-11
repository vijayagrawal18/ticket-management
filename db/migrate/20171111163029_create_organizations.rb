class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.integer :_id, null: false
      t.string :url, null: false
      t.string :external_id, null: false
      t.string :name, null: false
      t.string :details
      t.boolean :shared_tickets, null: false, default: false

      t.timestamps
    end

    add_index :organizations, :_id, unique: true
  end
end
