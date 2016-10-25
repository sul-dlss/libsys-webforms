###
# Class to model EXPENDITURES oracle table
###
class EndowedFundsReport
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :fund, :fund_begin, :fund_select, :report_format, :date_request,
                :date_ran, :date_type, :fy_start, :fy_end, :cal_start, :cal_end,
                :pd_start, :pd_end, :email, :ckeys_file

  validates :fund, presence: true, if: 'fund_begin.blank?'
  validates :fund_begin, presence: true, if: 'fund.blank?'
  validates :fy_start, presence: true, if: 'cal_start.blank? && pd_start.blank?'
  validates :cal_start, presence: true, if: 'fy_start.blank? && pd_start.blank?'
  validates :pd_start, presence: true, if: 'cal_start.blank? && fy_start.blank?'

  # get cat keys
  def self.ol_cat_key(fund)
    if fund.is_a?(Array)
      fund_codes = []
      fund.each do |fc|
        Expenditures.where('ta_fund_code = ?', fc).pluck(:ol_cat_key).each do |ckey|
          fund_codes << ckey
        end
      end
      fund_codes.uniq
    elsif fund.is_a?(String)
      Expenditures.where('ta_fund_code LIKE ?', "%#{fund}%").pluck(:ol_cat_key)
    end
  end

  def ckeys_file
    @ckeys_file
  end

  def write_keys(catalog_keys)
    symphony_location = "/symphony/Dataload/EndowRpt/#{ckeys_file}"
    out_file = File.new(symphony_location, 'w')
    out_file.puts(catalog_keys.join("\n"))
    out_file.close
  end
end
