class ChangeUniUpdatesLoadDate < ActiveRecord::Migration
  def change
    change_column :uni_updates, :load_date, :date
  end
end
