class Organization < ApplicationRecord
  has_many :tag_lists, as: :taggable
  has_many :tags, through: :tag_lists

  has_many :organization_domains
  has_many :domains, through: :organization_domains

  has_many :users
end
