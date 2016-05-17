#######
#  Class for validating change_current_location
#######
class ChangeCurrentLocation
  include ActiveModel::Model
  attr_accessor :current_library, :new_current_location, :item_ids, :email, :comments
  validates :current_library, :new_current_location, :item_ids, presence: true

  def parse_uploaded_file
    item_ids.read.split("\n")
  end
end
