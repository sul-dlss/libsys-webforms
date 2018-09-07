class AddLobbytrackToAuthorizedUser < ActiveRecord::Migration
  def change
    add_column :authorized_user, :lobbytrack, :string
  end
end
