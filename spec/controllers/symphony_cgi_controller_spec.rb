require 'rails_helper'

class SymphonyCgiController < ApplicationController
  include SymphonyCgi
end

RSpec.describe SymphonyCgiController, type: :controller do
  let(:params) do
    {
      fund: %w(1065089-103-AABNK), fy_start: 'FY 2010', fy_end: 'FY 2011', email: 'some@one.com',
      date_type: 'fiscal', report_format: 'n', ckeys_file: 'endow123.txt'
    }
  end

  it 'constructs a connection url' do
    url = controller.send(:request_url, 'endow_rpt.cgi', params)
    expect(URI(url)).to be_kind_of URI
  end
end
