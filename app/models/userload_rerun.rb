# class UserloadRerun < ActiveRecord::Base
class UserloadRerun
  include ActiveModel::Model
  attr_accessor :rerun_date

  validates :rerun_date, presence: true

  def write_date
    File.open(Settings.symphony_userload_rerun, 'a') { |f| f.write(rerun_date.delete('-')) }
  end
end
