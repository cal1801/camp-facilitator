json.extract! account, :id, :first_name, :last_name, :phone_number, :created_at, :updated_at
json.url account_url(account, format: :json)
