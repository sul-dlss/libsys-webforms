require 'rails_helper'

RSpec.describe Sal3BatchRequestBcsController, type: :controller do
  let(:barcode_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('files/test_file.txt', 'text/plain')
  end

  describe 'get#show' do
    it 'is successful returning a show page' do
      stub_current_user(FactoryBot.create(:authorized_user))
      @sal3_batch_requests_batch = Sal3BatchRequestsBatch.create!(bc_file: barcode_file,
                                                                  pseudo_id: 'MAPSCANLAB',
                                                                  batch_pullmon: 1,
                                                                  batch_startdate: '11-APR-18',
                                                                  batch_needbydate: '11-APR-18')
      get 'show', id: @sal3_batch_requests_batch
      expect(response).to render_template('show')
    end
  end
end
