###
# User for authentication and authorization
###
class AuthorizedUser < ApplicationRecord
  include AuthorizedUserHelper
  self.table_name = 'authorized_user'
  self.primary_key = 'user_id'

  validates :user_id, :user_name, presence: true

  before_destroy :app_user?

  private

  def app_user?
    # No Y or A in any AuthorizedUser table column.
    non_admin_user? && admin_user?
  end

  def non_admin_user?
    authorized_apps(AuthorizedUser.find_by(user_id: user_id)).empty?
  end

  def admin_user?
    administrator_apps(AuthorizedUser.find_by(user_id: user_id)).empty?
  end
end
