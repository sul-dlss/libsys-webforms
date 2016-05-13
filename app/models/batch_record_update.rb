###
#  Class for CanCan Authorization to view Uni Update forms
#    we also get form validation and barcode file parsing
###
class BatchRecordUpdate
  include ActiveModel::Model
  attr_accessor :current_library, :new_item_type, :item_ids, :email, :comments
  validates :current_library, :new_item_type, :item_ids, presence: true

  def parse_uploaded_file
    item_ids.read.split("\n")
  end
end
