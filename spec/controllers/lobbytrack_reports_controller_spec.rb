require 'rails_helper'

# rubocop:disable Lint/Void, Metrics/BlockLength
RSpec.describe LobbytrackReportsController, type: :controller do
  # rubocop:disable RSpec/VerifiedDoubles
  let(:mock_client) { double(TinyTds) }
  # rubocop:enable RSpec/VerifiedDoubles

  let(:lobbytrack_visitor) do
    [
      {
        'IDNumber' => '7007007',
        'LastName' => 'BOND',
        'FirstName' => 'JAMES',
        'Email' => 'jbond@mi6.org',
        'StreetAddress' => 'SIS Building',
        'City' => 'London',
        'State' => 'England',
        'PostalCode' => '00707',
        'PhoneNumber' => '7707007007',
        'Photo' => nil
      }
    ]
  end

  before do
    allow(mock_client).to receive(:active?).and_return true
    allow(LobbytrackReport).to receive(:client).and_return(mock_client)
  end

  describe 'get#index', type: :lobbytrack_reports do
    before do
      stub_current_user(create(:authorized_user))
    end

    it 'gets the input form page' do
      get :index
      expect(response).to render_template 'index'
    end
  end

  describe 'post#visits', type: :lobbytrack_reports do
    before do
      stub_current_user(create(:authorized_user))
    end

    context 'when there is a visit id' do
      let(:lobbytrack_reports) do
        {
          'CardHolderID' => '1007007',
          'DateIn' => '2018-08-31 09 :19:39 -0700'
        }
        {
          'CardHolderID' => '1007007',
          'DateIn' => '2018-09-13 15 :05:56 -0700'
        }
      end

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
      end

      it 'shows the visits result page' do
        post :visits, params: { lobbytrack_report: { visit_id: '1007007' } }
        expect(response).to render_template 'visits'
      end
    end

    context 'when the visit id is empty or not found' do
      let(:lobbytrack_reports) { [] }
      let(:lobbytrack_visitor) { [] }

      before do
        allow(mock_client).to receive(:execute).and_return(lobbytrack_visitor, lobbytrack_reports)
        post :visits, params: { lobbytrack_report: { visit_id: '000' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a TinyTds Error' do
        expect(flash[:error]).to be_a_kind_of(TinyTds::Error)
      end

      it 'displays a flash message' do
        expect(flash[:error].message).to eq 'No ID found for visitor 000'
      end
    end

    context 'when the visit id is invalid' do
      before do
        post :visits, params: { lobbytrack_report: { visit_id: "' OR 1=1" } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a flash message' do
        expect(flash[:error]).to eq 'Invalid ID entered.'
      end
    end

    context 'when the visit query returns empty data' do
      let(:lobbytrack_reports) { [] }

      before do
        allow(mock_client).to receive(:execute).and_return(lobbytrack_visitor, lobbytrack_reports)
        post :visits, params: { lobbytrack_report: { visit_id: '7007007' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a TinyTds Error' do
        expect(flash[:error]).to be_a_kind_of(TinyTds::Error)
      end

      it 'displays a flash message' do
        expect(flash[:error].message).to eq 'There is no attendance history for id 7007007'
      end
    end
  end

  describe 'post#visit_dates', type: :lobbytrack_reports do
    before do
      stub_current_user(create(:authorized_user))
    end

    context 'when there are results with in the date range' do
      let(:lobbytrack_reports) do
        {
          'CardHolderID' => '1007007',
          'DateIn' => '2018-08-31 09 :19:39 -0700'
        }
        {
          'CardHolderID' => '1007007',
          'DateIn' => '2018-09-13 15 :05:56 -0700'
        }
      end

      before do
        allow(mock_client).to receive(:execute).and_return(lobbytrack_visitor, lobbytrack_reports)
      end

      it 'shows the visit dates result page' do
        post :visit_dates, params: { lobbytrack_report: { visit_date1: '2019-01-01', visit_date2: '2020-01-01' } }
        expect(response).to render_template 'visit_dates'
      end
    end

    context 'when no results' do
      let(:lobbytrack_reports) { [] }

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
        post :visit_dates, params: { lobbytrack_report: { visit_date1: '2019-01-01', visit_date2: '2020-01-01' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a TinyTds Error' do
        expect(flash[:error]).to be_a_kind_of(TinyTds::Error)
      end

      it 'displays a flash message' do
        expect(flash[:error].message).to eq 'There is no attendance history between the dates 2019-01-01 and 2020-01-01'
      end
    end

    context 'with a invalid dates' do
      before do
        post :visit_dates, params: { lobbytrack_report: { visit_date1: "' OR 1=1'", visit_date2: '' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a flash message' do
        expect(flash[:error]).to eq 'Invalid date entered.'
      end
    end
  end

  describe 'get#checkins', type: :lobbytrack_reports do
    before do
      stub_current_user(create(:authorized_user))
    end

    context 'when the checkin id is valid' do
      let(:lobbytrack_reports) do
        {
          'CardHolderID' => '1007007',
          'DateIn' => '2018-08-31 09 :19:39 -0700'
        }
        {
          'CardHolderID' => '1007007',
          'DateIn' => '2018-09-13 15 :05:56 -0700'
        }
      end

      before do
        allow(controller).to receive(:checkins).and_return(lobbytrack_reports)
      end

      it 'gets the checkins page' do
        post :checkins, params: { lobbytrack_report: { checkin_id: '1007007' } }
        expect(response).to render_template 'checkins'
      end
    end

    context 'when the checkin id is empty or not found' do
      let(:lobbytrack_reports) { [] }

      before do
        allow(mock_client).to receive(:execute).and_return(lobbytrack_visitor, lobbytrack_reports)
        post :checkins, params: { lobbytrack_report: { checkin_id: '1000777' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a TinyTds Error' do
        expect(flash[:error]).to be_a_kind_of(TinyTds::Error)
      end

      it 'displays a flash message' do
        expect(flash[:error].message).to eq 'There is no attendance history for id 1000777'
      end
    end

    context 'when the checkin id is invalid' do
      before do
        post :checkins, params: { lobbytrack_report: { checkin_id: "' OR 1=1" } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a flash message' do
        expect(flash[:error]).to eq 'Invalid ID entered.'
      end
    end

    context 'when the checkin query returns empty data' do
      let(:lobbytrack_reports) { [] }

      before do
        allow(mock_client).to receive(:execute).and_return(lobbytrack_visitor, lobbytrack_reports)
        post :checkins, params: { lobbytrack_report: { checkin_id: '7007007' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a TinyTds Error' do
        expect(flash[:error]).to be_a_kind_of(TinyTds::Error)
      end

      it 'displays a flash message' do
        expect(flash[:error].message).to eq 'There is no attendance history for id 7007007'
      end
    end
  end

  describe 'post#checkin_dates', type: :lobbytrack_reports do
    before do
      stub_current_user(create(:authorized_user))
    end

    context 'when there are results with in the date range' do
      let(:lobbytrack_reports) do
        {
          'CardHolderID' => '1007007',
          'DateOfEvent' => '2018-08-31 09 :19:39 -0700'
        }
        {
          'CardHolderID' => '1007007',
          'DateOfEvent' => '2018-09-13 15 :05:56 -0700'
        }
      end

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
      end

      it 'shows the visit dates result page' do
        post :checkin_dates, params: { lobbytrack_report: { checkin_date1: '2019-01-01', checkin_date2: '2020-01-01' } }
        expect(response).to render_template 'checkin_dates'
      end
    end

    context 'when no results' do
      let(:lobbytrack_reports) { [] }

      before do
        allow(mock_client).to receive(:execute).and_return lobbytrack_reports
        post :checkin_dates, params: { lobbytrack_report: { checkin_date1: '2019-01-01', checkin_date2: '2020-01-01' } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a TinyTds Error' do
        expect(flash[:error]).to be_a_kind_of(TinyTds::Error)
      end

      it 'displays a flash message' do
        expect(flash[:error].message).to eq 'There is no attendance history between the dates 2019-01-01 and 2020-01-01'
      end
    end

    context 'with a invalid dates' do
      before do
        post :checkin_dates, params: { lobbytrack_report: { checkin_date1: '', checkin_date2: "' OR 1=1'" } }
      end

      it 'returns to the lobbytrack reports page' do
        expect(response).to redirect_to lobbytrack_reports_path
      end

      it 'displays a flash message' do
        expect(flash[:error]).to eq 'Invalid date entered.'
      end
    end
  end
end
# rubocop:enable Lint/Void, Metrics/BlockLength
