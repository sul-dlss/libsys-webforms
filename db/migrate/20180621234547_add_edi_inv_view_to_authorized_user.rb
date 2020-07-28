class AddEdiInvViewToAuthorizedUser < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_user, :edi_inv_view, :string
  end
end
