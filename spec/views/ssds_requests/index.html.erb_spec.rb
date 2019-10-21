require 'rails_helper'

RSpec.describe 'ssds_requests/index.html.erb', type: :view do
  let(:ssds_request_params) do
    {
      title_in: 'School for Gifted Youngsters',
      unicorn_id_in: '510163',
      name: 'Jean Grey',
      phone: '650-123-4567',
      sunet: 'sunet_id',
      dataset_type: 'TAPE',
      department: 'Sociology',
      affiliation: 'Staff',
      sponsor: 'Professor X',
      call_no_in: 'TAPE NO. AS1999 ETC',
      notes: 'note'
    }
  end

  before do
    assign(:ssds_request, SsdsRequest.new(ssds_request_params))
  end

  describe 'request details' do
    before { render }

    it 'shows the Requestor' do
      assert_select 'p', text: 'Requestor: Jean Grey', count: 1
    end

    it 'shows theDataset type' do
      assert_select 'p', text: 'Dataset type: TAPE', count: 1
    end

    it 'shows the Dataset number' do
      assert_select 'p', text: 'Dataset number: TAPE NO. AS1999 ETC', count: 1
    end

    it 'shows the Dataset title' do
      assert_select 'p', text: 'Dataset title: School for Gifted Youngsters', count: 1
    end

    it 'shows the catalog key' do
      assert_select 'p', text: 'Catalog key: 510163', count: 1
    end

    it 'shows the NOtes' do
      assert_select 'p', text: 'Notes: note', count: 1
    end

    it 'shows an email link' do
      assert_select 'a', text: 'Contact SSRC', count: 1
      assert_select 'a[href="mailto:consult-data@lists.stanford.edu"]', count: 1
    end

    it 'shows a Searchworks link' do
      assert_select 'a[href="/510163"]', count: 1
    end
  end
end
