class AddUserloadRerunToAuthorizedUser < ActiveRecord::Migration
  def change
    add_column :authorized_user, :userload_rerun, :string
  end
end
