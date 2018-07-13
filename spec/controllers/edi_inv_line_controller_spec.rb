require 'rails_helper'

RSpec.describe EdiInvLineController, type: :controller do
  describe 'get#edit' do
    it 'is successful returning the edit view' do
      @edi_inv_line = FactoryBot.create(:edi_inv_line)
      stub_current_user(FactoryBot.create(:authorized_user))
      get 'edit', id: @edi_inv_line
      expect(response).to be_success
    end
  end
  describe 'put#update' do
    before :each do
      stub_current_user(FactoryBot.create(:authorized_user))
      @edi_inv_line = FactoryBot.create(:edi_inv_line)
    end
    it 'updated the existing edi invoice line' do
      put :update, id: @edi_inv_line, edi_inv_line: { edi_fund: 'My new string' }
      @edi_inv_line.reload
      expect(@edi_inv_line.edi_fund).to eq('My new string')
      expect(@edi_inv_line.edi_po_number).to eq('MyString')
    end
    it 'validates that a fund name must exist' do
      put :update, id: @edi_inv_line, edi_inv_line: { edi_po_number: 'YYZ123', edi_fund: '' }
      @edi_inv_line.reload
      expect(response).to render_template(:edit)
    end
  end
end
