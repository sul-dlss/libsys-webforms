class AddPullDateToSal3BatchRequestsBcs < ActiveRecord::Migration[5.0]
  def change
    add_column :sal3_batch_requests_bcs, :pull_date, :datetime
  end
end
