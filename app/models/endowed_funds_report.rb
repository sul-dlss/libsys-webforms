###
# Class to model EXPENDITURES oracle table
###
class EndowedFundsReport
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :fund, :fund_begin, :fund_select, :report_format, :date_request,
                :date_ran, :date_type, :fy_start, :fy_end, :cal_start, :cal_end,
                :pd_start, :pd_end, :email

  validates :fund, presence: true, if: 'fund_begin.nil?'
  validates :fund_begin, presence: true, if: 'fund.nil?'

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

  def write_keys(catalog_keys)
    symphony_file = "endow#{Time.zone.now.strftime('%y%m%d%H%M%S%L%1N')}"
    symphony_location = "/symphony/Dataload/EndowRpt/#{symphony_file}"
    FileUtils.chdir('/symphony/Dataload/EndowRpt/')
    FileUtils.touch(symphony_file)
    out_file = File.open(symphony_location, 'w')
    out_file.puts(catalog_keys.join("\n"))
    out_file.close
  end
end
