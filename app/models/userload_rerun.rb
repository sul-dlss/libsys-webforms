# class UserloadRerun < ActiveRecord::Base
class UserloadRerun
  include ActiveModel::Model
  attr_accessor :rerun_date
  validates :rerun_date, presence: true

  def write_date
    symphony_location = '/symphony/Dataload/UserloadRerun/rerun_file'
    out_file = File.new(symphony_location, 'w')
    out_file.puts(rerun_date.delete('-'))
    out_file.close
  end
end
