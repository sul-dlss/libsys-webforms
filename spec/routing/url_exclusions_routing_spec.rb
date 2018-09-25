require 'rails_helper'

RSpec.describe UrlExclusionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/url_exclusions').to route_to('url_exclusions#index')
    end

    it 'routes to #new' do
      expect(get: '/url_exclusions/new').to route_to('url_exclusions#new')
    end

    it 'routes to #show' do
      expect(get: '/url_exclusions/1').to route_to('url_exclusions#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/url_exclusions/1/edit').to route_to('url_exclusions#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/url_exclusions').to route_to('url_exclusions#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/url_exclusions/1').to route_to('url_exclusions#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/url_exclusions/1').to route_to('url_exclusions#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/url_exclusions/1').to route_to('url_exclusions#destroy', id: '1')
    end
  end
end
