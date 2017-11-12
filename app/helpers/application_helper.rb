module ApplicationHelper
  def organization_link model
    link_to(model.organization.name, organizations_path(field: :name, value: model.organization.name)) if model.organization
  end

  def tag_names model
    model.tags.pluck(:name).join(", ")
  end
end
