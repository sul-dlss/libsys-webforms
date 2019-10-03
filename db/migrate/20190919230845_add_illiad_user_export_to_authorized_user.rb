class AddIlliadUserExportToAuthorizedUser < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_user, :illiad_user_export, :string
  end
end
