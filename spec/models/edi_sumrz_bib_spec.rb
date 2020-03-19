require 'rails_helper'

RSpec.describe EdiSumrzBib, type: :model do
  describe 'inserting a new line' do
    # The order of the tests and setting the variables matters here
    # rubocop:disable RSpec/MultipleExpectations
    it 'adds an entry with a fake ckey' do
      edi_lin = EdiLin.where(vend_id: 'AMALIV', doc_num: '592924', edi_lin_num: '11')
      insert = described_class.insert(edi_lin)
      expect(insert).to be true
      edi_sumrz_bib = described_class.find_by(edi_ckey: -1)
      expect(edi_sumrz_bib.vend_code).to eq 'AMALIV'
      expect(edi_sumrz_bib.id001).to eq 'aal0762919'
      expect(edi_sumrz_bib.load_date).to eq Time.now.getlocal.strftime('%Y-%m-%d %H:%M:%S %z')
      expect(edi_sumrz_bib.active_record).to eq nil
    end
    # rubocop:enable RSpec/MultipleExpectations
  end
end
