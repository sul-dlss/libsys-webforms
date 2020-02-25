require 'rails_helper'

describe 'Expenditure Reports Page', type: :feature do
  before do
    stub_current_user(FactoryBot.create(:authorized_user))
    visit new_expenditure_report_path
  end

  it 'renders the hidden field for date_request' do
    attribute = page.find('#expenditure_report_date_request', visible: false).value
    time = Time.zone.parse(attribute)
    now = Time.zone.parse(I18n.l(Time.now.getlocal, format: :oracle))
    expect(time.strftime('%F %R')).to eq now.strftime('%F %R')
  end
end
