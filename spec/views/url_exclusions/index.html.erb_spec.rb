require 'rails_helper'

RSpec.describe 'url_exclusions/index', type: :view do
  before(:each) do
    assign(:url_exclusions, [
             UrlExclusion.create!(
               url_substring: 'Url Substring'
             ),
             UrlExclusion.create!(
               url_substring: 'Url Substring'
             )
           ])
  end

  it 'renders a list of url_exclusions' do
    render
    assert_select 'tr>td', text: 'Url Substring'.to_s, count: 2
  end
end
