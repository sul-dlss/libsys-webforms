FactoryBot.define do
  factory :edi_inv_line do
    edi_vend_id "MyString"
    edi_doc_num "MyString"
    edi_line_num 1
    edi_fund "MyString"
    edi_po_number "MyString"
    edi_line_net 1.5
    edi_line_gross 1.5
    todo "CreOrd"
  end
end
