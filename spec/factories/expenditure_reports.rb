FactoryBot.define do
  factory :expenditure_report do
    date_type { 'fiscal' }
    status { 'REQUEST' }
    email { 'someone@some.one' }
    fund { ['1065032-103-XYZ'] }
    fund_begin { '1065032-103-' }
    date_range_start { '01-SEP-08' }
    date_range_end { '25-AUG-11' }
    output_file { 'exp_rpt08111417402' }
    message { '' }
    ckey_link { '1' }
    path_invlin_fund_keys { '' }
    fy_start { 'FY 2009' }
    fy_end { 'FY 2011' }
    cal_start { '2000' }
    cal_end { '2001' }
    pd_start { '04-OCT-96' }
    pd_end { '04-OCT-97' }
  end
end
