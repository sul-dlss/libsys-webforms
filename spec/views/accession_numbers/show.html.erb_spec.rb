require 'rails_helper'

RSpec.describe 'accession_numbers/show' do
  before do
    @accession_number = assign(:accession_number, AccessionNumber.create!(
                                                    resource_type: 'Type of resource',
                                                    item_type: 'Type of material',
                                                    location: 'Location',
                                                    prefix: 'Prefix',
                                                    seq_num: 2
                                                  ))

    render
  end

  it 'renders Type of resource attribute' do
    expect(rendered).to match(/Type of resource/)
  end

  it 'renders Type of material attribute' do
    expect(rendered).to match(/Type of material/)
  end

  it 'renders Location attribute' do
    expect(rendered).to match(/Location/)
  end

  it 'renders Prefix attribute' do
    expect(rendered).to match(/Prefix/)
  end

  it 'renders attribute' do
    expect(rendered).to match(/2/)
  end

  it 'has a link back to the accession number menu' do
    assert_select 'a', text: 'Back', href: '/accession_number_updates'
  end
end
