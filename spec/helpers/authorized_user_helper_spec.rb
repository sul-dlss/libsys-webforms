require 'rails_helper'

describe AuthorizedUserHelper do
  describe '#administrator_apps' do
    it 'returns a list of apps one can administer' do
      @authorized_user = create(:admin_user)
      expect(helper.administrator_apps(@authorized_user)).to eq(%w[unicorn_updates
                                                                   mgt_rpts
                                                                   accession_number
                                                                   digital_bookplates
                                                                   edi_inv_manage
                                                                   edi_inv_view
                                                                   package_manage])
    end
  end

  describe '#authorized_apps' do
    let(:authorized_apps) do
      %w[unicorn_updates
         direct_upload
         mgt_rpts
         ora_admin
         sal3_batch_req
         file_upload
         sal3_breq_edit
         userload_rerun
         accession_number
         digital_bookplates
         edi_inv_view
         package_manage]
    end

    it 'returns a list of authorized apps' do
      @authorized_user = create(:staff_user)
      expect(helper.authorized_apps(@authorized_user)).to eq authorized_apps
    end
  end

  describe '#apps_translation' do
    it 'returns a translated label for an app' do
      expect(helper.apps_translation('unicorn_updates')).to eq('Symphony batch updates')
    end
  end
end
