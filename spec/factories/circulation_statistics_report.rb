FactoryBot.define do
  factory :circulation_statistics_report do
    email { 'test@test.com' }
    lib_array { ['', 'ARS', 'ART', 'GREEN', 'SAL3'] }
    source { 0 }
    range_type { '' }
    call_alpha { '' }
    barcodes { '' }
    call_lo { '' }
    call_hi { '' }
    format_array { ['', 'EQUIP', 'MANUSCRIPT'] }
    exclude_inactive { 1 }
    min_yr { 1964 }
    max_yr { 1982 }
    exclude_bad_yr { 'Y' }
    include_inhouse { 1 }
    tag_field { '' }
    tag_field2 { '' }
    tag_field3 { '' }
    tag_field4 { '' }
    tags_url { 'Y' }
    link_type { 'E' }
    col_header1 { 'Selector Decision' }
    col_header2 { 'Notes' }
    col_header3 { 'Selector Initials' }
    col_header4 { '' }
    col_header5 { '' }
    blank_col_array { 'Selector Decision,Notes,Selector Initials,,' }
    lib_loc_array { 'ARS/RECORDINGS,ART/ARTLCKM/ARTLCKS,GREEN/BENDER,SAL3' }
  end
end
