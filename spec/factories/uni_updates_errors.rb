FactoryBot.define do
  factory :errors_for_batch, class: UniUpdatesErrors do
    run { '2013-06-15 12:06:35' }
    batch { '12845' }
    item_id { '36105134493878' }
    call_num { 'HE2791 .D63 A2 1940' }
    shelving_key { 'HE 002791 .D63 A2 001940' }
    msg { 'some-message' }
  end
end
