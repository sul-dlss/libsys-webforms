require 'rails_helper'

RSpec.describe 'accession_numbers/show', type: :view do
  before(:each) do
    stub_current_user_for_view { FactoryBot.create(:authorized_user) }
    @accession_number = assign(:accession_number, AccessionNumber.create!(
                                                    resource_type: 'Type of resource',
                                                    item_type: 'Type of material',
                                                    location: 'Location',
                                                    prefix: 'Prefix',
                                                    seq_num: 2
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Type of resource/)
    expect(rendered).to match(/Type of material/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Prefix/)
    expect(rendered).to match(/2/)
  end

  it 'has a link back to the accession number menu' do
    render
    assert_select 'a', text: 'Accession number menu'.to_s, href: '/accession_number_updates'.to_s
  end
end
