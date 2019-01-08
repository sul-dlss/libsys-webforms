FactoryBot.define do
  factory :vnd_runlog do
    run_date { Time.now.getlocal }
    procedure_name { 'VND_GET_GEN_FILES_LIST.DO_AFS_LIST_SINGLE' }
    priority { 'INFO' }
    message { 'Start: VND_GET_GEN_FILES_LIST' }
    vendor_name { '(sp) OCLC WorldCat Collection Sets' }
    action_type { nil }
    seq_number { nil }
    file_name { nil }
    note { nil }
  end
  factory :vnd_runlog_info, class: VndRunlog do
    run_date { Time.now.getlocal }
    procedure_name { 'VND_GET_GEN_FILES_LIST' }
    priority { 'INFO' }
    message { '(sp) OCLC WorldCat Collection Sets' }
    vendor_name { nil }
    action_type { nil }
    seq_number { nil }
    file_name { 'sp_20181121131154_afs' }
    note { 'Total files files found for pkg id sp: 2; Number of files readied to get: 0' }
  end
end
