# Controller to handle root HTTP
# connections and display the home page
class HomeController < ApplicationController
  def home; end

  def index
    redirect_to accession_number_updates_path
  end
end
