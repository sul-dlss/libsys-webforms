# URL Exclusion model
class UrlExclusion < ActiveRecord::Base
  validates :url_substring, length: { minimum: 1 }
end
