class AddDigitalBookplatesToAuthorizedUser < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_user, :digital_bookplates, :string
  end
end
