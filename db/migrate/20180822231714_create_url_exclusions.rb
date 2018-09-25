class CreateUrlExclusions < ActiveRecord::Migration
  def change
    create_table :url_exclusions do |t|
      t.string :url_substring

      t.timestamps null: false
    end
  end
end
