# Controller for lobbytrack report
class LobbytrackController < ApplicationController
  def show
    @lobbytrack = LobbyTrack.query(params[:id])
    return if @lobbytrack.any?
    if Settings.lobbytrack_ips.include?(client_ip.to_s)
      flash[:error] = 'You cannot access Lobbytrack from the current client IP address'
    else
      flash[:warning] = "There is no attendance history for id #{params[:id]}"
    end
    redirect_to root_path
  end
end
