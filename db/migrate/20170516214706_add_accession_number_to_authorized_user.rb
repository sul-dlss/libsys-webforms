class AddAccessionNumberToAuthorizedUser < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_user, :accession_number, :string
  end
end
