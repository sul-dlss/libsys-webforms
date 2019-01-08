FactoryBot.define do
  factory :vnd_runlog do |f|
    f.run_date { Time.now.getlocal }
    f.procedure_name 'VND_GET_GEN_FILES_LIST.DO_AFS_LIST_SINGLE'
    f.priority 'INFO'
    f.message 'Start: VND_GET_GEN_FILES_LIST'
    f.vendor_name '(sp) OCLC WorldCat Collection Sets'
    f.action_type nil
    f.seq_number nil
    f.file_name nil
    f.note nil
  end
  factory :vnd_runlog_info, class: VndRunlog do |f|
    f.run_date { Time.now.getlocal }
    f.procedure_name 'VND_GET_GEN_FILES_LIST'
    f.priority 'INFO'
    f.message '(sp) OCLC WorldCat Collection Sets'
    f.vendor_name nil
    f.action_type nil
    f.seq_number nil
    f.file_name 'sp_20181121131154_afs'
    f.note 'Total files files found for pkg id sp: 2; Number of files readied to get: 0'
  end
end
