class AddPackageManageToAuthorizedUser < ActiveRecord::Migration
  def change
    add_column :authorized_user, :package_manage, :string
  end
end
