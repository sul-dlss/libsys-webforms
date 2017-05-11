##
# Module to construct the Endow Funds Report params for endow_rpt.cgi
#  script exists @bodoni.stanford.edu:/var/www/cgi-bin/webforms/endow_rpt.cgi
# All the args in URL:
# ('ckeys_filename')('date_range')('email')('funds')('output_format')
##
module EndowFundsParams
  def submit_endow_funds(batch_params)
    report_params = {}
    ckeys_filename(report_params)
    output_format(batch_params, report_params)
    email(batch_params, report_params)
    fund_str(batch_params, report_params)
    date_range(batch_params, report_params)
    request_conn('endow_rpt.cgi', report_params)
  end

  private

  def ckeys_filename(report_params)
    report_params[:ckeys_filename] = batch_params[:ckeys_file]
  end

  def output_format(batch_params, report_params)
    report_params[:output_format] = batch_params[:report_format]
  end

  def email(batch_params, report_params)
    report_params[:email] = batch_params[:email]
  end

  def fund_str(batch_params, report_params)
    if batch_params[:fund_begin].present?
      report_params[:funds] = batch_params[:fund_begin]
    elsif batch_params[:fund].present?
      report_params[:funds] = batch_params[:fund].join(',')
    end
  end

  def date_range(batch_params, report_params)
    end_dates(batch_params)
    fy_start_end(batch_params, report_params) if batch_params[:fy_start].present?
    cal_start_end(batch_params, report_params) if batch_params[:cal_start].present?
    pd_start_end(batch_params, report_params) if batch_params[:pd_start].present?
  end

  def end_dates(batch_params)
    batch_params[:fy_end] = batch_params[:fy_start] if batch_params[:fy_end].blank?
    batch_params[:cal_end] = batch_params[:cal_start] if batch_params[:cal_end].blank?
    batch_params[:pd_end] = batch_params[:pd_start] if batch_params[:pd_end].blank?
  end

  def fy_start_end(batch_params, report_params)
    d1 = [batch_params[:fy_start], batch_params[:fy_end]].min
    d2 = [batch_params[:fy_start], batch_params[:fy_end]].max
    report_params[:date_range] = "#{d1} to #{d2}"
  end

  def cal_start_end(batch_params, report_params)
    d1 = [batch_params[:cal_start], batch_params[:cal_end]].min
    d2 = [batch_params[:cal_start], batch_params[:cal_end]].max
    report_params[:date_range] = "Jan 1, #{d1} to Dec 31, #{d2}"
  end

  def pd_start_end(batch_params, report_params)
    d1 = [batch_params[:pd_start], batch_params[:pd_end]].min
    d2 = [batch_params[:pd_start], batch_params[:pd_end]].max
    report_params[:date_range] = "#{d1} to #{d2}"
  end
end
