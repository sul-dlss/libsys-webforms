class ChangeUniUpdatesLoadDate < ActiveRecord::Migration[5.0]
  def change
    change_column :uni_updates, :load_date, :date
  end
end
