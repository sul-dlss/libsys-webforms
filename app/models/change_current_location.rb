#######
#  Class for validating change_current_location
#######
class ChangeCurrentLocation
  include FileParser
  include ActiveModel::Model
  attr_accessor :current_library, :new_current_location, :item_ids, :email, :comments
  validates :current_library, :new_current_location, :item_ids, presence: true
end
