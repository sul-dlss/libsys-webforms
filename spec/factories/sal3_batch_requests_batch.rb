include ActionDispatch::TestProcess
FactoryBot.define do
  factory :sal3_batch_requests_batch do
    batch_id { 1 }
    batch_name { 'Batch name' }
    user_name { 'Test User' }
    user_email { 'libraryuser@stanford.edu, otheruser@stanford.edu' }
    user_sunetid { 'someone' }
    status { '' }
    priority { '3' }
    batch_container { 'Unknown' }
    batch_media { 'Unknown' }
    batch_startdate { Time.zone.today }
    batch_needbydate { Time.zone.today + 30 }
    batch_numpullperday { 10 }
    batch_pullmon { '1' }
    batch_pulltues { '1' }
    batch_pullwed { '1' }
    batch_pullthurs { '1' }
    batch_pullfri { '' }
    stopcode { 'GB' }
    pseudo_id { 'MAPSCANLAB' }
    comments { 'Test comment' }
    ckey { '1234567' }
    bc_file { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/test_file.txt')) }
    num_bcs { '' }
    num_nonsymph_bcs { '' }
    pending { '' }
    load_date { '14-06-16' }
    last_action_date { nil }
  end
end
