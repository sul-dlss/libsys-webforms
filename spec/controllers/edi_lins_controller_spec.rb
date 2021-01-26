require 'rails_helper'

RSpec.describe EdiLinsController, type: :controller do
  Rails.application.load_seed
  before do
    stub_current_user(FactoryBot.create(:authorized_user))
  end

  let(:message) do
    get :update_edi_lin, params: { vendors: 'AMALIV',
                                   invoice_number: '592924',
                                   invoice_line_number: '11' }
  end

  describe 'allow a noBib entry form' do
    it 'is successful returning the form' do
      get :allow_nobib, format: :js, xhr: true
      expect(response).to render_template(:allow_nobib)
    end
  end

  describe 'update with actual table updates' do
    before do
      stub_current_user(FactoryBot.create(:authorized_user))
    end

    it 'notifies of noBib change when there is no match between edi_lin and edi_sumrz_bib' do
      controller.instance_variable_set(:@message, message)
    end
  end

  describe 'allow a Fix Duplicate Barcode entry form' do
    it 'is successful returning the form' do
      get :fix_duplicate_barcode, format: :js, xhr: true
      expect(response).to render_template(:fix_duplicate_barcode)
    end
  end

  describe 'get#index to check for duplicate barcodes' do
    context 'when there are no matching barcodes' do
      before { get :index, params: { barcode_num: '00000000000000' } }

      it 'zero barcodes are found' do
        expect(assigns(:edi_lin).size).to be 0
      end

      it 'flashes a message that there are no duplicate barcodes' do
        expect(flash).to be_present
      end

      it 'redirects to teh edi_menu' do
        expect(response).to redirect_to edi_invoices_menu_path
      end
    end

    context 'when only one matching barcode' do
      before { get :index, params: { barcode_num: '36105225172159' } }

      it 'only 1 barcode found' do
        expect(assigns(:edi_lin).size).to be < 2
      end

      it 'flashes a message that there are no duplicate barcodes' do
        expect(flash).to be_present
      end

      it 'redirects to the edi menu' do
        expect(response).to redirect_to edi_invoices_menu_path
      end
    end

    context 'with duplicate barcodes' do
      before { get :index, params: { barcode_num: '99999999999999' } }

      it 'more than one barcodes are found' do
        expect(assigns(:edi_lin).size).to be > 1
      end

      it 'redirects to the show page with the duplicate barcode param' do
        expect(response).to redirect_to '/edi_lins/show/99999999999999'
      end
    end
  end

  describe 'get#show' do
    it 'gets all the edi_lins with a given barcode' do
      get :show, params: { barcode_num: '99999999999999' }
      expect(assigns(:edi_lin).pluck(:barcode_num)).to eq [99_999_999_999_999, 99_999_999_999_999]
    end
  end

  describe 'get#edit' do
    it 'sends the params of the selected edi line to be edited' do
      get :edit, params: { vend_id: 'AMALIV', doc_num: '592924',
                           edi_lin_num: 1, edi_sublin_count: 0,
                           barcode_num: '99999999999999' }
      expect(assigns(:edi_lin).pluck(:barcode_num)).to eq [99_999_999_999_999, 99_999_999_999_999]
    end
  end

  describe 'update edi_lin with actual table updates' do
    let(:edi_lin_result) do
      get :update_edi_lin, params: { vendors: 'AMALIV',
                                     invoice_number: '592924',
                                     invoice_line_number: '11' }
    end

    let(:message) do
      patch 'update_barcode', params: { edi_lin:
                                          { new_barcode: '11111111111111', vend_id: 'AMALIV',
                                            doc_num: '592924', edi_lin_num: 1, edi_sublin_count: 0,
                                            old_barcode: '99999999999999' } }
    end

    before do
      controller.instance_variable_set(:@edi_lin_result, edi_lin_result)
      controller.instance_variable_set(:@barcode_result, message)
    end

    it 'notifies of a duplicate barcode change' do
      expect(flash).to be_present
    end

    it 'redirects to the edi invoices menu' do
      expect(response).to redirect_to edi_invoices_menu_path
    end
  end
end
