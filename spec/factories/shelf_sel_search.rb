FactoryBot.define do
  factory :shelf_sel_search do
    user_name { 'mahmed' }
    search_name { 'Green Stacks E-F' }
    call_range { 'E-F' }
    lib { 'GREEN' }
    locs { 'STACKS' }
    fmts { 'MANUSCRIPT,MAP,MARC' }
    itypes { 'ATLAS,ATLAS-EXP,BUSCORPRPT' }
    min_yr { '1902' }
    max_yr { '2013' }
    min_circ { '' }
    max_circ { '10' }
    na_i_e_shadow { '2' }
    na_i_e_url { 0 }
    na_i_e_dups { 0 }
    na_i_e_boundw { 2 }
    na_i_e_cloc_diff { 2 }
    na_i_e_digisent { 0 }
    na_i_e_mhlds { 0 }
    na_i_e_multvol { 0 }
    na_i_e_multcop { 2 }
    lang { 'eng' }
    icat1s { '' }
  end
end
