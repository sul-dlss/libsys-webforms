###
#  Class to connect to the DIGITAL_BOOKPLATES_BATCH table
###
class DigitalBookplatesBatch < ApplicationRecord
  self.table_name = 'digital_bookplates_batches'
  self.primary_key = 'batch_id'
  attr_accessor :file_obj

  validates :file_obj, :druid, presence: true

  validate :num_ckeys

  after_create :set_ckey_count, :set_filename

  private

  def parse_ckey_file
    File.read(file_obj.path).split("\n").uniq.length
  end

  def num_ckeys
    if file_obj.nil?
      errors.add(:ckey_file, 'is missing!')
    else
      ckeys = parse_ckey_file
      errors.add(:ckey_count, 'cannot be more than 10,000.') if ckeys >= 10_000
    end
  end

  def set_ckey_count
    ckeys = parse_ckey_file
    update(ckey_count: ckeys)
  end

  def set_filename
    filename = file_obj.original_filename
    filename.gsub!(/\s+/, '_') if /\s+/.match?(filename)
    update(ckey_file: filename)
  end
end
