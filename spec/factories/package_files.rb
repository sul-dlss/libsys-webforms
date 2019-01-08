FactoryBot.define do
  factory :package_file do
    package_id { 'tv' }
    vendor_name { 'Alexander Street Press' }
    seq_number { 478_980 }
    package_status { 'Active' }
    file_name { 'theatervideo_all_pp_DELETES.mrc' }
    date_created { Time.now }
    new_file_name { 'tv_theatervideo_all_pp_DELETES.mrc' }
    file_size_bytes { nil }
    file_type { 'binary' }
    vnd_file_function { 'get' }
    date_extracted { nil }
    date_of_action { Time.now + 10*60 }
    date_ftpd { Time.now + 10*60 }
    date_to_load { nil }
    place_to_load { 'Palatino' }
    date_loaded { nil }
    record_source { 'PROCESS_GEN_LIST_AFS' }
    status_ftp { 'DONE' }
    status_load { 'REQUEST' }
    parms_used { nil }
    count_of_titles { 0 }
    note { 'Generic e-load' }
    remote_dir { nil }
  end
  factory :package_file_done, class: PackageFile do
    package_id { 'tv' }
    vendor_name { 'Alexander Street Press' }
    seq_number { 478_995 }
    package_status { 'Active' }
    file_name { 'theatervideo_all_pp_NEW.mrc' }
    date_created { Time.now }
    new_file_name { 'tv_theatervideo_all_pp_NEW.mrc' }
    file_size_bytes { nil }
    file_type { 'binary' }
    vnd_file_function { 'get' }
    date_extracted { nil }
    date_of_action { Time.now + 10*60 }
    date_ftpd { Time.now + 10*60 }
    date_to_load { nil }
    place_to_load { 'Palatino' }
    date_loaded { nil }
    record_source { 'PROCESS_GEN_LIST_AFS' }
    status_ftp { 'DONE' }
    status_load { 'DONE' }
    parms_used { nil }
    count_of_titles { 0 }
    note { 'Generic e-load' }
    remote_dir { nil }
  end
end
