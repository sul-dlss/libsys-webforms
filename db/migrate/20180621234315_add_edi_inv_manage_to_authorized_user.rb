class AddEdiInvManageToAuthorizedUser < ActiveRecord::Migration
  def change
    add_column :authorized_user, :edi_inv_manage, :string
  end
end
