class Import::TicketService < Import::BaseService

  private

  def entity_name
    "Ticket"
  end

  def import_record ticket_attr
    tags = ticket_attr.delete("tags")

    additional_params = {
                          organization: get_organization(ticket_attr),
                          submitter: get_submitter(ticket_attr),
                          assignee: get_assignee(ticket_attr),
                          ticket_type: ticket_attr.delete("type"),
                        }

    ticket = Ticket.create! ticket_attr.merge(additional_params).compact

    ticket.tags = tags.map{ |name| Tag.find_or_create_by(name: name) }
  end

  def get_submitter ticket_attr
    User.find_by!(_id: ticket_attr.delete("submitter_id"))
  end

  def get_assignee ticket_attr
    assignee_id = ticket_attr.delete("assignee_id")
    User.find_by!(_id: assignee_id) if assignee_id
  end
end
