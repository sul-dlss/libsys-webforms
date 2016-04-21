FactoryGirl.define do
  factory :errors_for_batch, class: UniUpdatesErrors do |f|
    f.run '2013-06-15 12:06:35'
    f.batch '12845'
    f.item_id '36105134493878'
    f.call_num 'HE2791 .D63 A2 1940'
    f.shelving_key 'HE 002791 .D63 A2 001940'
    f.msg 'some-message'
  end
end
