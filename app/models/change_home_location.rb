#######
#  Class for validating change_home_location
#######
class ChangeHomeLocation
  include FileParser
  include ActiveModel::Model
  attr_accessor :current_library, :new_home_location, :new_item_type, :new_current_location, :item_ids, :email,
                :comments, :load_date, :user_name, :action, :priority, :export_yn, :check_bc_first

  validates :current_library, :new_home_location, :item_ids, presence: true
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true
end
