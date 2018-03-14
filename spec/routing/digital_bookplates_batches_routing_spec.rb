require 'rails_helper'

RSpec.describe DigitalBookplatesBatchesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/digital_bookplates_batches').to route_to('digital_bookplates_batches#index')
    end

    it 'routes to #add_batch' do
      expect(get: '/digital_bookplates_batches/new/add_batch').to route_to('digital_bookplates_batches#add_batch')
    end

    it 'routes to #delete_batch' do
      expect(get: '/digital_bookplates_batches/new/delete_batch').to route_to('digital_bookplates_batches#delete_batch')
    end

    it 'routes to #create' do
      expect(post: '/digital_bookplates_batches').to route_to('digital_bookplates_batches#create')
    end

    it 'routes to #queue' do
      expect(get: '/digital_bookplates_batches/queue').to route_to('digital_bookplates_batches#queue')
    end

    it 'routes to #completed' do
      expect(get: '/digital_bookplates_batches/completed').to route_to('digital_bookplates_batches#completed')
    end

    it 'routes to #destroy' do
      expect(delete: '/digital_bookplates_batches/1').to route_to('digital_bookplates_batches#destroy', id: '1')
    end
  end
end
