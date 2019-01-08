FactoryBot.define do
  factory :edi_error_report, class: EdiErrorReport do
    run { '2018-02-02 14:05:06' }
    type { 'EDI_PROCESS_ORDER.do_inv_line_order:xcptn==stop_this_line ||===|| vendor==CASALI @vend_inv# 18-04739, line 1. uni_inv# 18-04739, line 001' }
    error { 'failed step==firm:verify_po on err==supplied PO# not in Unicorn:CAS6729454 edi_ckey:12086310' }
    err_lvl { 'notify' }
  end
end
