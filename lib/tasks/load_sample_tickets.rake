desc "Insert Ticket sample data"

task load_sample_tickets: [:environment] do
  file = File.read("./db/samples/tickets.json")
  tickets = JSON.parse(file)

  total = tickets.count
  puts "Starting tickets load for #{total} tickets."

  tickets.each do |ticket_attr|
    begin
      tags = ticket_attr.delete("tags")

      organization_id = ticket_attr.delete("organization_id")
      organization = Organization.find_by!(_id: organization_id) if organization_id

      submitter = User.find_by!(_id: ticket_attr.delete("submitter_id"))

      assignee_id = ticket_attr.delete("assignee_id")
      assignee = User.find_by!(_id: assignee_id) if assignee_id

      ticket_type = ticket_attr.delete "type"

      ticket = Ticket.create! ticket_attr.merge(organization: organization, submitter: submitter, assignee: assignee, ticket_type: ticket_type).compact

      ticket.tags = tags.map{ |name| Tag.find_or_create_by(name: name) }
    rescue => error
      puts "Error while importing ticket: #{ticket_attr["_id"]}. Skipping"
      puts "Msg: #{error.message}"
      puts "-"*10
    end
  end
  puts "Completed ticket import for #{total}"
  puts "-"*30
end
