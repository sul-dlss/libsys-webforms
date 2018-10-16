require 'rails_helper'

RSpec.describe 'packages/show', type: :view do
  before(:each) do
    @package = FactoryBot.create(:package)
    render template: 'packages/show.html.erb'
  end

  it 'should display package information in a table' do
    assert_select 'table>tbody>tr>td>strong', text: 'Package ID'.to_s
    assert_select 'table>tbody>tr>td>strong', text: 'Package name'.to_s
  end

  it 'should display label for processing rules' do
    assert_select 'table>tbody>tr>td', text: 'Merge or new'.to_s, count: 1
    assert_select 'table>tbody>tr>td', text: '776 (subfield z) to Symphony 020 or 776'.to_s, count: 1
  end

  it 'should display label for MARC encoding level' do
    assert_select 'table>tbody>tr>td', text: 'Do not replace'.to_s, count: 1
  end
end
