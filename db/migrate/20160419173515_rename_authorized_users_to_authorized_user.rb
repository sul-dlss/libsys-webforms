class RenameAuthorizedUsersToAuthorizedUser < ActiveRecord::Migration
  def change
    rename_table :authorized_users, :authorized_user
  end
end
