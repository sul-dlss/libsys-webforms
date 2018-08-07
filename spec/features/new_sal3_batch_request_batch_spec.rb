require 'rails_helper'

describe 'sal3_batch_requests_batches' do
  before { stub_current_user(FactoryBot.create(:authorized_user)) }
  before(:each) { visit new_sal3_batch_requests_batch_path }

  it 'displays a select list of delivery locations with tooltips' do
    expect(page).to have_xpath("//option[@title='STOP-CODE: DC']")
    expect(page).to have_xpath("//option[@title='STOP-CODE: RW']")
    expect(page).to have_xpath("//option[@title='STOP-CODE: DA']")
    expect(page).to have_xpath("//option[@title='STOP-CODE: RA']")
    expect(page).to have_xpath("//option[@title='STOP-CODE: DE']")
    expect(page).to have_xpath("//option[@title='STOP-CODE: BR']")
    expect(page).to have_xpath("//option[@title='STOP-CODE: DS']")
    expect(page).to have_xpath("//option[@title='STOP-CODE: AQ']")
  end
end
