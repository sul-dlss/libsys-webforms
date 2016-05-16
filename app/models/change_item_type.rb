###
#  Class primarily for validation on the change_item_type form
###
class ChangeItemType
  include ActiveModel::Model
  attr_accessor :current_library, :new_item_type, :item_ids, :email, :comments
  validates :current_library, :new_item_type, :item_ids, presence: true

  def parse_uploaded_file
    item_ids.read.split("\n")
  end
end
