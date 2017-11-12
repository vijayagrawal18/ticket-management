module UsersHelper
  def submitted_tickets_link user
    link_to user.submitted_tickets_count, tickets_path(field: :submitter_id, value: user._id)
  end

  def assigned_tickets_link user
    link_to user.assigned_tickets_count, tickets_path(field: :assignee_id, value: user._id)
  end
end
