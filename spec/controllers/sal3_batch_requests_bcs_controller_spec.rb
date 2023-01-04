require 'rails_helper'

RSpec.describe Sal3BatchRequestsBcsController do
  before do
    stub_current_user(create(:authorized_user))
  end

  let(:barcode_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('files/test_file.txt', 'text/plain')
  end

  describe 'get#show' do
    it 'is successful returning a show page' do
      @sal3_batch_requests_batch = Sal3BatchRequestsBatch.create!(bc_file: barcode_file,
                                                                  pseudo_id: 'MAPSCANLAB',
                                                                  batch_pullmon: 1,
                                                                  batch_startdate: Time.zone.today,
                                                                  batch_needbydate: Time.zone.today + 30)
      get 'show', params: { id: @sal3_batch_requests_batch }
      expect(response).to render_template('show')
    end
  end
end
