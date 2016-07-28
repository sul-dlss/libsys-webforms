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
  validates :barcodes, presence: true, if: :barcode_range_type?
  validates :lib_array, length: { minimum: 2, message: "can't be empty" }, if: :not_barcode_range_type?
  validate :lc_call_lo, if: :lc_range_type?
  validate :lc_call_hi, if: :lc_range_type?
  validate :classic_call_lo_and_hi, if: :classic_range_type?
  validate :classic_call_alpha, if: :classic_range_type?

  private

  def barcode_range_type?
    range_type == 'barcodes'
  end

  def lc_range_type?
    range_type == 'lc'
  end

  def classic_range_type?
    range_type == 'classic'
  end

  def not_barcode_range_type?
    range_type != 'barcodes'
  end

  def lc_call_lo
    if call_lo !~ /^[A-Z]{1,2}$|^[A-Z]\#$/
      errors.add(:base, 'Low callnum range must be at most two uppercase letters or one plus #')
    end
  end

  # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
  def lc_call_hi
    if call_lo.length == 1
      callnum_range = call_lo..'Z'
      message = 'Hi callnum range must be empty or a later letter.'
      errors.add(:base, message) unless call_hi.blank? || callnum_range.include?(call_hi)
    elsif call_lo =~ /^[A-Z]{2}$/
      first_letter = call_lo[0]
      message = 'Hi callnum range must be empty or two letters with the same first letter as low range'
      errors.add(:base, message) unless call_hi.blank? || call_hi =~ /^[#{Regexp.quote(first_letter)}][A-Z]$/
    elsif call_lo =~ /^[A-Z]\#$/
      errors.add(:base, 'Hi callnum range must be empty.') unless call_hi.blank?
    end
  end
  # rubocop:enable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity

  def classic_call_lo_and_hi
    lo_integer = call_lo.to_i
    hi_integer = call_hi.to_i
    message = 'Low and hi callnum range must be all digits, with lo lower than hi.'
    errors.add(:base, message) unless call_lo =~ /^[0-9]+$/ && call_hi =~ /^[0-9]+$/ && lo_integer < hi_integer
  end

  # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
  def classic_call_alpha
    message = 'Alpha callnum range must be empty or one to two letters.'
    errors.add(:base, message) unless call_alpha.blank? || call_alpha =~ /^[A-Z]{1,2}$/
    if call_alpha.blank?
      message = 'Low and hi callnum ranges must be one to three digits.'
      errors.add(:base, message) unless call_lo =~ /^[0-9]{1,3}$/ && call_hi =~ /^[0-9]{1,3}$/
    else
      message = 'Low and hi callnum ranges must be one to four digits.'
      errors.add(:base, message) unless call_lo =~ /^[0-9]{1,4}$/ && call_hi =~ /^[0-9]{1,4}$/
    end
  end
  # rubocop:enable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
end
