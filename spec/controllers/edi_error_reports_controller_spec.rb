require 'rails_helper'

RSpec.describe EdiErrorReportsController, type: :controller do
  before do
    stub_current_user(create(:authorized_user))
    @edi_error_report = create(:edi_error_report)
  end

  describe 'get#index' do
    it 'be successful returning the index page' do
      get :index
      expect(response).to be_successful
    end

    it 'be unsuccessful returning the index page' do
      get :index, params: { day: '2012' }
      expect(controller).to redirect_to(edi_error_reports_path)
    end
  end
end
