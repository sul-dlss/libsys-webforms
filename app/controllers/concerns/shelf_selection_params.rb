##
# Module to construct the Shelf Selection Report params for shelf_sel_rpt.cgi
# email :email
# user :search_name
# call_range => call_range :call_lo + :call_hi, or :call_alpha,
# lib :lib
# locs :loc_array
# cloc_diff :cloc_diff
# fmts :format_array
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
module ShelfSelectionParams
  def submit_shelf_selection(batch_params)
    report_params = batch_params.clone
    report_params.delete_if { |key| key.to_s.match(/call_\w+/) }
    report_params.delete_if { |key| key.to_s == 'search_name' }
    call_range(batch_params, report_params)
    format_str(batch_params, report_params)
    itype_str(batch_params, report_params)
    icat1_str(batch_params, report_params)
    loc_str(batch_params, report_params)
    no_boundw(report_params)
    url_mgt_rpts(report_params)
    request_conn('shelf_sel.cgi', report_params)
  end

  def call_range(batch_params, report_params)
    if batch_params[:call_alpha].present?
      report_params[:call_range] = "#{batch_params[:call_alpha]}#{batch_params[:call_lo]}-#{batch_params[:call_hi]}"
    elsif batch_params[:call_lo].present?
      report_params[:call_range] = "#{batch_params[:call_lo]}-#{batch_params[:call_hi]}"
      report_params[:call_range] = "#{batch_params[:call_lo]}0-9999".delete('#') if batch_params[:call_lo] =~ /\w+\#/
    elsif batch_params[:call_hi].present?
      report_params[:call_range] = "OTHER-#{batch_params[:call_hi]}"
    end
  end

  def format_str(batch_params, report_params)
    unless batch_params[:format_array].nil? || batch_params[:format_array] == 'All Formats'
      report_params[:format_array] = batch_params[:format_array].reject! { |a| a == '' }.join(',')
    end
  end

  def itype_str(batch_params, report_params)
    unless batch_params[:itype_array].nil? || batch_params[:itype_array] == 'All Item Types'
      report_params[:itype_array] = batch_params[:itype_array].reject! { |a| a == '' }.join(',')
    end
  end

  def icat1_str(batch_params, report_params)
    unless batch_params[:icat1_array].nil? || batch_params[:icat1_array] == 'All Item Category1s'
      report_params[:icat1_array] = batch_params[:icat1_array].reject! { |a| a == '' }.join(',')
    end
  end

  def loc_str(batch_params, report_params)
    unless batch_params[:loc_array].nil? || batch_params[:loc_array] == 'ALL'
      report_params[:loc_array] = batch_params[:loc_array].reject! { |a| a == '' }.join(',')
    end
  end

  def no_boundw(report_params)
    report_params[:no_boundw] = 2 if report_params[:no_boundw].to_i.round == 1
  end

  def url_mgt_rpts(report_params)
    report_params[:url_mgt_rpts] = request.base_url
  end
end
