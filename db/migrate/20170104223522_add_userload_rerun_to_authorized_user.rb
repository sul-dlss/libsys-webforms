class AddUserloadRerunToAuthorizedUser < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_user, :userload_rerun, :string
  end
end
