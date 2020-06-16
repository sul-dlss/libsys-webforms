###
# Class to model digital bookplate data from symp_dor.txt file
###
class DigitalBookplate
  include ActiveModel::Model
  attr_reader :fund, :druid, :title

  validates :fund, :druid, :title, presence: true

  def self.parse_data
    digital_bookplates = []
    TSV.parse_file(Settings.symphony_config_digital_bookplates).without_header.map do |row|
      digital_bookplates.push(druid_hash(row))
    end
    digital_bookplates
  end

  def self.druid_hash(row)
    { fund: row_fund(row[0]), druid: row[1].delete_prefix('druid:'), title: row[3] }
  end

  def self.row_fund(data)
    /[a-z]{2}[0-9]{3}[a-z]{2}[0-9]{4}/.match?(data) ? 'ZZ_NO_FUND' : data
  end
end
