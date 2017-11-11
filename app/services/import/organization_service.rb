class Import::OrganizationService < Import::BaseService

  private

  def entity_name
    "Organization"
  end

  def import_record org_attr
    tags = org_attr.delete("tags")
    domains = org_attr.delete("domain_names")

    org = Organization.create! org_attr.compact

    org.tags = tags.map{ |name| Tag.find_or_create_by(name: name) }
    org.domains = domains.map{ |name| Domain.find_or_create_by(name: name)}
  end
end
