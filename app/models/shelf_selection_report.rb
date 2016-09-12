# app/model/shelf_selection_report.rb
class ShelfSelectionReport
  include ActiveModel::Model
  attr_accessor :email, :lib, :loc_array, :cloc_diff, :fmt_array,
                :itype_array, :icat1_array, :lang, :min_yr, :max_yr,
                :min_circ, :max_circ, :shadowed, :digisent, :url,
                :mhlds, :has_dups, :multvol, :multcop, :no_boundw,
                :range_type, :call_alpha, :subj_name,
                :save_opt, :search_name, :call_lo, :call_hi
  validates :email, presence: true

  def self.generic_options
    [["Doesn't matter", 0], ['INCLUDE only', 1], ['EXCLUDE', 2]]
  end
end
