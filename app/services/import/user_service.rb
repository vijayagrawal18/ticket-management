class Import::UserService < Import::BaseService

  private

  def entity_name
    "User"
  end

  def import_record user_attr
    tags = user_attr.delete("tags")

    organization = get_organization user_attr
    user = User.create! user_attr.merge(organization: organization).compact

    user.tags = tags.map{ |name| Tag.find_or_create_by(name: name) }
  end
end
