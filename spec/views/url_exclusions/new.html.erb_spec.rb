require 'rails_helper'

RSpec.describe 'url_exclusions/new', type: :view do
  before(:each) do
    assign(:url_exclusion, UrlExclusion.new(
                             url_substring: 'MyString'
    ))
  end

  it 'renders new url_exclusion form' do
    render

    assert_select 'form[action=?][method=?]', url_exclusions_path, 'post' do
      assert_select 'input#url_exclusion_url_substring[name=?]', 'url_exclusion[url_substring]'
    end
  end
end
