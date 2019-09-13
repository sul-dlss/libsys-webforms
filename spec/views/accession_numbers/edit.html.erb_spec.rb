require 'rails_helper'

RSpec.describe 'accession_numbers/edit', type: :view do
  before do
    @accession_number = assign(:accession_number, AccessionNumber.create!(
                                                    item_type: 'MyString',
                                                    location: 'MyString',
                                                    prefix: 'MyString'
                                                  ))
  end

  it 'renders the edit accession_number form' do
    render

    assert_select 'form[action=?][method=?]', accession_number_path(@accession_number), 'post' do
      assert_select 'select#accession_number_resource_type[name=?]', 'accession_number[resource_type]'
      assert_select 'input#accession_number_item_type[name=?]', 'accession_number[item_type]'
      assert_select 'input#accession_number_location[name=?]', 'accession_number[location]'
      assert_select 'input#accession_number_prefix[name=?]', 'accession_number[prefix]'
    end
  end
end
