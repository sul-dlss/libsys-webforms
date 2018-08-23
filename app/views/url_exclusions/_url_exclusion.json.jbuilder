json.extract! url_exclusion, :id, :url_substring, :created_at, :updated_at
json.url url_exclusion_url(url_exclusion, format: :json)
