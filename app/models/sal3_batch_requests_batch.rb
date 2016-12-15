###
#  Class to connect to the SAL3_BATCH_REQUESTS_BATCH table in Symphony
###
class Sal3BatchRequestsBatch < ActiveRecord::Base
  include FileParser
  attr_accessor :bc_file

  validates :bc_file, presence: true, on: :create
  validates :batch_numpullperday, numericality: true, on: :update
  has_many :sal3_batch_request_bcs, foreign_key: 'batch_id', class_name: Sal3BatchRequestBcs, dependent: :destroy

  self.table_name = 'sal3_batch_requests_batch'
  self.primary_key = 'batch_id'

  def self.locations
    {
      'Data Control' => 'DC',
      'Special Collections - Redwood City' => 'RW',
      'Archive of Recorded Sound' => 'DA',
      'Archive of Recorded Sound - Redwood City' => 'RA',
      'Earth Sciences' => 'DE',
      'Preservation - Book Repair' => 'BR',
      'Green' => 'DS'
    }
  end

  def self.batch_media
    {
      book: %w(BOOK Book),
      archival: %w(ARCHIVAL Archival),
      flat: ['FLAT_FILES', 'Flat files (maps, drawings)'],
      film: ['FILM', 'Film (photographic, microfilm/fiche)'],
      magnetic: ['MAGNETIC', 'Magnetic (tape, data)'],
      newspaper: %w(NEWSPAPER Newspaper),
      optical: ['OPTICAL', 'Optical (CD, DVD)'],
      rolled: ['ROLLED_STOCK', 'Rolled stock (blueprints, drawings)'],
      shellac: ['SHELLAC', 'Shellac (78s, transcription disks)'],
      vinyl: ['VINYL', 'Vinyl (LPs, 45s)'],
      unknown: %w(UNKNOWN Unknown)
    }
  end

  def self.batch_container
    ['Manuscript Box', 'Record Storage Boxes', 'Other Box Type', 'Unknown']
  end

  def self.status
    %w(NEW APPROVED SUSPENDED REJECTED)
  end

  def self.priority
    %w(1 2 3)
  end
end
