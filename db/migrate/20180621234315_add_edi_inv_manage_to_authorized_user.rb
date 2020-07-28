class AddEdiInvManageToAuthorizedUser < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_user, :edi_inv_manage, :string
  end
end
