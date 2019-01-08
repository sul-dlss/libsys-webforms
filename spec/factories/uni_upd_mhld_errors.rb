FactoryBot.define do
  factory :uni_upd_mhld_error, class: UniUpdMhldError do
    batch_id { '24789' }
    flex { 'APG1285' }
    err_msg { 'serial ctrl' }
    format { 'SERIAL' }
    old_lib { 'SAL3' }
    new_lib { 'SAL3' }
    new_loc { 'STACKS' }
  end
end
