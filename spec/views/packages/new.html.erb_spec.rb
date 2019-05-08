require 'rails_helper'

RSpec.describe 'packages/new', type: :view do
  before do
    @package = FactoryBot.create(:package)
  end

  it 'renders new package form' do
    render
  end
end
