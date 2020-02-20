require 'rails_helper'

RSpec.describe EdiLin, type: :model do
  # The order of the tests matters here
  # rubocop:disable RSpec/MultipleExpectations
  describe 'make_updates' do
    it 'updates the edi_lin table unique_vend_id with "noBib"' do
      update = described_class.update_edi_lin('AMALIV', '592924', '11')
      expect(update[0].to_s).to eq 'notice'
      edi_sumrz_bib = EdiSumrzBib.find_by(edi_ckey: -1)
      edi_lin = described_class.find_by(vend_unique_id: 'aal0762919noBib')
      expect(edi_sumrz_bib.id001).to eq edi_lin.vend_unique_id
    end

    it 'returns an error message if the ID from EdiSumrzBib matches' do
      update = []
      2.times do
        update = described_class.update_edi_lin('AMALIV', '592924', '11')
      end
      expect(update[0].to_s).to eq 'error'
    end
  end
  # rubocop:enable RSpec/MultipleExpectations

  describe 'sets a list of unique vendors' do
    it 'has a list that is only a few lines' do
      expect(described_class.vendors.length).to be < 10
    end
  end

  describe 'sets the kind of rowid used for sqlite3 in test' do
    it 'gets the database type used from the Rails config' do
      expect(described_class.database).to eq 'db/test.sqlite3'
    end

    it 'uses the id pseudocolumn for the dev/test sqlite database primary key' do
      expect(described_class.primary_key).to eq 'id'
    end

    it 'uses the id pseudocolumn for the dev/test sqlite database row id' do
      expect(described_class.row_id).to eq 'id'
    end
  end

  describe 'sets the kind of rowid used for oracle sql in test' do
    before do
      allow(described_class).to receive(:database).and_return('LTRXPRD1')
    end

    it 'gets the database type used from the Rails config' do
      expect(described_class.database).to eq 'LTRXPRD1'
    end

    it 'uses the id pseudocolumn for the prod oracle database primary key' do
      expect(described_class.primary_key).to eq 'rowid'
    end

    it 'uses the id pseudocolumn for the prod oracle database row id' do
      expect(described_class.row_id).to eq 'rowid'
    end
  end
end
