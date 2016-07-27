FactoryGirl.define do
  factory :circulation_statistics_report_log do
    date_request '14-JUL-16'
    date_ran '14-JUL-16'
    status 'SAVED'
    email 'testuser@stanford.edu'
    call_range 'H'
    libs_locs 'GREEN/STACKS'
    format ''
    include_inhouse 1
    exclude_inactive 1
    blank_columns 'Selector Decision,Notes,Selector Initials'
    input_path ''
    output_name 'circ_rpt160714193423814'
    message ''
    extra_field ''
    extra_field2 ''
    ckey_url 'Y'
    extras_url 'Y'
    link_type 'E'
    selcall_src 1
    summary_only 'Y'
    min_pub_year ''
    max_pub_year ''
    exclude_bad_year ''
  end
end
