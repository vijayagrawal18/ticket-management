class OrganizationDomain < ApplicationRecord
  belongs_to :organization
  belongs_to :domain

  scope :having_all,  -> domain_ids {
    where(domain: domain_ids).group(:organization_id)
                             .having("count('id') = ?", domain_ids.count)
  }
end
