require 'rails_helper'

RSpec.describe AccessionNumbersController do
  before do
    stub_current_user(create(:authorized_user))
    @accession_number = create(:accession_number)
    @zvc_number = create(:zvc_number)
  end

  let(:valid_attributes) do
    { resource_type: 'Sound Recordings',
      item_type: 'CD',
      location: 'Music Library',
      prefix: 'MCD' }
  end
  let(:invalid_attributes) { valid_attributes.update(location: nil) }
  let(:modify_attributes) { valid_attributes.update(prefix: 'ZCD', seq_num: 2) }

  describe 'get#index' do
    it 'be succesful returning the index page' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'get#new' do
    it 'renders the correct template' do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe 'post#create' do
    it 'redirects to the created accession number on success' do
      post :create, params: { accession_number: valid_attributes }
      expect(response).to redirect_to(AccessionNumber.last)
    end

    it 'flashes notice when accession number is created' do
      post :create, params: { accession_number: valid_attributes }
      expect(flash[:notice]).to be_present
    end

    it 'assigns 0 as seq_num' do
      post :create, params: { accession_number: valid_attributes }
      expect(AccessionNumber.last.seq_num).to eq(0)
    end

    it 'renders new template on failure' do
      post :create, params: { accession_number: invalid_attributes }
      expect(response).to render_template('new')
    end
  end

  describe 'put#update' do
    it 'updates the requested accession number' do
      patch :update, params: { id: '1', accession_number: modify_attributes }
      @accession_number.reload
      expect(@accession_number.prefix).to eq 'ZCD'
    end

    it 'does not update the seq_num' do
      patch :update, params: { id: '1', accession_number: modify_attributes }
      @accession_number.reload
      expect(@accession_number.seq_num).to eq(1)
    end

    it 'renders edit template on failure' do
      patch :update, params: { id: '1', accession_number: invalid_attributes }
      expect(response).to render_template('edit')
    end
  end

  describe 'patch#generate_number' do
    it 'increments seq_num by 1' do
      patch :generate_number, params: { id: '1', accession_number: { seq_num_incrementer: '1' } }
      @accession_number.reload
      expect(@accession_number.seq_num).to eq(2)
    end

    it 'increments seq_num by 5' do
      patch :generate_number, params: { id: '1', accession_number: { seq_num_incrementer: '5' } }
      @accession_number.reload
      expect(@accession_number.seq_num).to eq(6)
    end

    it 'redirects to show the accession number' do
      get :generate_number, params: { id: '1', accession_number: { seq_num_incrementer: '1' } }
      expect(response).to redirect_to(@accession_number)
    end

    it 'displays flash message' do
      get :generate_number, params: { id: '1', accession_number: { seq_num_incrementer: '1' } }
      expect(flash[:multi_line_notice]).to eq ['Your SUL accession number: ZDVD 2']
    end

    it 'displays a list of accession numbers for a batch' do
      get :generate_number, params: { id: '1', accession_number: { seq_num_incrementer: '2' } }
      expect(flash[:multi_line_notice]).to eq ['Your SUL accession number: ZDVD 2', 'Your SUL accession number: ZDVD 3']
    end

    it 'displays message about adding BLU-RAY for ZDVD prefixes' do
      get :generate_number, params: { id: '1', accession_number: { seq_num_incrementer: '1' } }
      expect(flash[:warning]).to eq 'For Blu-ray, follow the accession number with BLU-RAY'
    end

    context 'when the accession number reaches 10100' do
      before do
        get :generate_number, params: { id: '9', accession_number: { seq_num_incrementer: '1' } }
      end

      it 'does not generate accession number if ZVC reached 10100' do
        expect(@zvc_number.seq_num).to eq(10_100)
      end

      it 'flashes an error message' do
        expect(flash[:error]).to eq 'Cannot generate accession number! The next number is already assigned.'
      end
    end
  end
end
