# app/model/shelf_selection_report.rb
class ShelfSelectionReport
  include ActiveModel::Model
  attr_accessor :email, :lib, :loc_array, :cloc_diff, :fmt_array,
                :itype_array, :icat1_array, :lang, :min_yr, :max_yr,
                :min_circ, :max_circ, :shadowed, :digisent, :url,
                :mhlds, :has_dups, :multvol, :multcop, :no_boundw,
                :range_type, :lc_call_lo, :lc_call_hi, :classic_call_lo,
                :classic_call_hi, :other_call_hi, :call_alpha, :subj_name,
                :save_opt

  def self.generic_options
    [["Doesn't matter", 0], ['INCLUDE only', 1], ['EXCLUDE', 2]]
  end
end
