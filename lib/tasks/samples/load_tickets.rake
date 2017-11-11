namespace :samples do
  desc "Insert Ticket sample data"

  task load_tickets: [:environment] do
    service = Import::TicketService.new("./db/samples/tickets.json")
    service.load_file
  end
end
