##
# Module to construct the Shelf Selection Report params for shelf_sel_rpt.cgi
# email :email
# user :search_name
# call_range => call_range :call_lo + :call_hi, or :call_alpha,
# lib :lib
# locs :loc_array
# cloc_diff :cloc_diff
# fmts :fmt_array
# itypes :itype_array
# icat1s :icat1_array
# lang :lang
# min_yr :min_yr
# max_yr :max_yr
# min_circ :min_circ
# max_circ :max_circ
# shadow_na_i_e :shadowed
# digisent_na_i_e :digisent
# url_na_i_e :url
# mhlds_na_i_e :mhlds
# items_other_na_i_e :has_dupes
# multivol_na_i_e :multivol
# multicop_na_i_e :multicop
# exclude_boundw :no_boundw
# subj_name :subj_name
# url_mgt_rpts => URL for page of Mgt Rpt links (for whichever server requested this report)
##
# TODO:NEED TO SEND SUNET ID AS WELL
#
module ShelfSelectionParams
  extend ActiveSupport::Concern

  def submit_shelf_selection(batch_params)
    report_params = batch_params
    report_params.delete_if { |key| key.to_s.match(/call_\w+/) }
    report_params.delete_if { |key| key.to_s.match(/subj_name/) }
    call_range(batch_params, report_params)
    url_mgt_rpts(report_params)
    request_conn('shelf_sel_rpt.cgi', report_params)
  end

  def call_range(batch_params, report_params)
    report_params[:call_range] = "#{batch_params[:call_alpha]}-" if batch_params[:call_alpha].present?
    if batch_params[:call_lo].present?
      report_params[:call_range] = "#{batch_params[:call_lo]}-#{batch_params[:call_hi]}"
    end
  end

  def url_mgt_rpts(report_params)
    report_params[:url_mgt_rpts] = request.base_url
  end
end
