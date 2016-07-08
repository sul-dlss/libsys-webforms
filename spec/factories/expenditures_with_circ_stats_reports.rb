FactoryGirl.define do
  factory :expenditures_with_circ_stats_report do
    date_request '16-JUN-16'
    date_ran '16-JUN-16'
    status 'REQUEST'
    email 'someone@some.one'
    fund '1065032-103-XYZ'
    fund_begin '1065032-103-'
    date_range_start '01-SEP-08'
    date_range_end '31-AUG-08'
    output_file 'exp_rpt0811141740.1130414'
    message ''
    ckey_link 1
    lib 'GREEN'
    fmt_array 'MARC'
    one_row_total 0
    fy_start 'FY 2009'
    fy_end 'FY 2011'
    cal_start '2000'
    cal_end '2001'
    pd_start '04-OCT-96'
    pd_end '04-OCT-97'
  end
end
