module TicketsHelper
  def submitter_link ticket
    submitter = ticket.submitter
    link_to "#{submitter._id} (#{submitter.name})", users_path(field: :_id, value: submitter._id)
  end

  def assignee_link ticket
     if assignee = ticket.assignee
       link_to "#{assignee._id} (#{assignee.name})", users_path(field: :_id, value: assignee._id)
     else
      "Unassigned"
     end
  end
end
