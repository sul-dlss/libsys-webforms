class CreateUniLibsLocs < ActiveRecord::Migration[5.0]
  def change
    create_table :uni_libs_locs do |t|
      t.string :library
      t.string :home_loc
    end
  end
end
