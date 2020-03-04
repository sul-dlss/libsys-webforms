# app/model/shelf_selection_report.rb
class ShelfSelectionReport
  include ActiveModel::Model
  extend ActiveModel::Callbacks
  include ActiveModel::Validations
  attr_accessor :email, :lib, :loc_array, :cloc_diff, :format_array, :itype_array,
                :icat1_array, :lang, :min_yr, :max_yr, :min_circ, :max_circ,
                :shadowed, :digisent, :url, :mhlds, :has_dups, :multvol, :multcop,
                :no_boundw, :range_type, :call_alpha, :subj_name, :save_opt,
                :search_name, :call_lo, :call_hi, :user_id

  validate :home_location_present
  validate :call_lo_present
  validate :classic_call_lo_and_hi, if: :classic_range_type?
  validate :email_format

  def self.generic_options
    [["Doesn't matter", 0], ['INCLUDE only', 1], ['EXCLUDE', 2]]
  end

  def save_search?
    subj_name.present? && save_opt == 'save'
  end

  def update_search?
    subj_name.present? && save_opt == 'update'
  end

  private

  def lc_range_type?
    range_type == 'lc'
  end

  def classic_range_type?
    range_type == 'classic'
  end

  def other_range_type?
    range_type == 'other'
  end

  def classic_call_lo_and_hi
    lo_integer = call_lo.to_i
    hi_integer = call_hi.to_i
    message = 'Low and hi callnum range must be all digits, with lo lower than hi.'
    errors.add(:base, message) unless call_lo =~ /^[0-9]+$/ && call_hi =~ /^[0-9]+$/ && lo_integer < hi_integer
  end

  def home_location_present
    message = "Select a Home Location for #{lib}"
    errors.add(:base, message) unless loc_array.size > 1
  end

  def call_lo_present
    message = 'Provide a lower letter range for a LC call number'
    errors.add(:base, message) if lc_range_type? && call_lo.empty?
  end

  def email_format
    message = 'Email address is missing or not in a correct format'
    errors.add(:base, message) unless email.match(Rails.configuration.email_pattern)
  end
end
