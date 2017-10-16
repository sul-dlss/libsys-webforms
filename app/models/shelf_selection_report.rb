# app/model/shelf_selection_report.rb
class ShelfSelectionReport
  include ActiveModel::Model
  extend ActiveModel::Callbacks
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  attr_accessor :email, :lib, :loc_array, :cloc_diff, :format_array, :itype_array,
                :icat1_array, :lang, :min_yr, :max_yr, :min_circ, :max_circ,
                :shadowed, :digisent, :url, :mhlds, :has_dups, :multvol, :multcop,
                :no_boundw, :range_type, :call_alpha, :subj_name, :save_opt,
                :search_name, :call_lo, :call_hi, :user_id

  validates :email, :loc_array, presence: true
  validates :loc_array, length: { minimum: 2, message: "can't be empty" }
  validates :call_lo, presence: true, if: :lc_range_type?
  validates :format_array, :itype_array, length: { minimum: 2, message: "can't be empty" }, if: :lc_range_type?
  validate :classic_call_lo_and_hi, if: :classic_range_type?
  validates :itype_array, length: { minimum: 2, message: "can't be empty" }, if: :classic_range_type?
  validates :format_array, length: { minimum: 2, message: "can't be empty" }, if: :other_range_type?
  validates :format_array, length: { minimum: 2, message: "can't be empty" }, if: :other_range_type?
  validates :subj_name, length: { maximum: 80, message: 'no more than 80 characters' }
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true

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
end
