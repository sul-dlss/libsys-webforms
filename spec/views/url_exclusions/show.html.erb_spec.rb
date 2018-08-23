require 'rails_helper'

RSpec.describe 'url_exclusions/show', type: :view do
  before(:each) do
    @url_exclusion = assign(:url_exclusion, UrlExclusion.create!(
                                              url_substring: 'Url Substring'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Url Substring/)
  end
end
