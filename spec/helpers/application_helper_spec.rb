require 'rails_helper'

describe ApplicationHelper do
  describe 'main_menu_button' do
    let(:button) { Capybara.string(main_menu_button) }
    it 'should render the button with a link to the root path' do
      expect(button).to have_css('button[id="main-menu-button"]')
      expect(button).to have_css('a[href="/"]')
    end
  end

  describe 'batch_menu_button' do
    let(:button) { Capybara.string(batch_menu_button) }
    it 'should render the button with a link to the batch_record_updates view' do
      expect(button).to have_css('button[id="batch-menu-button"]')
      expect(button).to have_css('a[href="/batch_record_updates"]')
    end
  end
end
