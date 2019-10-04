###
# Class to model EXPENDITURES oracle table
###
class EndowedFundsReport
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :fund, :fund_begin, :fund_select, :report_format, :date_request,
                :date_ran, :date_type, :fy_start, :fy_end, :cal_start, :cal_end,
                :pd_start, :pd_end, :email, :ckeys_file

  validates :fund, presence: true, if: :blank_fund_begin?
  validates :fund_begin, presence: true, if: :blank_fund?
  validates :fy_start, presence: true, if: :only_fy?
  validates :cal_start, presence: true, if: :only_cal?
  validates :pd_start, presence: true, if: :only_pd?
  validates :email, presence: true
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true

  # get cat keys
  def self.ol_cat_key_fund(fund, date_start, date_end)
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

  def self.ol_cat_key_fy(fund, date_start, date_end)
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

  def self.ol_cat_key_fund_begin(fund_begin, date_start, date_end)
    Expenditures.where("ta_fund_code LIKE ? AND ti_inv_lib = 'SUL' AND ta_date_2encina between
                        TO_DATE(?, 'yyyy-mm-dd') AND TO_DATE(?, 'yyyy-mm-dd')",
                       "%#{fund_begin}%", date_start, date_end).pluck(:ol_cat_key)
  rescue ActiveRecord::StatementInvalid
  end

  def self.ol_cat_key_fy_begin(fund_begin, date_start, date_end)
    Expenditures.where("ta_fund_code LIKE ? AND ti_inv_lib = 'SUL' AND
                       (ti_fiscal_cycle >= ? AND ti_fiscal_cycle <= ?)",
                       "%#{fund_begin}%", date_start, date_end).pluck(:ol_cat_key)
  rescue ActiveRecord::StatementInvalid
  end

  def write_keys(catalog_keys)
    out_file = File.new("#{Settings.symphony_dataload_endowrpt}/#{ckeys_file}", 'w')
    out_file.puts(catalog_keys.join("\n"))
    out_file.close
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

  def blank_fund_begin?
    fund_begin.blank?
  end

  def blank_fund?
    fund.blank?
  end

  def only_fy?
    cal_start.blank? && pd_start.blank?
  end

  def only_cal?
    fy_start.blank? && pd_start.blank?
  end

  def only_pd?
    fy_start.blank? && cal_start.blank?
  end
end
