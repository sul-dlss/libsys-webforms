require 'rails_helper'

describe 'home/index', type: :view do
  it 'should have title and links' do
    stub_current_user_for_view { FactoryBot.create(:authorized_user) }
    stub_user_id_for_view { FactoryBot.create(:authorized_user) }
    render
    expect(rendered).to have_css('h1', text: 'SUL Staff Web Forms')
    expect(rendered).to have_css('h3', text: 'What would you like to do?')
  end
  describe 'non-authorized user' do
    it 'should not display page sections' do
      stub_current_user_for_view {}
      stub_user_id_for_view {}
      render
      expect(rendered).to_not have_css('h3', text: 'What would you like to do?')
      expect(rendered).to have_css('div', text: 'You do not have permissions to use other staff web forms.')
      expect(rendered).to have_link('Ckey to Bibframe Conversion', href: '/ckey2bibframes/new')
    end
  end
end
