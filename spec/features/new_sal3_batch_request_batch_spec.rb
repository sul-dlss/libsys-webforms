require 'rails_helper'

describe 'Sal3 Batch Requests Batches', type: :feature do
  before do
    stub_current_user(FactoryBot.create(:authorized_user))
    visit new_sal3_batch_requests_batch_path
  end

  it 'displays a select list with DC delivery location' do
    expect(page).to have_xpath("//option[@title='STOP-CODE: DC']")
  end
  it 'displays a select list with RW delivery location' do
    expect(page).to have_xpath("//option[@title='STOP-CODE: RW']")
  end
  it 'displays a select list with DA delivery location' do
    expect(page).to have_xpath("//option[@title='STOP-CODE: DA']")
  end
  it 'displays a select list with RA delivery location' do
    expect(page).to have_xpath("//option[@title='STOP-CODE: RA']")
  end
  it 'displays a select list with DE delivery location' do
    expect(page).to have_xpath("//option[@title='STOP-CODE: DE']")
  end
  it 'displays a select list with BR delivery location' do
    expect(page).to have_xpath("//option[@title='STOP-CODE: BR']")
  end
  it 'displays a select list with DS delivery location' do
    expect(page).to have_xpath("//option[@title='STOP-CODE: DS']")
  end
  it 'displays a select list with AQ delivery location' do
    expect(page).to have_xpath("//option[@title='STOP-CODE: AQ']")
  end
  it 'displays asterisk for required field' do
    expect(page).to have_css('label', text: 'Upload barcode file*')
  end
end
