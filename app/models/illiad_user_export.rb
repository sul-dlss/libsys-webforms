# class IlliadUserExport
class IlliadUserExport
  include ActiveModel::Model
  attr_accessor :sunet_ids

  validates :sunet_ids, presence: true

  def write_ids
    File.open(Settings.symphony_illiad_user_export, 'a') { |f| f.write(sunet_ids.delete('-')) }
  end
end
