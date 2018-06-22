require 'rails_helper'

RSpec.describe 'edi_invoices/index', type: :view do
  context 'any user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:blank_user) }
      render
    end
    it 'should display the page header' do
      assert_select 'h1', text: 'EDIFACT invoice management'.to_s
    end
  end
  context 'not an authorized user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:blank_user) }
      render
    end
    it 'should display a login link' do
      assert_select 'a', text: 'Please login'.to_s,
                         href: root_path
    end
  end
  context 'authorized user' do
    before(:each) do
      stub_current_user_for_view { FactoryBot.create(:authorized_user) }
      render
    end
    it 'should display the page header' do
      assert_select 'h3', text: 'What would you like to do?'.to_s
    end
  end
end
