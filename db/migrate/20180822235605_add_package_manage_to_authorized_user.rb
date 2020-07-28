class AddPackageManageToAuthorizedUser < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_user, :package_manage, :string
  end
end
