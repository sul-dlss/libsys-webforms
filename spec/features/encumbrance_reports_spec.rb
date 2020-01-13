require 'rails_helper'

describe 'Encumbrance Reports Page', type: :feature do
  before do
    visit new_encumbrance_report_path
  end

  it 'renders the hidden field for date_request' do
    attribute = page.find('#encumbrance_report_date_request', visible: false).value
    time = Time.zone.parse(attribute)
    now = Time.zone.parse(I18n.l(Time.now.getlocal, format: :oracle))
    expect(time.strftime('%F %R')).to eq now.strftime('%F %R')
  end
end
