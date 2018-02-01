require 'rails_helper'

RSpec.describe AccessionNumbersController, type: :controller do
  before(:each) do
    stub_current_user(FactoryGirl.create(:authorized_user))
    @accession_number = FactoryGirl.create(:accession_number)
    @zvc_number = FactoryGirl.create(:zvc_number)
  end

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
      post :create, accession_number: { resource_type: 'Sound Recordings',
                                        item_type: 'CD',
                                        location: 'Music Library',
                                        prefix: 'MCD' }
      expect(response).to redirect_to(AccessionNumber.last)
    end

    it 'flashes notice when accession number is created' do
      post :create, accession_number: { resource_type: 'Sound Recordings',
                                        item_type: 'CD',
                                        location: 'Music Library',
                                        prefix: 'MCD' }
      expect(flash[:notice]).to be_present
    end

    it 'assigns 0 as seq_num' do
      post :create, accession_number: { resource_type: 'Sound Recordings',
                                        item_type: 'CD',
                                        location: 'Music Library',
                                        prefix: 'MCD' }
      expect(AccessionNumber.last.seq_num).to eq(0)
    end

    it 'renders new template on failure' do
      post :create, accession_number: { resource_type: 'Visual Materials',
                                        item_type: '',
                                        location: '',
                                        prefix: '' }
      expect(response).to render_template('new')
    end
  end

  describe 'put#update' do
    it 'updates the requested accession number' do
      patch :update, id: '1', accession_number: { resource_type: 'Sound Recordings',
                                                  item_type: 'CD',
                                                  location: 'Music Library',
                                                  prefix: 'ZCD' }
      @accession_number.reload
      expect(@accession_number.resource_type).to eq 'Sound Recordings'
      expect(@accession_number.item_type).to eq 'CD'
      expect(@accession_number.location).to eq 'Music Library'
      expect(@accession_number.prefix).to eq 'ZCD'
    end
    it 'does not update the seq_num' do
      patch :update, id: '1', accession_number: { resource_type: 'Visual Materials',
                                                  item_type: 'DVD',
                                                  location: 'Media Microtext',
                                                  prefix: 'ZDVD',
                                                  seq_num: '2' }
      @accession_number.reload
      expect(@accession_number.seq_num).to eq(1)
    end
    it 'renders edit template on failure' do
      patch :update, id: '1', accession_number: { resource_type: 'Visual Materials',
                                                  item_type: 'DVD',
                                                  location: ' ',
                                                  prefix: 'ZDVD' }
      expect(response).to render_template('edit')
    end
  end

  describe 'get#generate_number' do
    it 'increments seq_num by 1' do
      get :generate_number, id: '1'
      expect(response).to have_http_status(302)
      @accession_number.reload
      expect(@accession_number.seq_num).to eq(2)
    end
    it 'redirects to show the accession number' do
      get :generate_number, id: '1'
      expect(response).to redirect_to(@accession_number)
    end
    it 'displays flash message' do
      get :generate_number, id: '1'
      expect(flash[:notice]).to eq 'Your SUL accession number: ZDVD 2'
    end
    it 'displays message about adding BLU-RAY for ZDVD prefixes' do
      get :generate_number, id: '1'
      expect(flash[:alert]).to eq 'For Blu-ray, follow the accession number with BLU-RAY'
    end
    it 'does not generate accession number if ZVC reached 10100' do
      get :generate_number, id: '9'
      expect(flash[:error]).to eq 'Cannot generate accession number! The next number is already assigned.'
      expect(@zvc_number.seq_num).to eq(10_100)
    end
  end
end
