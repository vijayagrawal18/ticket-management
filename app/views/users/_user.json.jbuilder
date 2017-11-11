json.extract! user, :id, :_id, :url, :external_id, :name, :alias, :active, :verified, :shared, :locale, :timezone, :last_login_at, :email, :phone, :signature, :organization_id, :suspended, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
