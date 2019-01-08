FactoryBot.define do
  factory :package do |f|
    f.package_name 'Theatre in Video'
    f.vendor_name 'Alexander Street Press'
    f.record_id 1
    f.package_id 'tv'
    f.package_status 'Active'
    f.data_pickup_type 'AFS'
    f.afs_path 'TheatreVideo'
    f.ftp_server 'something'
    f.ftp_user 'something'
    f.ftp_password 'something'
    f.ftp_directory 'something'
    f.ftp_file_prefix 'something'
    f.ftp_list_type 'something'
    f.package_url 'something'
    f.date_entered Time.zone.today
    f.holding_code 'something'
    f.comments ''
    f.date_modified Time.zone.today
    f.put_file_loc ''
    f.afs_search_string ''
    f.url_field ''
    f.vendor_id_read ''
    f.vendor_id_write ''
    f.access_note ''
    f.export_note ''
    f.junktag_file ''
    f.encoding_level 'ASIS'
    f.vnd_catcode ''
    f.match_opts '776_isbn'
    f.proc_type 'newmerge'
    f.update_040 ''
    f.rpt_mail ''
    f.access_urls_plats ''
    f.date_cat ''
    f.export_auth ''
    f.preprocess_modify_script ''
    f.preprocess_split_script ''
    f.preprocess_put_script ''
  end
end
