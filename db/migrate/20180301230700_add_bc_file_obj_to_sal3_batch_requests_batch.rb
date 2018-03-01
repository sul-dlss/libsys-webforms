class AddBcFileObjToSal3BatchRequestsBatch < ActiveRecord::Migration
  def change
    add_column :sal3_batch_requests_batch, :bc_file_obj, :string
  end
end
