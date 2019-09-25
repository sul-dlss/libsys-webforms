FactoryBot.define do
  factory :expenditures_with_circ_stats_report do
    date_type { 'fiscal' }
    status { 'REQUEST' }
    email { 'someone@some.one' }
    fund { %w(1065032-103-XYZ) }
    fund_begin { '1065032-103-' }
    date_range_start { '01-SEP-08' }
    date_range_end { '31-AUG-08' }
    output_file { 'exp_rpt08111417402' }
    message { '' }
    ckey_link { 1 }
    lib_array { %w(GREEN SAL3) }
    format_array { %w(MARC MANUSCRIPT) }
    one_row_total { 0 }
    fy_start { 'FY 2009' }
    fy_end { 'FY 2010' }
    cal_start { '2000' }
    cal_end { '2001' }
    pd_start { '04-OCT-96' }
    pd_end { '04-OCT-97' }
  end
end
