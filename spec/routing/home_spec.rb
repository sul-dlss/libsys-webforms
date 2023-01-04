require 'rails_helper'

RSpec.describe 'Home routing' do
  describe 'home page' do
    it 'routes appropriately' do
      expect(get: '/').to route_to(
        controller: 'home',
        action: 'index'
      )
    end
  end
end
