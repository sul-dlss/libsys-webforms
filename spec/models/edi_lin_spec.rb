require 'rails_helper'

RSpec.describe EdiLin, type: :model do
  describe 'make_updates' do
    it 'should update the edi_lin table unique_vend_id with "noBib"' do
      update = EdiLin.make_updates('AMALIV', '592924', '11')
      expect(update[0].to_s).to eq 'notice'
      edi_sumrz_bib = EdiSumrzBib.find_by(edi_ckey: -1)
      edi_lin = EdiLin.find_by(vend_unique_id: 'aal0762919noBib')
      expect(edi_sumrz_bib.id001).to eq edi_lin.vend_unique_id
    end
    it 'should return an error message if the ID from EdiSumrzBib matches' do
      update = []
      2.times do
        update = EdiLin.make_updates('AMALIV', '592924', '11')
      end
      expect(update[0].to_s).to eq 'error'
    end
  end
  describe 'sets a list of unique vendors' do
    it 'has a list that is only a few lines' do
      expect(EdiLin.vendors.length).to be < 10
    end
  end
end
