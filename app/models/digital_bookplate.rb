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
      hash = { fund: row[0], druid: row[1].gsub(/^druid:/, ''), title: row[3] }
      hash[:fund] = 'ZZ_NO_FUND' if hash[:fund] =~ /[a-z]{2}[0-9]{3}[a-z]{2}[0-9]{4}/
      digital_bookplates.push(hash)
    end
    digital_bookplates
  end
end
