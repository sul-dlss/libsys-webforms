require 'rails_helper'

RSpec.describe 'packages/new' do
  before do
    @package = create(:package)
  end

  it 'renders new package form' do
    render
  end
end
