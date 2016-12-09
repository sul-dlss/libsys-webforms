###
# Controller to handle the shelf selection report
###
class ShelfSelectionReportsController < ApplicationController
  include SymphonyCgi
  after_action only: :create do
    submit_shelf_selection(batch_params)
  end

  def new
    @shelf_selection_report = ShelfSelectionReport.new
  end

  def create
    @shelf_selection_report = ShelfSelectionReport.new(params[:shelf_selection_report])
    if @shelf_selection_report.valid?
      flash[:notice] = 'Shelf Selection Report request submitted!'
      ShelfSelSearch.save_search(@shelf_selection_report) if @shelf_selection_report.save_search?
      ShelfSelSearch.update_search(@shelf_selection_report) if @shelf_selection_report.update_search?
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

  def batch_params
    params.require(:shelf_selection_report).permit!
  end
end
