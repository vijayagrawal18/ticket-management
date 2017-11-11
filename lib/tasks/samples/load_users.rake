namespace :samples do
  desc "Insert User sample data"

  task load_users: [:environment] do
    service = Import::UserService.new("./db/samples/users.json")
    service.load_file
  end
end
