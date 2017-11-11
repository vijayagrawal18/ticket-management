class CreateTagLists < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_lists do |t|
      t.string :taggable_type
      t.integer :taggable_id
      t.references :tag, foreign_key: true

      t.timestamps
    end

    add_index :tag_lists, [:taggable_type, :taggable_id]
  end
end
