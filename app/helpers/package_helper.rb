#######
#  Module for Package
#######
module PackageHelper
  # get user friendly labels for package columns
  def package_label(val)
    Package::COLUMNS.fetch(val, '')
  end

  # get user friendly labels for match_opts
  def match_options(opt)
    Package::MATCH_OPTS.fetch(opt, '')
  end

  # get user friendly labels for proc_type
  def processing_type(type)
    Package::PROC_TYPE.fetch(type, '')
  end

  def marc_encoding_lvl
    Package::MARC_ENCDG_LVL
  end

  def package_info
    %w(package_status package_id package_name vendor_name package_url)
  end

  def pickup_info
    %w(data_pickup_type afs_path put_file_loc ftp_server ftp_user ftp_password ftp_directory ftp_file_prefix)
  end

  def processing_rules
    %w(proc_type match_opts)
  end

  def processing_info
    %w(url_field vendor_id_read access_note access_urls_plats update_040
       vnd_catcode export_note export_auth date_cat holding_code encoding_level
       junktag_file preprocess_modify_script preprocess_split_script
       preprocess_put_script)
  end

  def package_other
    %w(rpt_mail comments)
  end
end
