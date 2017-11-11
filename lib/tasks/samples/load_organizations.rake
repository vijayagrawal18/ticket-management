namespace :samples do
  desc "Setup data"

  task load_organizations: [:environment] do
    service = Import::OrganizationService.new("./db/samples/organizations.json")
    service.load_file
  end
end
