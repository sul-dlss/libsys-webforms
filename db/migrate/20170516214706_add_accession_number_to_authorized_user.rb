class AddAccessionNumberToAuthorizedUser < ActiveRecord::Migration
  def change
    add_column :authorized_user, :accession_number, :string
  end
end
