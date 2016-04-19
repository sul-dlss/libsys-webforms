###
# User for authentication and authorization
###
class AuthorizedUser < ActiveRecord::Base
  self.table_name = 'authorized_user'
end
