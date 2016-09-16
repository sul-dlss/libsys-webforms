require 'rails_helper'

RSpec.describe CirculationStatisticsReportsController, type: :controller do
  before(:each) do
    stub_current_user(FactoryGirl.create(:authorized_user))
  end

  describe 'get#new' do
    it 'renders the correct template' do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'post#create' do
    it 'redirects to root_url on success' do
      post :create, circulation_statistics_report: { email: 'test@test.org', lib_array: 'GREEN', call_lo: 'L' }
      expect(response).to redirect_to root_url
    end

    it 'renders new template on failure' do
      post :create, circulation_statistics_report: { email: '', lib_array: '', call_lo: '' }
      expect(response).to render_template('new')
    end
  end

  describe 'get#home_locations' do
    it 'returns a 200 response code' do
      xhr :get, :home_locations
      expect(response.status).to eq(200)
    end
  end

  describe '#lc_call_lo' do
    it 'validates whether lc low callnum range is at most two uppercase letters or one plus #' do
      message = 'Low callnum range must be at most two uppercase letters or one plus #'
      circulation_statistics_report = CirculationStatisticsReport.new(range_type: 'lc',
                                                                      call_lo: 'LLL',
                                                                      email: 'test@test.org',
                                                                      lib_array: 'GREEN')
      circulation_statistics_report.valid?
      expect(circulation_statistics_report.errors.full_messages).to include(message)
    end
  end

  describe '#lc_call_hi' do
    it 'validates whether lc hi callnum range is empty or a later letter than low range' do
      message = 'Hi callnum range must be empty or a later letter.'
      circulation_statistics_report = CirculationStatisticsReport.new(range_type: 'lc',
                                                                      call_lo: 'L',
                                                                      call_hi: 'A',
                                                                      email: 'test@test.org',
                                                                      lib_array: 'GREEN')
      circulation_statistics_report.valid?
      expect(circulation_statistics_report.errors.full_messages).to include(message)
    end
    it 'validates whether lc hi callnum range is empty or has two letters with the same first letter as low range' do
      message = 'Hi callnum range must be empty or two letters with the same first letter as low range'
      circulation_statistics_report = CirculationStatisticsReport.new(range_type: 'lc',
                                                                      call_lo: 'LL',
                                                                      call_hi: 'AA',
                                                                      email: 'test@test.org',
                                                                      lib_array: 'GREEN')
      circulation_statistics_report.valid?
      expect(circulation_statistics_report.errors.full_messages).to include(message)
    end
    it 'validates whether lc hi callnum range is empty when lo range is a letter followed by #' do
      message = 'Hi callnum range must be empty.'
      circulation_statistics_report = CirculationStatisticsReport.new(range_type: 'lc',
                                                                      call_lo: 'L#',
                                                                      call_hi: 'AA',
                                                                      email: 'test@test.org',
                                                                      lib_array: 'GREEN')
      circulation_statistics_report.valid?
      expect(circulation_statistics_report.errors.full_messages).to include(message)
    end
  end

  describe '#classic_call_lo_and_hi' do
    it 'validates whether classic call_lo and call_hi are all digits, with lo lower than hi' do
      message = 'Low and hi callnum range must be all digits, with lo lower than hi.'
      circulation_statistics_report = CirculationStatisticsReport.new(range_type: 'classic',
                                                                      call_lo: '2',
                                                                      call_hi: '1',
                                                                      email: 'test@test.org',
                                                                      lib_array: 'GREEN')
      circulation_statistics_report.valid?
      expect(circulation_statistics_report.errors.full_messages).to include(message)
    end
  end

  describe '#classic_call_alpha' do
    it 'validates whether classic call_alpha is associated with correct low and hi callnum ranges' do
      message = 'Low and hi callnum ranges must be one to four digits.'
      circulation_statistics_report = CirculationStatisticsReport.new(range_type: 'classic',
                                                                      call_alpha: '12',
                                                                      call_lo: 'A',
                                                                      call_hi: 'B',
                                                                      email: 'test@test.org',
                                                                      lib_array: 'GREEN')
      circulation_statistics_report.valid?
      expect(circulation_statistics_report.errors.full_messages).to include(message)
    end
  end
end
