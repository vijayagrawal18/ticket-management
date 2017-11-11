desc "Setup data"

task setup: [:environment,
             "db:drop",
             "db:create",
             "db:environment:set",
             "db:migrate",
             "samples:load_organizations",
             "samples:load_users",
             "samples:load_tickets"] do
end
