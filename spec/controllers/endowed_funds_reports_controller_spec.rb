require 'rails_helper'

RSpec.describe EndowedFundsReportsController, type: :controller do
  before do
    stub_current_user(FactoryBot.create(:authorized_user))
  end

  describe 'get#new' do
    it 'renders the correct template' do
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'post#create gets a set of catalog keys' do
    before { allow(controller).to receive(:keys).and_return(%w[123 456 789]) }

    it 'renders the new template if create is unsuccessful' do
      post :create, endowed_funds_report: { fund: nil, fund_begin: nil }
      expect(response).to render_template('new')
    end
    it 'redirects to root_url if create returns and writes ckeys and is successful' do
      params = { fund: ['1065032-101-KARJZ'], email: 'some@one.com',
                 pd_start: '03-OCT-96', pd_end: '30-NOV-96', report_format: 'n',
                 ckeys_file: 'endow123.txt' }

      post :create, endowed_funds_report: params
      expect(response).to redirect_to root_path
    end
    it 'creates the params for a symphony request using several fund strings and fiscal year dates' do
      params = { fund: ['1000501-1-AACIZ', '1000502-1-AACIX'], fund_begin: nil,
                 report_format: 'n', email: 'some@one.com', fy_start: 'FY 2015',
                 ckeys_file: 'endow123.txt' }

      post :create, endowed_funds_report: params
      expect(EndowedFundsReport.new(params)).to have_attributes(fy_start: 'FY 2015')
    end
    it 'creates the params for a symphony request using fund_begin string and calendar dates' do
      params = { fund: nil, fund_begin: '1000501-1-AACIZ-', report_format: 'n',
                 email: 'some@one.com', cal_start: '2015', cal_end: '2016',
                 ckeys_file: 'endow123.txt' }

      post :create, endowed_funds_report: params
      expect(controller.date_start).to eq '2015-01-01'
      expect(controller.date_end).to eq '2016-12-31'
    end
    it 'creates the params for a symphony request using fund_begin string and paid dates' do
      params = { fund: nil, fund_begin: '1000501-1-AACIZ-', report_format: 'n',
                 email: 'some@one.com', pd_start: '22-DEC-98', pd_end: '22-DEC-99',
                 ckeys_file: 'endow123.txt' }

      post :create, endowed_funds_report: params
      expect(controller.date_start).to eq '0098-12-22'
      expect(controller.date_end).to eq '0099-12-22'
    end
  end

  describe 'rescue_from RecordNotFound' do
    before { allow(controller).to receive(:funds_keys).and_raise(ActiveRecord::RecordNotFound) }
    it 'renders the correct template' do
      params = { fund: ['1065032-101-KARJZ'], email: 'some@one.com',
                 pd_start: '03-OCT-96', pd_end: '30-NOV-96', report_format: 'n',
                 ckeys_file: 'endow123.txt' }

      post :create, endowed_funds_report: params
      expect(response).to render_template('new')
    end
  end

  describe 'no ckeys found for query' do
    before { allow(controller).to receive(:keys).and_return([]) }
    it 'renders the correct template' do
      params = { fund: ['1065032-101-KARJZ'], email: 'some@one.com',
                 pd_start: '03-OCT-96', pd_end: '30-NOV-96', report_format: 'n',
                 ckeys_file: 'endow123.txt' }

      post :create, endowed_funds_report: params
      expect(response).to render_template('new')
    end
  end
end
