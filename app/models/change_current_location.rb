#######
#  Class for validating change_current_location
#######
class ChangeCurrentLocation
  include FileParser
  include ActiveModel::Model
  attr_accessor :current_library
  attr_accessor :new_current_location
  attr_accessor :item_ids
  attr_accessor :email
  attr_accessor :comments
  attr_accessor :batch_date
  attr_accessor :user_name
  attr_accessor :action
  attr_accessor :priority
  attr_accessor :export_yn
  attr_accessor :check_bc_first
  validates :current_library, :new_current_location, :item_ids, presence: true
end
