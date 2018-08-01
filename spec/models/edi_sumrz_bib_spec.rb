require 'rails_helper'

RSpec.describe EdiSumrzBib, type: :model do
  describe 'inserting a new line' do
    it 'should add an entry with a fake ckey' do
      edi_lin = EdiLin.where(vend_id: 'AMALIV', doc_num: '592924', edi_lin_num: '11')
      insert = EdiSumrzBib.insert(edi_lin)
      expect(insert).to be true
      edi_sumrz_bib = EdiSumrzBib.find_by(edi_ckey: -1)
      expect(edi_sumrz_bib.vend_code).to eq 'AMALIV'
      expect(edi_sumrz_bib.id001).to eq 'aal0762919'
      expect(edi_sumrz_bib.load_date.strftime('%T')).to eq Time.zone.now.strftime('%T')
      expect(edi_sumrz_bib.active_record).to eq nil
    end
  end
end
