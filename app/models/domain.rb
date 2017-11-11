class Domain < ApplicationRecord
  has_many :organization_domains
  has_many :organizations, through: :organization_domains
end
