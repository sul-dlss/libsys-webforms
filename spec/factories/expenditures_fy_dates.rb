FactoryBot.define do
  factory :expenditures_fy_date do
    fy { 2009 }
    min_paydate { '2008-09-05 00:00:00' }
    max_paydate { '2009-08-27 00:00:00' }
  end
end
