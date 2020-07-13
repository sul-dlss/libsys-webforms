#######
#  Class for validating change_current_location
#######
class ChangeCurrentLocation
  include FileParser
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks
  attr_accessor :current_library, :new_current_location, :new_item_type, :item_ids, :email, :comments, :load_date,
                :user_name, :action, :priority, :export_yn, :check_bc_first

  validates :current_library, :new_current_location, :item_ids, presence: true
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true
end
