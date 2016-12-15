###
#  Class primarily for validation on the change_item_type form
###
class ChangeItemType
  include FileParser
  include ActiveModel::Model
  attr_accessor :current_library
  attr_accessor :new_item_type
  attr_accessor :item_ids
  attr_accessor :email
  attr_accessor :comments
  attr_accessor :load_date
  attr_accessor :user_name
  attr_accessor :action
  attr_accessor :priority
  attr_accessor :export_yn
  attr_accessor :new_lib
  attr_accessor :new_homeloc
  attr_accessor :new_curloc
  attr_accessor :check_bc_first

  validates :current_library, :new_item_type, :item_ids, presence: true
end
