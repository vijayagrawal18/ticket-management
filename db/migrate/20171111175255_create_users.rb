class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :_id, null: false
      t.string :url, null: false
      t.string :external_id, null: false
      t.string :name, null: false
      t.string :alias
      t.boolean :active, null: false, default: true
      t.boolean :verified, null: false, default: false
      t.boolean :shared, null: false, default: false
      t.string :locale
      t.string :timezone
      t.datetime :last_login_at, null: false
      t.string :email
      t.string :phone
      t.string :signature
      t.references :organization, foreign_key: true
      t.boolean :suspended, null: false, default: false
      t.string :role, null: false

      t.timestamps
    end

    add_index :users, :_id, unique: true
  end
end
