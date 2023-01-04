require 'rails_helper'

RSpec.describe PackagesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/packages').to route_to('packages#index')
    end

    it 'routes to #new' do
      expect(get: '/packages/new').to route_to('packages#new')
    end

    it 'routes to #show' do
      expect(get: '/packages/1').to route_to('packages#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/packages/1/edit').to route_to('packages#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/packages').to route_to('packages#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/packages/1').to route_to('packages#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/packages/1').to route_to('packages#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/packages/1').to route_to('packages#destroy', id: '1')
    end

    it 'routes to #run_tests' do
      expect(get: '/packages/run_tests').to route_to('packages#run_tests')
    end

    it 'routes to #list_transfer_logs' do
      expect(get: '/packages/list_transfer_logs').to route_to('packages#list_transfer_logs')
    end
  end
end
