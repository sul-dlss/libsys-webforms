# app/models/circulation_statistics_report.rb
class CirculationStatisticsReport
  include ActiveModel::Model
  extend ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  attr_accessor :email, :lib_array, :source, :range_type, :call_lo, :call_hi,
                :call_alpha, :barcodes, :format_array, :exclude_inactive, :min_yr,
                :max_yr, :exclude_bad_yr, :include_inhouse, :no_qtrly, :ckey_url,
                :tag_field, :tag_field2, :tag_field3, :tag_field4, :tags_url,
                :link_type, :col_header1, :col_header2, :col_header3, :col_header4,
                :col_header5, :blank_col_array, :lib_loc_array, :user_id

  validates :lib_array, length: { minimum: 2, message: 'Select at least one library' }, unless: :barcode_range_type?
  validates :barcodes, presence: { is: true, message: 'Upload a file of barcodes' }, if: :barcode_range_type?
  validates :email, format: { with: Rails.configuration.email_pattern,
                              message: 'Email address is missing or not in a correct format' }
  validates :min_yr, length: { is: 4, message: 'Year length must be four digits' },
                     numericality: { only_integer: true },
                     allow_blank: true
  validates :max_yr, length: { is: 4, message: 'Year length must be four digits' },
                     numericality: { only_integer: true },
                     allow_blank: true
  validates :tag_field, :tag_field2, :tag_field3, :tag_field4, length: { is: 3,
                                                                         message: 'Bibfield number must be 3 digits' },
                                                               numericality: { only_integer: true,
                                                                               message:
                                                                                 'Bibfield must be a 3-digit number' },
                                                               exclusion: { in: %w[008],
                                                                            message: 'Bibfield cannot be 008' },
                                                               allow_blank: true
  validate :lc_call_lo, if: :lc_range_type?
  validate :lc_call_hi, if: :lc_range_type?
  validate :classic_call_lo_and_hi, if: :classic_range_type?
  validate :classic_call_alpha, if: :classic_range_type?

  before_validation :upcase_call_numbers

  private

  def upcase_call_numbers
    call_lo&.upcase!
    call_hi&.upcase!
    call_alpha&.upcase!
  end

  def barcode_range_type?
    range_type == 'barcodes'
  end

  def lc_range_type?
    range_type == 'lc'
  end

  def classic_range_type?
    range_type == 'classic'
  end

  def call_regex
    /^[A-Z]{1,2}$|^[A-Z]\#$/
  end

  def lc_call_lo
    message = 'Low callnum range must be at most two uppercase letters or one plus #'
    errors.add(:base, message) unless call_lo&.match?(call_regex)
  end

  # rubocop:disable Metrics/AbcSize
  def lc_call_hi
    if call_lo.length == 1
      callnum_range = call_lo..'Z'
      message = 'Hi callnum range must be empty or a higher single letter.'
      errors.add(:base, message) unless call_hi.blank? || callnum_range.include?(call_hi)
    elsif /^[A-Z]\#$/.match?(call_lo)
      call_hi.present? && errors.add(:base, 'Hi callnum range must be empty.')
    elsif /^[A-Z]{2}$/.match?(call_lo)
      validate_double_lc_call
    end
  end
  # rubocop:enable Metrics/AbcSize

  def validate_double_lc_call
    message = 'Hi callnum must be blank or contain two letters and be higher, and in the same range.'
    # The first letter of call_lo and call_hi has to be the same
    # The second letter of call_hi has to be higher than the second letter of call_lo
    callnum_range = call_lo[1].next..'Z'
    errors.add(:base, message) unless call_hi.blank? || (call_lo[0] == call_hi[0] && callnum_range.include?(call_hi[1]))
  end

  def classic_call_lo_and_hi
    lo_integer = call_lo.to_i
    hi_integer = call_hi.to_i
    message = 'Low and hi callnum range must be all digits, with lo lower than hi.'
    errors.add(:base, message) unless call_lo =~ /^[0-9]+$/ && call_hi =~ /^[0-9]+$/ && lo_integer <= hi_integer
  end

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
end
