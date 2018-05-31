class AddPullDateToSal3BatchRequestsBcs < ActiveRecord::Migration
  def change
    add_column :sal3_batch_requests_bcs, :pull_date, :datetime
  end
end
