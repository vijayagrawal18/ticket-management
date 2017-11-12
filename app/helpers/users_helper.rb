module UsersHelper
  # Should be changed to id to avoid confustion w/ multiple users havign same name
  def submitted_tickets_link user
    link_to user.submitted_tickets_count, tickets_path(field: :submitter, value: user.name)
  end

  def assigned_tickets_link user
    link_to user.assigned_tickets_count, tickets_path(field: :assignee, value: user.name)
  end
end
