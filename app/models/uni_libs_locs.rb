# app/models/uni_libs_locs.rb
class UniLibsLocs < ActiveRecord::Base
  self.table_name = 'uni_libs_locs'

  def self.libraries
    select(:library).distinct.where.not(library: nil).order(:library).pluck(:library)
  end

  def self.home_locations_from(library)
    select(:home_loc).distinct.where(library: library).order(:home_loc).pluck(:home_loc)
  end
end
