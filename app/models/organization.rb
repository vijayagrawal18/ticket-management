class Organization < ApplicationRecord
  include SearchableModel

  has_many :tag_lists, as: :taggable
  has_many :tags, through: :tag_lists

  has_many :organization_domains
  has_many :domains, through: :organization_domains

  has_many :users

  def self.searchable_attributes
    (column_names - ["id", "updated_at"] + ["tag", "domain"])
  end
end
