class CreateShelfSelSearch < ActiveRecord::Migration[5.0]
  def change
    create_table :shelf_sel_searches do |t|
      t.string :user_name
      t.string :search_name
      t.string :call_range
      t.string :lib
      t.string :locs
      t.string :fmts
      t.string :itypes
      t.string :min_yr
      t.string :max_yr
      t.string :min_circ
      t.string :max_circ
      t.integer :na_i_e_shadow
      t.integer :na_i_e_url
      t.integer :na_i_e_dups
      t.integer :na_i_e_boundw
      t.integer :na_i_e_cloc_diff
      t.integer :na_i_e_digisent
      t.integer :na_i_e_mhlds
      t.integer :na_i_e_multvol
      t.integer :na_i_e_multcop
      t.string :lang
      t.string :icat1s
    end
  end
end
