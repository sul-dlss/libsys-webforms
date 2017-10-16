require 'rails_helper'

describe AuthorizedUserHelper do
  describe '#authorized_apps' do
    it 'returns a list of authorized apps' do
      @authorized_user = FactoryGirl.create(:admin_user)
      expect(helper.authorized_apps(@authorized_user)).to eq(%w[unicorn_updates
                                                                mgt_rpts
                                                                accession_number])
    end
  end
  describe '#apps_translation' do
    it 'returns a translated label for an app' do
      expect(helper.apps_translation('unicorn_updates')).to eq('Symphony batch updates')
    end
  end
end
