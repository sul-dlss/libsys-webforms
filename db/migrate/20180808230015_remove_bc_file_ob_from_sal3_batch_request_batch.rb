class RemoveBcFileObFromSal3BatchRequestBatch < ActiveRecord::Migration
  def change
    remove_column :sal3_batch_requests_batch, :bc_file_obj, :string
  end
end
