class ChangeColumnNameLobbytrackReports < ActiveRecord::Migration[5.2]
  def change
    rename_column :authorized_user, :lobbytrack, :lobbytrack_report
  end
end
