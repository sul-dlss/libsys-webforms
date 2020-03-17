###
# Class to model EXPENDITURES oracle table
###
class EndowedFundsReport
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :fund, :fund_begin, :fund_select, :report_format, :date_request,
                :date_ran, :date_type, :fy_start, :fy_end, :cal_start, :cal_end,
                :pd_start, :pd_end, :email, :ckeys_file

  validate :email_format
  validate :fund_selection_present
  validate :start_date_present

  def keys
    if fund.present?
      fiscal_years.any? ? ol_cat_key_fy : ol_cat_key_fund
    elsif fund_begin.present?
      fiscal_years.any? ? ol_cat_key_fy_begin : ol_cat_key_fund_begin
    end
  end

  # get cat keys
  def ol_cat_key_fund
    fund_codes = []
    fund.each do |fc|
      Expenditures.where("ta_fund_code = ? AND ta_date_2encina between
                          TO_DATE(?, 'yyyy-mm-dd') AND TO_DATE(?, 'yyyy-mm-dd')",
                         fc, date_start, date_end).pluck(:ol_cat_key).each do |ckey|
        fund_codes << ckey
      end
    rescue ActiveRecord::StatementInvalid
    end
    fund_codes.uniq
  end

  def ol_cat_key_fy
    fund_codes = []
    fund.each do |fc|
      Expenditures.where('ta_fund_code = ? AND (ti_fiscal_cycle >= ? AND ti_fiscal_cycle <= ?)',
                         fc, date_start, date_end).pluck(:ol_cat_key).each do |ckey|
        fund_codes << ckey
      end
    rescue ActiveRecord::StatementInvalid
    end
    fund_codes.uniq
  end

  def ol_cat_key_fund_begin
    Expenditures.where("ta_fund_code LIKE ? AND ti_inv_lib = 'SUL' AND ta_date_2encina between
                        TO_DATE(?, 'yyyy-mm-dd') AND TO_DATE(?, 'yyyy-mm-dd')",
                       "%#{fund_begin}%", date_start, date_end).pluck(:ol_cat_key)
  rescue ActiveRecord::StatementInvalid
  end

  def ol_cat_key_fy_begin
    Expenditures.where("ta_fund_code LIKE ? AND ti_inv_lib = 'SUL' AND
                       (ti_fiscal_cycle >= ? AND ti_fiscal_cycle <= ?)",
                       "%#{fund_begin}%", date_start, date_end).pluck(:ol_cat_key)
  rescue ActiveRecord::StatementInvalid
  end

  def date_start
    if fiscal_years.any?
      start_date = fiscal_years[0]
    elsif calendar_years.any?
      start_date = Time.parse("#{calendar_years[0]}-01-01").in_time_zone.strftime('%Y-%m-%d')
    elsif paid_years.any?
      start_date = Time.parse(paid_years[0].to_s).in_time_zone.strftime('%Y-%m-%d')
    end
    start_date
  end

  def date_end
    if fiscal_years.any?
      end_date = fiscal_years[1]
    elsif calendar_years.any?
      end_date = Time.parse("#{calendar_years[1]}-12-31").in_time_zone.strftime('%Y-%m-%d')
    elsif paid_years.any?
      end_date = Time.parse(paid_years[1].to_s).in_time_zone.strftime('%Y-%m-%d')
    end
    end_date
  end

  def fiscal_years
    years = []
    if [fy_start, fy_end].all?
      years = [fy_start.tr('FY ', ''), fy_end.tr('FY ', '')].delete_if { |a| a == '' }
      years.push(fy_start.tr('FY ', '')) if years.length == 1
    end
    years
  end

  def calendar_years
    years = [cal_start, cal_end].delete_if { |a| a == '' }
    years.push(cal_start) if years.length == 1
    years
  end

  def paid_years
    years = [pd_start, pd_end].delete_if { |a| a == '' }
    years.push(pd_start) if years.length == 1
    years
  end

  private

  def start_date_present
    message = 'Choose a start date for fiscal, calendar, or paid date'
    errors.add(:base, message) unless type_of_date_present?
  end

  def type_of_date_present?
    case date_type
    when 'calendar'
      cal_start.present?
    when 'fiscal'
      fy_start.present?
    when 'paydate'
      pd_start.present?
    end
  end

  def email_format
    message = 'Email address is missing or not in a correct format'
    errors.add(:base, message) unless email.match(Rails.configuration.email_pattern)
  end

  def fund_selection_present
    message = 'Select a single Fund ID/PTA, a fund that begins with an ID/PTA number, or all SUL funds'
    errors.add(:base, message) unless fund.present? || fund_begin.present?
  end
end
