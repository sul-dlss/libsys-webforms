require 'rails_helper'

describe 'Expenditure Reports Page', type: :feature, js: true do
  before do
    stub_current_user(create(:authorized_user))
    visit new_expenditure_report_path
  end

  it 'renders the hidden field for date_request' do
    attribute = page.find('#expenditure_report_date_request', visible: false).value
    time = Time.zone.parse(attribute)
    now = Time.zone.parse(I18n.l(Time.now.getlocal, format: :oracle))
    expect(time.strftime('%F %R')).to eq now.strftime('%F %R')
  end

  it 'has a hidden warning message for selecting too many funds' do
    expect(page.find('div#fundalert', visible: false)).to be_truthy
  end

  describe 'when too many finds are selected' do
    before do
      page.find(:css, 'input#expenditure_report_fund_select_fund_name_id').click
      within(:css, 'div.table-container') do
        page.all(:css, 'input[type="checkbox"]').each_with_index { |checkbox, index| checkbox.click if index < 10 }
      end
    end

    it 'shows the warning message when too many funds are selected' do
      alert = page.find('div#fundalert',
                        visible: true,
                        text: 'Warning! Too many individual funds selected. Please select fewer funds.')
      expect(alert).to be_truthy
    end

    it 'disables the submit button' do
      submit_button_disabled = page.find('input[name="commit"]')[:disabled]
      expect(submit_button_disabled).to be_truthy
    end
  end
end
