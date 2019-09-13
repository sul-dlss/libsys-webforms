###
#  Controller for handling login and redirecting with flash messages.
###
class AuthenticationController < ApplicationController
  def login
    flash[:success] = 'You have been successfully logged in.'
    redirect_back(fallback_location: root_path)
  end
end
