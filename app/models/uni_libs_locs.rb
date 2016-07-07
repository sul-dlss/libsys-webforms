# app/models/uni_libs_locs.rb
class UniLibsLocs < ActiveRecord::Base
  self.table_name = 'uni_libs_locs'

  def self.libraries
    UniLibsLocs.select(:library).distinct.where.not(library: nil).order(:library).pluck(:library)
  end
end
