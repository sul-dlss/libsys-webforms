###
#  Class to connect to the SAL3_BATCH_REQUESTS_BATCH table in Symphony
###
class Sal3BatchRequestsBatch < ActiveRecord::Base
  include FileParser
  attr_accessor :bc_file

  validates :bc_file, presence: true
  has_many :sal3_batch_request_bcs, foreign_key: 'batch_id', class_name: Sal3BatchRequestBcs, dependent: :destroy

  self.table_name = 'sal3_batch_requests_batch'
  self.primary_key = 'batch_id'

  def self.locations
    {
      'Data Control' => 'DC',
      'Special Collections - Redwood City' => 'RW',
      'Archive of Recorded Sound' => 'AB',
      'Earth Sciences' => 'EB',
      'Preservation - Book Repair' => 'BP',
      'Green' => 'GB'
    }
  end

  def self.batch_media
    {
      book: 'Book', archival: 'Archival', flat: 'Flat files (maps, drawings)',
      film: 'Film (photographic, microfilm/fiche)', magnetic: 'Magnetic (tape, data)',
      newspaper: 'Newspaper', optical: 'Optical (CD, DVD)',
      rolled: 'Rolled stock (blueprints, drawings)', shellac: 'Shellac (78s, transcription disks)',
      vinyl: 'Vinyl (LPs, 45s)', unknown: 'Unknown'
    }
  end

  def self.batch_container
    ['Manuscript Box', 'Record Storage Boxes', 'Other Box Type', 'Unknown']
  end
end
