module TicketsHelper
  def submitter_link ticket
    link_to ticket.submitter.name, users_path(field: :name, value: ticket.submitter.name)
  end

  def assignee_link ticket
     if ticket.assignee
       link_to ticket.assignee.name, users_path(field: :name, value: ticket.assignee.name)
     else
      "Unassigned"
     end
  end
end
