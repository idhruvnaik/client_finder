json.clients do
  json.array! @clients do |client|
    json.user_id client.user_id
    json.name client.name
  end
end
