require 'rails_helper'

RSpec.describe 'packages/show', type: :view do
  before(:each) do
    @package = FactoryBot.create(:package)
  end

  it 'renders attributes in <li>' do
    render @package
  end
end
