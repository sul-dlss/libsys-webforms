require 'rails_helper'

RSpec.describe 'url_exclusions/edit', type: :view do
  before(:each) do
    @url_exclusion = assign(:url_exclusion, UrlExclusion.create!(
                                              url_substring: 'MyString'
    ))
  end

  it 'renders the edit url_exclusion form' do
    render

    assert_select 'form[action=?][method=?]', url_exclusion_path(@url_exclusion), 'post' do
      assert_select 'input#url_exclusion_url_substring[name=?]', 'url_exclusion[url_substring]'
    end
  end
end
