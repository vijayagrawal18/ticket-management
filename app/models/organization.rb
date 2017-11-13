class Organization < ApplicationRecord
  include SearchableModel

  has_many :tag_lists, as: :taggable
  has_many :tags, through: :tag_lists

  has_many :organization_domains
  has_many :domains, through: :organization_domains

  has_many :users

  def self.searchable_attributes
    @@_searchable_attributes ||= begin
      non_searchables = ["id", "updated_at", "users_count", "tickets_count"]

      column_names - non_searchables + [TAG_FIELD, DOMAIN_FIELD]
    end
  end

  def self.search_by_domain term
    if term.present?
      where(id: self.joins(:domains).where("UPPER(domains.name) = UPPER(?)", term))
    else
      where.not(id: OrganizationDomain.select(:organization_id))
    end
  end
end
