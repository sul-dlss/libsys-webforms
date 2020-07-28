class AddSal3BreqEditToAuthorizedUser < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_user, :sal3_breq_edit, :string
  end
end
