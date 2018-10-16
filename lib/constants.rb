module Constants
  AUTHORIZED_USER_APPS = {
    'accession_number' => 'Accession number',
    'db_access_ids' => 'Database access',
    'digital_bookplates' => 'Digital bookplates',
    'direct_upload' => 'Direct uploads',
    'email_stats' => 'Email stats',
    'file_upload' => 'File uploads',
    'mgt_rpts' => 'Management reports',
    'ora_admin' => 'Oracle administration',
    'priceforbills' => 'Price for bills',
    'priv_approval' => 'Privileges approvals',
    'priv_support' => 'Privileges support',
    'reset_recall_counter' => 'Reset recall counter',
    'sal3_batch_req' => 'SAL3 batch requests',
    'sal3_breq_edit' => 'Edit SAL3 batch requests',
    'unicorn_updates' => 'Symphony batch updates',
    'unicorn_circ_batch' => 'Symphony circulation batches',
    'userload_rerun' => 'Userload reruns',
    'edi_inv_view' => 'View EDI Invoices',
    'edi_inv_manage' => 'Manage EDI Invoices',
    'package_manage' => 'Manage ELoader Packages'
  }.freeze

  PACKAGE_COLUMNS = {
    'package_status' => 'Package status',
    'package_id' => 'Package ID',
    'package_name' => 'Package name',
    'vendor_name' => 'Vendor name',
    'package_url' => 'Documentation URL',
    'data_pickup_type' => 'Data pickup type',
    'afs_path' => 'AFS directory path',
    'put_file_loc' => 'FTP download directory path',
    'ftp_server' => 'FTP server',
    'ftp_user' => 'FTP user',
    'ftp_password' => 'FTP password',
    'ftp_directory' => 'FTP remote directory',
    'ftp_file_prefix' => 'FTP file name pattern (Perl regex)',
    'proc_type' => 'Create new record or merge URL',
    'match_opts' => 'Fields to match incoming to Symphony records',
    'url_field' => 'Symphony URL destination',
    'vendor_id_read' => 'Vendor ID field (read)',
    'access_note' => 'Add access restriction note',
    'update_040' => 'Create/Update 040 with CSt',
    'vnd_catcode' => 'Vendor cataloging code for 040',
    'export_note' => 'Export record to OCLC',
    'export_auth' => 'Export record to Backstage',
    'date_cat' => 'Date cataloged for new records',
    'holding_code' => 'Holding code',
    'encoding_level' => 'MARC encoding level',
    'junktag_file' => 'Custom junktag filename',
    'preprocess_modify_script' => 'Full path of preprocess modify script',
    'preprocess_split_script' => 'Full path of preprocess split script',
    'preprocess_put_script' => 'Full path of preprocess put in AFS script',
    'rpt_mail' => 'Extra email addresses for reports',
    'comments' => 'Comments'
  }.freeze

  PACKAGE_MATCH_OPTS = {
    '020' => '020 (subfield a,z) to Symphony 020 or 776',
    '776_isbn' => '776 (subfield z) to Symphony 020 or 776',
    '022' => '022 (subfield a,y,z) to Symphony 022 or 776',
    '776_issn' => '776 (subfield x) to Symphony 022 or 776',
    '024_isbn' => '024 (subfield a,z) to Symphony 020 or 776'
  }.freeze

  PACKAGE_PROC_TYPE = {
    'newonly' => 'New only',
    'newmerge' => 'Merge or new',
    'mergeonly' => 'Merge only',
    'ckeymerge' => 'CKEY-URL merge'
  }.freeze

  PACKAGE_MARC_ENCDG_LVL = {
    'ASIS' => 'Do not replace',
    ' ' => '<space character> Full level',
    '1' => '1 - Full level, material not examined',
    '2' => '2 - Less-than-full level, material not examined',
    '3' => '3 - Abbreviated level',
    '4' => '4 - Core level',
    '5' => '5 - Partial (preliminary) level',
    '7' => '7 - Minimal level',
    '8' => '8 - Prepublication level',
    'u' => 'u - Unknown',
    'z' => 'z - Not applicable'
  }.freeze
end
