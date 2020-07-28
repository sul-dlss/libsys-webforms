class RenameAuthorizedUsersToAuthorizedUser < ActiveRecord::Migration[5.0]
  def change
    rename_table :authorized_users, :authorized_user
  end
end
