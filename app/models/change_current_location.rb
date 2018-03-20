#######
#  Class for validating change_current_location
#######
class ChangeCurrentLocation
  include FileParser
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks
  attr_accessor :current_library
  attr_accessor :new_current_location
  attr_accessor :new_item_type
  attr_accessor :item_ids
  attr_accessor :email
  attr_accessor :comments
  attr_accessor :load_date
  attr_accessor :user_name
  attr_accessor :action
  attr_accessor :priority
  attr_accessor :export_yn
  attr_accessor :check_bc_first
  attr_accessor :params
  attr_accessor :uniques
  validates :current_library, :new_current_location, :item_ids, presence: true
  validates :email, format: { with: Rails.configuration.email_pattern }, allow_blank: true

  def self.batch_for_transfer_item(params, uniques)
    UniUpdatesBatch.create_transfer_item_batch(params, uniques.count)
  end
end
