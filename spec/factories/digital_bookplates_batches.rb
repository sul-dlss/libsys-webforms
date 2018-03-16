include ActionDispatch::TestProcess
FactoryBot.define do
  factory :digital_bookplates_add_batches, class: DigitalBookplatesBatch do
    batch_id 1
    ckey_file 'test_file.txt'
    file_obj { fixture_file_upload(Rails.root.to_s + '/spec/fixtures/files/test_file.txt', 'text/plain') }
    druid 'bb489wp4687'
    user_name 'Staff User'
    user_email 'staff_user@example.com'
    batch_type 'add'
    ckey_count 2
    submit_date { Time.utc(2018,3,14,3,52,20) }
    completed_date nil
  end
  factory :digital_bookplates_completed_batches, class: DigitalBookplatesBatch do
    batch_id 2
    ckey_file 'test_file.txt'
    file_obj { fixture_file_upload(Rails.root.to_s + '/spec/fixtures/files/test_file.txt', 'text/plain') }
    druid 'bb489wp4687'
    user_name 'Admin User'
    user_email 'admin_user@example.com'
    batch_type 'delete'
    ckey_count 2
    submit_date { Time.utc(2018,3,14,3,52,20) }
    completed_date { Time.utc(2018,3,14,19,02,10) }
  end
end
