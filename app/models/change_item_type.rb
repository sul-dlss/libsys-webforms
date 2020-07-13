###
#  Class primarily for validation on the change_item_type form
###
class ChangeItemType
  include FileParser
  include ActiveModel::Model
  attr_accessor :current_library, :new_item_type, :item_ids, :email, :comments, :load_date, :user_name, :action,
                :priority, :export_yn, :new_lib, :new_homeloc, :new_curloc, :check_bc_first

  validates :current_library, :new_item_type, :item_ids, presence: true
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true
end
