require 'rails_helper'

# rubocop:disable Lint/Void, Metrics/BlockLength
RSpec.describe LobbytrackReportsController, type: :controller do
  # rubocop:disable RSpec/VerifiedDoubles
  let(:mock_client) { double(TinyTds) }
  # rubocop:enable RSpec/VerifiedDoubles

  before do
    allow(mock_client).to receive(:active?).and_return true
    allow(LobbytrackReport).to receive(:client).and_return(mock_client)
  end

  describe 'get#index', type: :lobbytrack_reports do
    before do
      stub_current_user(FactoryBot.create(:authorized_user))
    end

    it 'gets the input form page' do
      get :index
      expect(response).to render_template 'index'
    end
  end

  describe 'post#visits', type: :lobbytrack_reports do
    before do
      stub_current_user(FactoryBot.create(:authorized_user))
    end

    context 'when there is a visit id' do
      let(:lobbytrack_reports) do
        {
          'CardHolderID' => '1140250',
          'DateIn' => '2018-08-31 09 :19:39 -0700',
          'ReportField1' => 'JAMES',
          'ReportField2' => 'BOND',
          'LookupField1' => 'jbond@mi6.com'
        }
        {
          'CardHolderID' => '1140250',
          'DateIn' => '2018-09-13 15 :05:56 -0700',
          'ReportField1' => 'JAMES',
          'ReportField2' => 'BOND',
          'LookupField1' => 'jbond@mi6.com'
        }
      end

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
      end

      it 'shows the visits result page' do
        post :visits, params: { lobbytrack_report: { visit_id: '007' } }
        expect(response).to render_template 'visits'
      end
    end

    context 'when the visit id is empty or not found' do
      let(:lobbytrack_reports) { [] }

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
        post :visits, params: { lobbytrack_report: { visit_id: '000' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a flash message' do
        expect(flash[:warning]).to eq 'There is no attendance history for id 000'
      end
    end
  end

  describe 'post#visit_dates', type: :lobbytrack_reports do
    before do
      stub_current_user(FactoryBot.create(:authorized_user))
    end

    context 'when there are results with in the date range' do
      let(:lobbytrack_reports) do
        {
          'CardHolderID' => '1140250',
          'DateIn' => '2018-08-31 09 :19:39 -0700',
          'ReportField1' => 'JAMES',
          'ReportField2' => 'BOND',
          'LookupField1' => 'jbond@mi6.com'
        }
        {
          'CardHolderID' => '1140250',
          'DateIn' => '2018-09-13 15 :05:56 -0700',
          'ReportField1' => 'JAMES',
          'ReportField2' => 'BOND',
          'LookupField1' => 'jbond@mi6.com'
        }
      end

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
      end

      it 'shows the visit dates result page' do
        post :visit_dates, params: { lobbytrack_report: { visit_date1: '01/01/2019', visit_date2: '01/01/2020' } }
        expect(response).to render_template 'visit_dates'
      end
    end

    context 'when no results' do
      let(:lobbytrack_reports) { [] }

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
        post :visit_dates, params: { lobbytrack_report: { visit_date1: '01/01/2019', visit_date2: '01/01/2020' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a flash message' do
        expect(flash[:warning]).to eq 'There is no attendance history between the dates 01/01/2019 to 01/01/2020'
      end
    end
  end

  describe 'get#checkins', type: :lobbytrack_reports do
    let(:lobbytrack_reports) do
      {
        'CardHolderID' => '1140250',
        'DateIn' => '2018-08-31 09 :19:39 -0700',
        'ReportField1' => 'JAMES',
        'ReportField2' => 'BOND',
        'LookupField1' => 'jbond@mi6.com'
      }
      {
        'CardHolderID' => '1140250',
        'DateIn' => '2018-09-13 15 :05:56 -0700',
        'ReportField1' => 'JAMES',
        'ReportField2' => 'BOND',
        'LookupField1' => 'jbond@mi6.com'
      }
    end

    before do
      stub_current_user(FactoryBot.create(:authorized_user))
      allow(controller).to receive(:checkins).and_return(lobbytrack_reports)
    end

    it 'gets the checkins page' do
      post :checkins, params: { lobbytrack_report: { checkin_id: 111 } }
      expect(response).to render_template 'checkins'
    end
  end

  describe 'post#checkin_dates', type: :lobbytrack_reports do
    before do
      stub_current_user(FactoryBot.create(:authorized_user))
    end

    context 'when there are results with in the date range' do
      let(:lobbytrack_reports) do
        {
          'CardHolderID' => '1140250',
          'DateOfEvent' => '2018-08-31 09 :19:39 -0700',
          'ReportField1' => 'JAMES',
          'ReportField2' => 'BOND',
          'LookupField1' => 'jbond@mi6.com'
        }
        {
          'CardHolderID' => '1140250',
          'DateOfEvent' => '2018-09-13 15 :05:56 -0700',
          'ReportField1' => 'JAMES',
          'ReportField2' => 'BOND',
          'LookupField1' => 'jbond@mi6.com'
        }
      end

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
      end

      it 'shows the visit dates result page' do
        post :checkin_dates, params: { lobbytrack_report: { checkin_date1: '01/01/2019', checkin_date2: '01/01/2020' } }
        expect(response).to render_template 'checkin_dates'
      end
    end

    context 'when no results' do
      let(:lobbytrack_reports) { [] }

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
        post :checkin_dates, params: { lobbytrack_report: { checkin_date1: '01/01/2019', checkin_date2: '01/01/2020' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a flash message' do
        expect(flash[:warning]).to eq 'There is no attendance history between the dates 01/01/2019 to 01/01/2020'
      end
    end
  end
end
# rubocop:enable Lint/Void, Metrics/BlockLength
