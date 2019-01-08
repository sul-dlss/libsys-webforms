FactoryBot.define do
  factory :uni_updates_batch do
    batch_id { 1 }
    batch_date { '2016-05-02 16:06:56' }
    user_name { 'Library User' }
    user_email { 'libraryuser@stanford.edu, otheruser@stanford.edu' }
    action { 'TRANSFER' }
    priority { 1 }
    export_yn { 'no_socI' }
    check_bc_first { 'N' }
    orig_lib { 'GOV-DOCS' }
    new_lib { 'GREEN' }
    new_homeloc { 'FED-DOCS' }
    new_curloc { '' }
    new_itype { 'GOVSTKS' }
    total_bcs { 1 }
    pending { 'Y' }
    comments { '' }
    num_errors { 1 }
  end
end
