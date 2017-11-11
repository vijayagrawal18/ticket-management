json.extract! ticket, :id, :_id, :url, :external_id, :ticket_type, :subject, :description, :priority, :status, :submitter_id, :assignee_id, :organization_id, :has_incidents, :due_at, :via, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
