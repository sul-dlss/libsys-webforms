require 'rails_helper'

describe 'Expenditures With Circ Stats Reports Page' do
  before do
    stub_current_user(create(:authorized_user))
    visit new_expenditures_with_circ_stats_report_path
  end

  it 'renders the hidden field for date_request' do
    attribute = page.find_by_id('expenditures_with_circ_stats_report_date_request', visible: false).value
    time = Time.zone.parse(attribute)
    now = Time.zone.parse(I18n.l(Time.now.getlocal, format: :oracle))
    expect(time.strftime('%F %R')).to eq now.strftime('%F %R')
  end
end
