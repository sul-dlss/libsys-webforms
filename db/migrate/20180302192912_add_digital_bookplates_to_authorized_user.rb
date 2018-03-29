class AddDigitalBookplatesToAuthorizedUser < ActiveRecord::Migration
  def change
    add_column :authorized_user, :digital_bookplates, :string
  end
end
