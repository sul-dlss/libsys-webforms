FactoryBot.define do
  factory :authorized_user do
    user_id { 'testuser' }
    user_name { 'Test User' }
    unicorn_updates { 'Y' }
    direct_upload { 'Y' }
    unicorn_circ_batch { '' }
    priv_approval { '' }
    email_stats { '' }
    priv_support { '' }
    db_access_ids { '' }
    priceforbills { '' }
    reset_recall_counter { '' }
    mgt_rpts { 'Y' }
    ora_admin { 'Y' }
    sal3_batch_req { 'Y' }
    sal3_breq_edit { 'Y' }
    file_upload { 'Y' }
    userload_rerun { 'Y' }
    accession_number { 'A' }
    edi_inv_view { 'Y' }
    edi_inv_manage { 'Y' }
    illiad_user_export { 'Y' }
  end
  factory :admin_user, class: AuthorizedUser do
    user_id { 'admin_user' }
    user_name { 'Admin User' }
    unicorn_updates { 'A' }
    direct_upload { 'Y' }
    unicorn_circ_batch { '' }
    priv_approval { '' }
    email_stats { '' }
    priv_support { '' }
    db_access_ids { '' }
    priceforbills { '' }
    reset_recall_counter { '' }
    mgt_rpts { 'A' }
    ora_admin { 'Y' }
    sal3_batch_req { 'Y' }
    sal3_breq_edit { 'Y' }
    file_upload { 'Y' }
    userload_rerun { 'Y' }
    accession_number { 'A' }
    digital_bookplates { 'A' }
    edi_inv_view { 'A' }
    edi_inv_manage { 'A' }
    package_manage { 'A' }
  end
  factory :staff_user, class: AuthorizedUser do
    user_id { 'staff_user' }
    user_name { 'Staff User' }
    unicorn_updates { 'Y' }
    direct_upload { 'Y' }
    unicorn_circ_batch { '' }
    priv_approval { '' }
    email_stats { '' }
    priv_support { '' }
    db_access_ids { '' }
    priceforbills { '' }
    reset_recall_counter { '' }
    mgt_rpts { 'Y' }
    ora_admin { 'Y' }
    sal3_batch_req { 'Y' }
    sal3_breq_edit { 'Y' }
    file_upload { 'Y' }
    userload_rerun { 'Y' }
    accession_number { 'Y' }
    digital_bookplates { 'Y' }
    edi_inv_view { 'Y' }
    edi_inv_manage { 'Y' }
    package_manage { 'Y' }
  end
  factory :blank_user, class: AuthorizedUser do
    user_id { 'blank_user' }
    user_name { 'Blank User' }
    unicorn_updates { '' }
    direct_upload { '' }
    unicorn_circ_batch { '' }
    priv_approval { '' }
    email_stats { '' }
    priv_support { '' }
    db_access_ids { '' }
    priceforbills { '' }
    reset_recall_counter { '' }
    mgt_rpts { '' }
    ora_admin { '' }
    sal3_batch_req { '' }
    sal3_breq_edit { '' }
    file_upload { '' }
    userload_rerun { '' }
    accession_number { '' }
    edi_inv_view { '' }
    edi_inv_manage { '' }
  end
end
