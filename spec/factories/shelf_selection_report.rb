# frozen_string_literal: true

FactoryBot.define do
  factory :shelf_selection_report do
    email { 'test@test.org' }
    lib { 'GREEN' }
    loc_array { ['', 'BENDER'] }
    cloc_diff { '0' }
    format_array { ['', 'MANUSCRIPT'] }
    itype_array { ['', 'ATLAS-EXP'] }
    icat1_array { ['', 'ALL'] }
    lang { '' }
    min_yr { '' }
    max_yr { '' }
    min_circ { '' }
    max_circ { '' }
    shadowed { '2' }
    digisent { '0' }
    url { '0' }
    mhlds { '0' }
    has_dups { '0' }
    multvol { '0' }
    multcop { '0' }
    no_boundw { '1' }
    range_type { 'lc' }
    call_alpha { '' }
    subj_name { 'Green Bender A-B' }
    save_opt { 'save' }
    search_name { '' }
    call_lo { 'A' }
    call_hi { 'B' }
  end
end
