FactoryBot.define do
  factory :accession_number do
    id 1
    resource_type 'Visual Materials'
    item_type 'DVD'
    location 'Media Microtext'
    prefix 'ZDVD'
    seq_num 1
  end
  factory :zvc_number, class: AccessionNumber do
    id 9
    resource_type 'Visual Materials'
    item_type 'Serial VHS'
    location 'Media Microtext'
    prefix 'ZVC'
    seq_num 10_100
  end
end
