# Controller to handle root HTTP
# connections and display the home page
class HomeController < ApplicationController
  def home
  end

  def index
    @current_user_name = current_user_name
  end
end
