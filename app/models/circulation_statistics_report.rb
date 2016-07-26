# app/models/circulation_statistics_report.rb
class CirculationStatisticsReport
  include ActiveModel::Model
  attr_accessor :email, :lib_array, :source, :range_type, :call_lo, :call_hi,
                :call_alpha, :barcodes, :format_array, :exclude_inactive, :min_yr,
                :max_yr, :exclude_bad_yr, :include_inhouse, :no_qtrly, :ckey_url,
                :tag_field, :tag_field2, :tags_url, :link_type, :col_header1,
                :col_header2, :col_header3, :col_header4, :col_header5,
                :blank_col_array, :lib_loc_array
  validates :email, :lib_array, presence: true
  validate :call_lo_or_call_hi

  private

  def call_lo_or_call_hi
    errors.add(:base, 'Specify a low or high call number range.') if call_lo.blank? && call_hi.blank?
  end
end
