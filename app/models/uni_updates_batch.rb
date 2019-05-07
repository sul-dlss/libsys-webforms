###
#  Class to connect to the UNI_UPDATES_BATCH table in Symphony
###
class UniUpdatesBatch < ActiveRecord::Base
  self.table_name = 'uni_updates_batch'
  self.primary_key = 'batch_id'
  has_many :uni_updates, foreign_key: 'batch_id',
                         class_name: UniUpdates,
                         dependent: :destroy,
                         inverse_of: :uni_updates_batch

  def self.create_transfer_item_batch(params, total_bcs)
    create(batch_date: params[:transfer_item][:load_date],
           user_name: params[:transfer_item][:user_name],
           user_email: params[:transfer_item][:email],
           orig_lib: params[:transfer_item][:current_library],
           new_lib: params[:transfer_item][:new_library],
           new_homeloc: params[:transfer_item][:new_homeloc],
           new_curloc: params[:transfer_item][:new_curloc],
           action: params[:transfer_item][:action],
           priority: params[:transfer_item][:priority],
           export_yn: params[:transfer_item][:export_yn],
           new_itype: params[:transfer_item][:new_item_type],
           check_bc_first: params[:transfer_item][:check_bc_first],
           comments: params[:transfer_item][:comments],
           pending: 'Y',
           total_bcs: total_bcs)
  end
end
