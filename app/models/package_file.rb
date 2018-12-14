###
#  Class to connect to the VND_FILES_GEN table
###
class PackageFile < ActiveRecord::Base
  self.table_name = 'vnd_files_gen'

  def self.files_to_load
    select('p.package_id, p.vendor_name, f.new_file_name')
      .from('vnd_packages p, vnd_files_gen f')
      .where('p.package_id = f.package_id')
      .where('p.package_status = f.package_status')
      .where('f.status_load in (\'REQUEST\', \'REQUEST_SPLIT\')')
      .order('f.seq_number DESC')
  end

  def self.num_files_to_load
    select('f.new_file_name')
      .from('vnd_packages p, vnd_files_gen f')
      .where('p.package_id = f.package_id')
      .where('p.package_status = f.package_status')
      .where('f.status_load = \'REQUEST\'')
      .order('f.seq_number DESC').count
  end

  private

  def timestamp_attributes_for_create
    super << :date_created
  end
end
