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

  def self.search_by_domains term
    if term.present?
      term_arr = term.split(",").map { |name| name.strip.upcase }
      domains = Domain.where("UPPER(name) IN (?)", term_arr)

      return none if domains.count != term_arr.compact.count

      where(id: OrganizationDomain.having_all(domains).select(:organization_id))
    else
      where.not(id: OrganizationDomain.select(:organization_id))
    end
  end
end
