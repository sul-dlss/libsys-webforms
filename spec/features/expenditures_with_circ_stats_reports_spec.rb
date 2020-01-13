require 'rails_helper'

describe 'Expenditures With Circ Stats Reports Page', type: :feature do
  before do
    visit new_expenditures_with_circ_stats_report_path
  end

  it 'renders the hidden field for date_request' do
    attribute = page.find('#expenditures_with_circ_stats_report_date_request', visible: false).value
    time = Time.parse(attribute)
    now = Time.parse(I18n.l(Time.now.getlocal, format: :oracle))
    expect(time.strftime('%F %R')).to eq now.strftime('%F %R')
  end
end
