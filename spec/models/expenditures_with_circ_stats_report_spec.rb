require 'rails_helper'

# rubocop:disable  Metrics/BlockLength
RSpec.describe ExpendituresWithCircStatsReport, type: :model do
  before do
    create(:expenditures_fy_date)
  end

  it 'has a valid factory' do
    expect(create(:expenditures_with_circ_stats_report)).to be_valid
  end

  describe 'callbacks for fiscal year dates' do
    before do
      @report = create(:expenditures_with_circ_stats_report)
    end

    it 'has attributes' do
      expect(@report).to have_attributes(status: 'REQUEST')
    end

    it 'checks the funds' do
      expect(@report.send(:set_fund)).to eq(@report.fund.join(','))
    end

    it 'writes the funds' do
      @report.save
      expect(@report.date_range_start).not_to be_nil
    end

    describe 'checking the report fiscal year dates' do
      it 'writes fy_start' do
        expect(@report.send(:write_fy_start, '2011')).to eq('2010-SEP-03')
      end

      it 'writes fy_end' do
        expect(@report.send(:write_fy_end, '2011')).to eq('2011-AUG-25')
      end
    end

    context 'when fy end date is present' do
      it 'checks calendar year dates' do
        expect(@report.send(:check_fy)).to eq('2010-AUG-26')
      end
    end

    context 'when no fy end date present' do
      before do
        @report = create(:expenditures_with_circ_stats_report, fy_end: '')
      end

      it 'sets the fy end date the same as the start date' do
        expect(@report.send(:check_fy)).to eq('2009-AUG-27')
      end
    end

    it 'sets the attribute for fund_acct with a fund_begin value' do
      @report.update(fund: nil)
      expect(@report.send(:set_fund)).to eq('1065032-103-')
    end
  end

  describe 'callbacks for calendar year dates' do
    before do
      @report = create(:expenditures_with_circ_stats_report, date_type: 'calendar')
    end

    it 'writes the funds' do
      @report.save
      expect(@report.date_range_start).not_to be_nil
    end

    it 'writes cal_start' do
      expect(@report.send(:write_cal_start, '2011')).to eq('2011-01-01')
    end

    it 'writes cal_end' do
      expect(@report.send(:write_cal_end, '2011')).to eq('2011-12-31')
    end

    context 'when end date is present' do
      it 'checks calendar year dates' do
        expect(@report.send(:check_cal)).to eq('2001-12-31')
      end
    end

    context 'when no end date present' do
      before do
        @report = create(:expenditures_with_circ_stats_report, date_type: 'calendar', cal_end: '')
      end

      it 'sets the end date the same as the start date' do
        expect(@report.send(:check_cal)).to eq('2000-12-31')
      end
    end
  end

  describe 'callbacks for paid dates' do
    before do
      @report = create(:expenditures_with_circ_stats_report, date_type: 'paydate')
    end

    it 'writes the funds' do
      @report.save
      expect(@report.date_range_start).not_to be_nil
    end

    it 'writes pd_start' do
      expect(@report.send(:write_pd_start, '04-OCT-96')).to eq('1996-OCT-04')
    end

    it 'writes pd_end' do
      expect(@report.send(:write_pd_end, '04-OCT-97')).to eq('1997-OCT-04')
    end

    context 'when end date is present' do
      it 'checks paid dates' do
        expect(@report.send(:check_pd)).to eq('1997-OCT-04')
      end
    end

    context 'when no end date present' do
      before do
        @report = create(:expenditures_with_circ_stats_report, date_type: 'paydate', pd_end: '')
      end

      it 'sets the end date the same as the start date' do
        expect(@report.send(:check_pd)).to eq('1996-OCT-04')
      end
    end
  end

  describe 'reports with invalid dates' do
    before do
      @report = create(:expenditures_with_circ_stats_report)
    end

    # The order of the tests matters here
    # rubocop:disable RSpec/MultipleExpectations
    it 'raises an error' do
      expect do
        @report.update!(fy_end: 'FY 2100')
        @report.send(:check_fy)
      end.to raise_error(ActiveRecord::RecordNotFound)

      expect do
        @report.update!(fy_start: 'FY 2099')
        @report.send(:check_fy)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
    # rubocop:enable RSpec/MultipleExpectations
  end

  describe 'validations' do
    before do
      @report = build(:expenditures_with_circ_stats_report,
                      date_type: nil, fund_begin: nil, fund: nil, cal_start: nil)

      @report.validate
    end

    it 'validates the inclusion of a start date' do
      expect(@report.errors.messages[:base]).to include 'Choose a start date for fiscal, calendar, or paid date'
    end

    it 'validates the presence of a fund' do
      expect(@report.errors.messages[:base]).to include \
        'Select a single Fund ID/PTA, a fund that begins with an ID/PTA number, or all SUL funds'
    end
  end
end
# rubocop:enable  Metrics/BlockLength
