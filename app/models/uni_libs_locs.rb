# app/models/uni_libs_locs.rb
class UniLibsLocs < ApplicationRecord
  self.table_name = 'uni_libs_locs'

  def self.libraries
    select(:library).distinct.where.not(library: nil).order(:library).pluck(:library).sort
  end

  def self.home_locations_from(libraries)
    select(:home_loc).distinct.where(library: libraries).order(:home_loc).pluck(:home_loc)
  end
end
