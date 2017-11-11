desc "Setup data"

task setup: [:environment, "db:drop", "db:create", "db:environment:set", "db:migrate", :load_sample_organizations, :load_sample_users, :load_sample_tickets] do
  # "setup_organizations", "setup_users", "setup_tickets"
end
