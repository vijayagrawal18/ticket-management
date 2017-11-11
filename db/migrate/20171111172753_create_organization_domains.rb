class CreateOrganizationDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_domains do |t|
      t.references :organization, foreign_key: true
      t.references :domain, foreign_key: true

      t.timestamps
    end
  end
end
