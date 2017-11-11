namespace :samples do
  desc "Setup data"

  task load_organizations: [:environment] do
    file = File.read("./db/samples/organizations.json")
    organizations = JSON.parse(file)

    total = organizations.count
    puts "Starting organizations load for #{total} organizations."

    organizations.each do |org_attr|
      begin
        tags = org_attr.delete("tags")
        domains = org_attr.delete("domain_names")

        org = Organization.create! org_attr.compact

        org.tags = tags.map{ |name| Tag.find_or_create_by(name: name) }
        org.domains = domains.map{ |name| Domain.find_or_create_by(name: name)}
      rescue => error
        puts "Error while importing organization: #{org_attr["_id"]}. Skipping"
        puts "Msg: #{error.message}"
        puts "-"*10
      end
    end

    puts "Completed organization import for #{total}"
    puts "-"*30
  end
end
