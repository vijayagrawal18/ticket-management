module ApplicationHelper
  def organization_link model
    organization = model.organization
    link_to("#{organization._id} (#{organization.name})", organizations_path(field: :_id, value: organization._id)) if organization
  end

  def tag_names model
    model.tags.pluck(:name).join(", ")
  end
end
