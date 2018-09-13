FactoryBot.define do
  factory :uni_upd_mhld_error, class: UniUpdMhldError do |f|
    f.batch_id '24789'
    f.flex 'APG1285'
    f.err_msg 'serial ctrl'
    f.format 'SERIAL'
    f.old_lib 'SAL3'
    f.new_lib 'SAL3'
    f.new_loc 'STACKS'
  end
end
