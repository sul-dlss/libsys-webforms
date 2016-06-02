#######
#  Class for validating change_home_location
#######
class ChangeHomeLocation
  include FileParser
  include ActiveModel::Model
  attr_accessor :current_library
  attr_accessor :new_home_location
  attr_accessor :new_item_type
  attr_accessor :new_current_location
  attr_accessor :item_ids
  attr_accessor :email
  attr_accessor :comments
  validates :current_library, :new_home_location, :item_ids, presence: true
end
