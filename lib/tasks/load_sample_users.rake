desc "Insert User sample data"

task load_sample_users: [:environment] do
  file = File.read("./db/samples/users.json")
  users = JSON.parse(file)

  total = users.count
  puts "Starting users load for #{total} users."

  JSON.parse(file).each do |user_attr|
    begin
      tags = user_attr.delete("tags")

      organization_id = user_attr.delete("organization_id")
      organization = Organization.find_by!(_id: organization_id) if organization_id

      user = User.create! user_attr.merge(organization: organization).compact

      user.tags = tags.map{ |name| Tag.find_or_create_by(name: name) }
    rescue => error
      puts "Error while importing user: #{user_attr["_id"]}. Skipping"
      puts "Msg: #{error.message}"
      puts "-"*10
      total += 1
    end
  end

  puts "Completed user import for #{total}"
  puts "-"*30
end
