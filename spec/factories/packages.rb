FactoryBot.define do
  factory :package do
    package_name { 'Theatre in Video' }
    vendor_name { 'Alexander Street Press' }
    record_id { 1 }
    package_id { 'tv' }
    package_status { 'Active' }
    data_pickup_type { 'AFS' }
    afs_path { 'TheatreVideo' }
    ftp_server { 'something' }
    ftp_user { 'something' }
    ftp_password { 'something' }
    ftp_directory { 'something' }
    ftp_file_prefix { 'something' }
    ftp_list_type { 'something' }
    package_url { 'something' }
    date_entered { Time.zone.today }
    holding_code { 'something' }
    comments { '' }
    date_modified { Time.zone.today }
    put_file_loc { '' }
    afs_search_string { '' }
    url_field { '' }
    vendor_id_read { '' }
    vendor_id_write { '' }
    access_note { '' }
    export_note { '' }
    junktag_file { '' }
    encoding_level { 'ASIS' }
    vnd_catcode { '' }
    match_opts { '776_isbn' }
    proc_type { 'newmerge' }
    update_040 { '' }
    rpt_mail { '' }
    access_urls_plats { '' }
    date_cat { '' }
    export_auth { '' }
    preprocess_modify_script { '' }
    preprocess_split_script { '' }
    preprocess_put_script { '' }
  end
end
