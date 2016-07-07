class CreateUniLibsLocs < ActiveRecord::Migration
  def change
    create_table :uni_libs_locs do |t|
      t.string :library
      t.string :home_loc
    end
  end
end
