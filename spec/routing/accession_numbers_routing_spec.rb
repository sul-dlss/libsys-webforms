require 'rails_helper'

RSpec.describe AccessionNumbersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/accession_numbers').to route_to('accession_numbers#index')
    end

    it 'routes to #new' do
      expect(get: '/accession_numbers/new').to route_to('accession_numbers#new')
    end

    it 'routes to #show' do
      expect(get: '/accession_numbers/1').to route_to('accession_numbers#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/accession_numbers/1/edit').to route_to('accession_numbers#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/accession_numbers').to route_to('accession_numbers#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/accession_numbers/1').to route_to('accession_numbers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/accession_numbers/1').to route_to('accession_numbers#update', id: '1')
    end

    it 'routes to #generate_number' do
      expect(get: '/accession_numbers/1/generate_number').to route_to('accession_numbers#generate_number', id: '1')
    end
  end
end
