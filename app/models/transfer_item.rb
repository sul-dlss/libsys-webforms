#######
#  Class for validating transfer_items
#######
class TransferItem
  include FileParser
  include ActiveModel::Model
  attr_accessor :current_library, :new_library, :new_homeloc, :new_curloc, :new_item_type,
                :item_ids, :email, :comments, :load_date, :user_name, :action,
                :priority, :export_yn, :check_bc_first
  validates :current_library, :new_library, :new_homeloc, :item_ids,
            presence: true
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true
end
