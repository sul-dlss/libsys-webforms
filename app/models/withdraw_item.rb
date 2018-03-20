#######
#  Class for validating withdraw_items
#######
class WithdrawItem
  include FileParser
  include ActiveModel::Model
  attr_accessor :current_library, :item_ids, :email, :comments, :load_date,
                :user_name, :action, :priority, :export_yn, :check_bc_first
  attr_accessor :params
  attr_accessor :uniques
  validates :current_library, :item_ids, presence: true
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true

  def self.batch_for_transfer_item(params, uniques)
    UniUpdatesBatch.create_transfer_item_batch(params, uniques.count)
  end
end
