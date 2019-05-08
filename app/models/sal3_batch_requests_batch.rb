###
#  Class to connect to the SAL3_BATCH_REQUESTS_BATCH table in Symphony
###
class Sal3BatchRequestsBatch < ApplicationRecord
  include FileParser

  validates :bc_file, presence: { message: 'You must upload a file of barcodes' }, on: :create
  validates :batch_numpullperday, numericality: { message: 'You must enter the number of items to pull per day' },
                                  on: :update
  validates :batch_startdate, presence: { message: 'You must enter a start date' },
                              on: %i(create update)
  validates :batch_needbydate, presence: { message: 'You must enter a completion date' },
                               on: %i(create update)
  validates :pseudo_id, presence: { message: 'You must provide a user ID for checkout' },
                        on: %i(create update)
  validate :batch_pullday_present

  has_many :sal3_batch_request_bcs, foreign_key: 'batch_id',
                                    class_name: Sal3BatchRequestBcs,
                                    dependent: :destroy,
                                    inverse_of: false

  before_validation :checkbox_zeros_to_nil
  after_create :set_num_bcs

  scope :pullmon, ->(monday) { where(batch_pullmon: monday) }
  scope :pulltues, ->(tuesday) { where(batch_pulltues: tuesday) }
  scope :pullwed, ->(wednesday) { where(batch_pullwed: wednesday) }
  scope :pullthurs, ->(thursday) { where(batch_pullthurs: thursday) }
  scope :pullfri, ->(friday) { where(batch_pullfri: friday) }
  scope :statusfilter, lambda { |code|
    code == 'ALL' ? code = status : code
    where(status: code)
  }

  self.table_name = 'sal3_batch_requests_batch'
  self.primary_key = 'batch_id'

  mount_uploader :bc_file, BarcodeFileUploader

  def self.locations
    {
      'Data Control' => 'DC',
      'Redwood City (Special Collections materials)' => 'RW',
      'Archive of Recorded Sound' => 'DA',
      'Redwood City (Archive of Recorded Sound materials)' => 'RA',
      'Earth Sciences' => 'DE',
      'Preservation - Book Repair' => 'BR',
      'Green Loading Dock' => 'DS',
      'Acquisitions' => 'AQ'
    }
  end

  def self.batch_media
    {
      book: %w[BOOK Book],
      archival: %w[ARCHIVAL Archival],
      flat: ['FLAT_FILES', 'Flat files (maps, drawings)'],
      film: ['FILM', 'Film (photographic, microfilm/fiche)'],
      magnetic: ['MAGNETIC', 'Magnetic (tape, data)'],
      newspaper: %w[NEWSPAPER Newspaper],
      optical: ['OPTICAL', 'Optical (CD, DVD)'],
      rolled: ['ROLLED_STOCK', 'Rolled stock (blueprints, drawings)'],
      shellac: ['SHELLAC', 'Shellac (78s, transcription disks)'],
      vinyl: ['VINYL', 'Vinyl (LPs, 45s)'],
      unknown: %w[UNKNOWN Unknown]
    }
  end

  def self.batch_container
    {
      'Manuscript Box' => 'MANUSCRIPT_BOX',
      'Record Storage Boxes' => 'RECORD_BOX',
      'Other Box Type' => 'OTHER_BOX',
      'Unknown' => 'UNKNOWN'
    }
  end

  def self.status
    %w[NEW APPROVED SUSPENDED REJECTED]
  end

  def self.status_filter
    %w[ALL NEW APPROVED SUSPENDED REJECTED DONE]
  end

  def self.priority
    %w[1 2 3]
  end

  def uploader
    BarcodeFileUploader.new(self, 'bc_file')
  end

  def set_num_bcs
    file_obj = bc_file.current_path
    barcodes = IO.read(file_obj).split("\n").uniq.length
    update_attributes(num_bcs: barcodes)
  end

  private

  def checkbox_zeros_to_nil
    self.batch_pullmon = nil if batch_pullmon.to_i.zero?
    self.batch_pulltues = nil if batch_pulltues.to_i.zero?
    self.batch_pullwed = nil if batch_pullwed.to_i.zero?
    self.batch_pullthurs = nil if batch_pullthurs.to_i.zero?
    self.batch_pullfri = nil if batch_pullfri.to_i.zero?
  end

  def batch_pullday_present
    a_pull_day_present? ? nil : errors.add(:base, 'Please pick at least one day for items to be delivered.')
  end

  def a_pull_day_present?
    batch_pullmon.present? || \
      batch_pulltues.present? || \
      batch_pullwed.present? || \
      batch_pullthurs.present? || \
      batch_pullfri.present?
  end
end
