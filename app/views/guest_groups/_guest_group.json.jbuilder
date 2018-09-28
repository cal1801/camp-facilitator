json.extract! guest_group, :id, :name, :description, :arrives, :leaves, :created_at, :updated_at
json.url guest_group_url(guest_group, format: :json)
