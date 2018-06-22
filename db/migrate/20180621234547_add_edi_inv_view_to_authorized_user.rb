class AddEdiInvViewToAuthorizedUser < ActiveRecord::Migration
  def change
    add_column :authorized_user, :edi_inv_view, :string
  end
end
