###
# User for authentication and authorization
###
class AuthorizedUser < ActiveRecord::Base
  include AuthorizedUserHelper
  self.table_name = 'authorized_user'
  self.primary_key = 'user_id'

  validates :user_id, :user_name, presence: true

  before_destroy :non_admin_user?

  private

  def non_admin_user?
    authorized_apps(AuthorizedUser.find_by(user_id: user_id)).empty?
  end
end
