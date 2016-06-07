#######
#  Class for validating withdraw_items
#######
class WithdrawItem
  include FileParser
  include ActiveModel::Model
  attr_accessor :current_library, :item_ids, :email, :comments, :batch_date,
                :user_name, :action, :priority, :export_yn, :check_bc_first
  validates :current_library, :item_ids, presence: true
end
