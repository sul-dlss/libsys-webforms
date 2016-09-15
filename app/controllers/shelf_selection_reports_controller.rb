###
# Controller to handle the shelf selection report
###
class ShelfSelectionReportsController < ApplicationController
  def new
    @shelf_selection_report = ShelfSelectionReport.new
  end

  def create
    @shelf_selection_report = ShelfSelectionReport.new(params[:shelf_selection_report])
    if @shelf_selection_report.valid?
      flash[:notice] = 'Shelf Selection Report params submitted!'
      # save to shelf_sel_search
      redirect_to root_url
    else
      render action: 'new'
    end
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
