class AddLobbytrackToAuthorizedUser < ActiveRecord::Migration[5.2]
  def change
    add_column :authorized_user, :lobbytrack, :string
  end
end
