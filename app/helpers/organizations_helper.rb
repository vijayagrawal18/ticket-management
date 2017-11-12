module OrganizationsHelper

  def users_link organization
    link_to organization.users_count,  users_path(field: :organization, value: organization.name)
  end

  def tickets_link organization
    link_to organization.tickets_count,  tickets_path(field: :organization, value: organization.name)
  end

  def domain_names organization
    organization.domains.pluck(:name).join ", "
  end
end
