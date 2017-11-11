desc "Setup data"

task setup: [:environment,
             "db:drop",
             "db:create",
             "db:environment:set",
             "db:migrate",
             :to_stdout,
             "samples:load_organizations",
             "samples:load_users",
             "samples:load_tickets"] do
end

task :to_stdout => [:environment] do
 Rails.logger = Logger.new(STDOUT)
end
