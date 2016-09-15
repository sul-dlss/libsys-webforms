###
#  Class to connect to the UNI_UPDATES_BATCH table in Symphony
###
class UniUpdatesBatch < ActiveRecord::Base
  self.table_name = 'uni_updates_batch'
  self.primary_key = 'batch_id'
  has_many :uni_updates, foreign_key: 'batch_id', class_name: UniUpdates, dependent: :destroy

  # rubocop:disable Metrics/AbcSize
  def self.create_item_type_batch(params, total_bcs)
    create(batch_date: params[:change_item_type][:batch_date],
           user_name: params[:change_item_type][:user_name],
           user_email: params[:change_item_type][:email],
           orig_lib: params[:change_item_type][:current_library],
           action: params[:change_item_type][:action],
           priority: params[:change_item_type][:priority],
           export_yn: params[:change_item_type][:export_yn],
           new_itype: params[:change_item_type][:new_item_type],
           check_bc_first: params[:change_item_type][:check_bc_first],
           comments: params[:change_item_type][:comments],
           pending: 'Y',
           total_bcs: total_bcs)
  end

  def self.create_withdraw_item_batch(params, total_bcs)
    create(batch_date: params[:withdraw_item][:batch_date],
           user_name: params[:withdraw_item][:user_name],
           user_email: params[:withdraw_item][:email],
           orig_lib: params[:withdraw_item][:current_library],
           action: params[:withdraw_item][:action],
           priority: params[:withdraw_item][:priority],
           export_yn: params[:withdraw_item][:export_yn],
           new_itype: params[:withdraw_item][:new_item_type],
           check_bc_first: params[:withdraw_item][:check_bc_first],
           comments: params[:withdraw_item][:comments],
           pending: 'Y',
           total_bcs: total_bcs)
  end

  def self.create_transfer_item_batch(params, total_bcs)
    create(batch_date: params[:transfer_item][:batch_date],
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

  def self.create_current_location_batch(params, total_bcs)
    create(batch_date: params[:change_current_location][:batch_date],
           user_name: params[:change_current_location][:user_name],
           user_email: params[:change_current_location][:email],
           orig_lib: params[:change_current_location][:current_library],
           action: params[:change_current_location][:action],
           priority: params[:change_current_location][:priority],
           export_yn: params[:change_current_location][:export_yn],
           new_curloc: params[:change_current_location][:new_current_location],
           check_bc_first: params[:change_current_location][:check_bc_first],
           comments: params[:change_current_location][:comments],
           pending: 'Y',
           total_bcs: total_bcs)
  end

  def self.create_home_location_batch(params, total_bcs)
    create(batch_date: params[:change_home_location][:batch_date],
           user_name: params[:change_home_location][:user_name],
           user_email: params[:change_home_location][:user_name],
           orig_lib: params[:change_home_location][:current_library],
           new_homeloc: params[:change_home_location][:new_home_location],
           new_itype: params[:change_home_location][:new_item_type],
           new_curloc: params[:change_home_location][:new_current_location],
           action: params[:change_home_location][:action],
           priority: params[:change_home_location][:priority],
           export_yn: params[:change_home_location][:export_yn],
           check_bc_first: params[:change_home_location][:check_bc_first],
           comments: params[:change_home_location][:comments],
           pending: 'Y',
           total_bcs: total_bcs)
  end
  # rubocop:enable Metrics/AbcSize
end
