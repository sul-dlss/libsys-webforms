require 'rails_helper'

RSpec.describe CirculationStatisticsReport, type: :model do
  describe 'LC callnum range' do
    context 'when call_lo is one LC letter and call_hi is blank' do
      let(:report) { FactoryBot.build(:circulation_statistics_report, range_type: 'lc', call_lo: 'n', call_hi: '') }

      it 'call_hi can be blank' do
        expect(report).to be_valid
      end

      it 'converts the call_lo to upper case' do
        report.validate
        expect(report.call_lo).to eq 'N'
      end

      it 'call_hi can be one letter' do
        report = FactoryBot.build(:circulation_statistics_report, range_type: 'lc', call_lo: 'n', call_hi: 'p')
        expect(report).to be_valid
      end

      it 'call_hi has to be one letter if higher in range' do
        report = FactoryBot.build(:circulation_statistics_report, range_type: 'lc', call_lo: 'n', call_hi: 'nd')
        expect(report).to_not be_valid
      end
    end
  end

  context 'when call_lo is two LC letters and call_hi is blank' do
    let(:report) { FactoryBot.build(:circulation_statistics_report, range_type: 'lc', call_lo: 'nd', call_hi: '') }

    it 'call_hi can be blank' do
      expect(report).to be_valid
    end

    it 'converts the call_lo to upper case' do
      report.validate
      expect(report.call_lo).to eq 'ND'
    end
  end

  context 'when call_lo is two LC letters and call_hi is higher in range' do
    let(:report) { FactoryBot.build(:circulation_statistics_report, range_type: 'lc', call_lo: 'nd', call_hi: 'nz') }

    it 'call_hi can be a latter letter' do
      expect(report).to be_valid
    end

    it 'converts the call_lo to upper case' do
      report.validate
      expect(report.call_lo).to eq 'ND'
    end

    it 'converts the call_hi to upper case' do
      report.validate
      expect(report.call_hi).to eq 'NZ'
    end
  end

  context 'when call_lo is two LC letters and call_hi is not in range' do
    it 'call_hi cannot be the same two letters as call_lo' do
      report = FactoryBot.build(:circulation_statistics_report, range_type: 'lc', call_lo: 'nd', call_hi: 'nd')
      expect(report).to_not be_valid
    end

    it 'call_hi has to be in the same two-letter call range as call_lo' do
      report = FactoryBot.build(:circulation_statistics_report, range_type: 'lc', call_lo: 'nd', call_hi: 'pd')
      expect(report).to_not be_valid
    end
  end

  context 'when call lo is one or two letters with a wildcard' do
    let(:report) { FactoryBot.build(:circulation_statistics_report, range_type: 'lc', call_lo: 'n#') }

    it 'call_hi should be blank' do
      expect(report).to be_valid
    end

    it 'converts the call_lo to upper case' do
      report.validate
      expect(report.call_lo).to eq 'N#'
    end

    it 'cannot have a call_hi range' do
      report = FactoryBot.build(:circulation_statistics_report, range_type: 'lc', call_lo: 'n#', call_hi: 'nz')
      expect(report).to_not be_valid
    end
  end

  describe 'classic call' do
    context 'when classic call number alpha range' do
      let(:report) { FactoryBot.build(:circulation_statistics_report, range_type: 'classic', call_alpha: 'nd') }

      it 'converts the call_alpha to upper case before validations' do
        report.validate
        expect(report.call_alpha).to eq 'ND'
      end
    end

    context 'when classic call number numeric range' do
      let(:report) do
        FactoryBot.build(:circulation_statistics_report, range_type: 'classic', call_lo: '100', call_hi: '230')
      end

      it 'is a valid report' do
        report.validate
        expect(report).to be_valid
      end
    end
  end

  describe 'tag fields' do
    context 'when there is a 008 in one of the tag fields' do
      let(:report) { FactoryBot.build(:circulation_statistics_report, tag_field4: '008') }

      it 'is an invalis report' do
        report.validate
        expect(report).not_to be_valid
      end
    end
  end
end
