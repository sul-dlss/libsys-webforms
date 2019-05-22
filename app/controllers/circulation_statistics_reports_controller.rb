###
#  Controller to handle the Circulation Statistics Report
###
class CirculationStatisticsReportsController < ApplicationController
  def new
    @circulation_statistics_report = CirculationStatisticsReport.new
  end

  def create
    @circulation_statistics_report = CirculationStatisticsReport.new(circulation_statistics_report_params)
    if @circulation_statistics_report.valid?
      CirculationStatisticsReportLog.save_stats(@circulation_statistics_report)
      flash[:notice] = 'Circulation Statistics Report submitted!'
      redirect_to root_url
    else
      render action: 'new'
    end
  end

  def home_locations
    @home_locations = UniLibsLocs.home_locations_from(params[:lib])
    render layout: false
  end

  private

  def circulation_statistics_report_params
    params.require(:circulation_statistics_report).permit(:email, { lib_array: [] }, :source, :range_type,
                                                          :call_lo, :call_hi, :call_alpha, :barcodes,
                                                          { format_array: [] }, :exclude_inactive, :min_yr,
                                                          :max_yr, :exclude_bad_yr, :include_inhouse,
                                                          :no_qtrly, :ckey_url, :tag_field, :tag_field2,
                                                          :tags_url, :link_type, :col_header1, :col_header2,
                                                          :col_header3, :col_header4, :col_header5,
                                                          :blank_col_array, :lib_loc_array, :user_id)
  end
end
