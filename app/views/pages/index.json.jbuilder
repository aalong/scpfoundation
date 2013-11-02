json.array!(@pages) do |page|
  json.extract! page, :title, :content, :name, :slug, :commit_message, :namespace_id, :user_id
  json.url page_url(page, format: :json)
end