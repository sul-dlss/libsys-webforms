###
# User for authentication and authorization
###
class AuthorizedUser < ApplicationRecord
  include AuthorizedUserHelper
  self.table_name = 'authorized_user'
  self.primary_key = 'user_id'

  validates :user_id, :user_name, presence: true
end
