require 'rails_helper'

RSpec.describe 'sal3_batch_requests_batches/edit', type: :view do
  let(:barcode_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('files/test_file.txt', 'text/plain')
  end

  before do
    assign(:sal3_batch_requests_batch, Sal3BatchRequestsBatch.create!(
                                         id: 1,
                                         batch_id: '1',
                                         user_sunetid: 'some-id',
                                         load_date: '16-06-14',
                                         batch_startdate: '16-06-18',
                                         batch_needbydate: '16-06-20',
                                         batch_pullmon: 1,
                                         last_action_date: nil,
                                         bc_file_obj: barcode_file
    ))
  end

  it 'renders the edit sal3_batch_requests_batches form' do
    render
    expect(rendered).to have_link('Download barcodes file', href: '/sal3_batch_requests_batches/1/download')
  end
end
