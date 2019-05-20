require 'rails_helper'

RSpec.describe 'accession_numbers/new', type: :view do
  before(:each) do
    assign(:accession_number, AccessionNumber.new(
                                item_type: 'MyString',
                                location: 'MyString',
                                prefix: 'MyString'
                              ))
  end

  it 'renders new accession_number form' do
    render

    assert_select 'form[action=?][method=?]', accession_numbers_path, 'post' do
      assert_select 'select#accession_number_resource_type[name=?]', 'accession_number[resource_type]'
      assert_select 'input#accession_number_item_type[name=?]', 'accession_number[item_type]'
      assert_select 'input#accession_number_location[name=?]', 'accession_number[location]'
      assert_select 'input#accession_number_prefix[name=?]', 'accession_number[prefix]'
    end
  end
end
