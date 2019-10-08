FactoryBot.define do
  factory :encumbrance_report do
    email { 'someone@some.one' }
    fund { %w(1065032-103-XYZ) }
    fund_begin { '1065032-103-' }
    funding_paid { 'All records' }
    fundcyc_cycle { '2015' }
    status { 'REQUESTED' }
    output_file { 'enc_0001' }
    date_request { '2020-20-20' }
    created_at { '2016-06-21 00:34:08.437369' }
    updated_at { '2016-06-21 00:34:08.437369' }
  end
end
