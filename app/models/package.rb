###
#  Class to connect to the VND_PACKAGES table
###
class Package < ApplicationRecord
  self.table_name = 'vnd_packages'
  self.primary_key = 'record_id'
  # sets sequence name because it doesn't follow the Oracle default sequence
  # name pattern: #{table_name}_seq
  self.sequence_name = 'vnd_packages_id_seq'

  attr_accessor :url_substring, :link_text, :provider_name, :collection_name, :access_type, :no_ftp_search

  validates :record_id, uniqueness: true
  validates :package_id, :package_name, :vendor_name, :data_pickup_type, :package_status, presence: true
  validates :package_id, format: { with: /\A[a-z]{2}\z/, message: 'only 2-character alpha code allowed.' },
                         uniqueness: true
  validate :check_if_package_id_changed, on: :update
  validate :needs_afs_path, on: %i(create update)
  validate :needs_ftp_info, on: %i(create update)
  validate :needs_put_file_loc, on: %i(create update)
  validate :check_match_opts, on: %i(create update)

  before_create :set_time_stamps
  before_save :set_time_stamps

  MATCH_OPTS = {
    '020' => '020 (subfield a,z) to Symphony 020 or 776',
    '776_isbn' => '776 (subfield z) to Symphony 020 or 776',
    '022' => '022 (subfield a,y,z) to Symphony 022 or 776',
    '776_issn' => '776 (subfield x) to Symphony 022 or 776',
    '024_isbn' => '024 (subfield a,z) to Symphony 020 or 776'
  }.freeze

  PROC_TYPE = {
    'newonly' => 'New only',
    'newmerge' => 'Merge or new',
    'mergeonly' => 'Merge only',
    'ckeymerge' => 'CKEY-URL merge'
  }.freeze

  MARC_ENCDG_LVL = {
    'ASIS' => 'Do not replace',
    ' ' => '<space character> Full level',
    '1' => '1 - Full level, material not examined',
    '2' => '2 - Less-than-full level, material not examined',
    '3' => '3 - Abbreviated level',
    '4' => '4 - Core level',
    '5' => '5 - Partial (preliminary) level',
    '7' => '7 - Minimal level',
    '8' => '8 - Prepublication level',
    'u' => 'u - Unknown',
    'z' => 'z - Not applicable'
  }.freeze

  private

  def set_time_stamps
    self.date_entered = I18n.l(Time.now.getlocal, format: :oracle) if new_record?
    self.date_modified = I18n.l(Time.now.getlocal, format: :oracle)
  end

  def check_if_package_id_changed
    errors.add(:base, 'Package ID is marked as readonly.') if package_id_changed?
  end

  def needs_afs_path
    errors.add(:base, 'AFS directory path cannot be empty.') if afs_path.blank? && data_pickup_type.include?('AFS')
  end

  def use_ftp?
    data_pickup_type.include?('FTP')
  end

  def needs_ftp_info
    errors.add(:base, 'FTP server cannot be empty.') if ftp_server.blank? && use_ftp?
    errors.add(:base, 'FTP user cannot be empty.') if ftp_user.blank? && use_ftp?
    errors.add(:base, 'FTP password cannot be empty.') if ftp_password.blank? && use_ftp?
    errors.add(:base, 'FTP remote directory cannot be empty.') if ftp_directory.blank? && use_ftp?
  end

  def use_ftp_to_afs?
    data_pickup_type.include?('AFS') && data_pickup_type.include?('FTP')
  end

  def needs_put_file_loc
    errors.add(:base, 'FTP to AFS download directory path cannot be empty.') \
      if put_file_loc.blank? && use_ftp_to_afs?
  end

  def needs_match_options?
    (proc_type.include?('newmerge') || proc_type.include?('mergeonly')) if proc_type.present?
  end

  def check_match_opts
    errors.add(:base, "#{Package.human_attribute_name('match_opts')} cannot be empty.") \
      if match_opts.blank? && needs_match_options?
  end
end
