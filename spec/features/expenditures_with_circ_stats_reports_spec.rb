require 'rails_helper'

describe 'Expenditures With Circ Stats Reports Page', type: :feature do
  before do
    visit new_expenditures_with_circ_stats_report_path
  end

  it 'renders the hidden field for date_request' do
    attribute = page.find('#expenditures_with_circ_stats_report_date_request', visible: false).value
    expect(attribute).to eq I18n.l(Time.now.getlocal, format: :oracle)
  end
end
