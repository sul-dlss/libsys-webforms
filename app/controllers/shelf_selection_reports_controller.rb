###
# Controller to handle the shelf selection report
###
class ShelfSelectionReportsController < ApplicationController
  def new
    @shelf_selection_report = ShelfSelectionReport.new
  end

  def create
    @shelf_selection_report = ShelfSelectionReport.new(params[:shelf_selection_report])
    flash[:notice] = 'Shelf Selection Report params submitted!'
    redirect_to root_url
  end

  def home_locations
    @home_locations = UniLibsLocs.home_locations_from(params[:lib])
    render layout: false
  end

  def load_saved_options
    @shelf_sel_search = ShelfSelSearch.from_search_name(params[:search_name])
    render layout: false
  end
end
