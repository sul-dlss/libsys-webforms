require 'rails_helper'

RSpec.describe 'packages/index', type: :view do
  before(:each) do
    @package = FactoryBot.create(:package)
  end

  # it 'renders a list of packages' do
  #   render
  # end
end
