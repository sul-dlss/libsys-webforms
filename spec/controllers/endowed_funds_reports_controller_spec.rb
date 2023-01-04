require 'rails_helper'

RSpec.describe EndowedFundsReportsController do
  before do
    stub_current_user(create(:authorized_user))
  end

  describe 'get#new' do
    it 'renders the correct template' do
      stub_current_user(create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'post#create gets a set of catalog keys' do
    context 'when there are keys returned from the Expenditires table' do
      before do
        %w(123 456 789).each do |ckey|
          create(:expenditures, ol_cat_key: ckey)
        end
      end

      let(:params) do
        {
          fund: %w(1065089-103-AABNK), fy_start: 'FY 2010', fy_end: 'FY 2011', email: 'some@one.com',
          date_type: 'fiscal', report_format: 'n', ckeys_file: 'endow123.txt'
        }
      end

      it 'redirects to root_url if create returns and writes ckeys and is successful' do
        post :create, params: { endowed_funds_report: params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'no ckeys found for query' do
    let(:params) do
      {
        fund: %w(1065089-103-AABNK), fy_start: 'FY 1810', fy_end: 'FY 1811', email: 'some@one.com',
        date_type: 'fiscal', report_format: 'n', ckeys_file: 'endow123.txt'
      }
    end

    it 'renders a new template' do
      post :create, params: { endowed_funds_report: params }
      expect(response).to render_template('new')
    end

    it 'flashes an error message' do
      post :create, params: { endowed_funds_report: params }
      expect(flash[:error]).to eq 'Could not find catalog keys for the date range selected'
    end
  end

  describe 'invalid parameters' do
    let(:params) do
      {
        fund: '', fy_start: '', fy_end: '', email: '',
        date_type: 'fiscal', report_format: 'n', ckeys_file: 'endow123.txt'
      }
    end

    it 'renders a new template' do
      post :create, params: { endowed_funds_report: params }
      expect(response).to render_template('new')
    end

    it 'flashes a warning message' do
      post :create, params: { endowed_funds_report: params }
      expect(flash[:warning]).to eq 'Check that all form fields are entered'
    end
  end
end
