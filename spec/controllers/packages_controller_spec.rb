require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe PackagesController, type: :controller do
  before do
    stub_current_user(FactoryBot.create(:admin_user))
    FactoryBot.create(:package)
  end

  let(:valid_attributes) do
    { package_name: 'different name', package_status: 'Inactive',
      vendor_name: 'different vend', data_pickup_type: 'AFS', afs_path: 'somedir' }
  end
  let(:invalid_attributes) { { package_name: '', package_status: 'Active', vendor_name: '', data_pickup_type: '' } }

  describe 'GET #index' do
    it 'assigns all packages as @packages' do
      expect(get(:index)).to be_successful
    end
  end

  describe 'GET #new' do
    it 'assigns a new package' do
      expect(get(:new)).to render_template('new')
    end
  end

  describe 'GET #show' do
    it 'shows the package details' do
      expect(get(:show, params: { id: 1 })).to render_template('show')
    end
  end

  describe 'POST #create' do
    before do
      valid_attributes.update(package_id: 'id')
      post :create, params: { package: valid_attributes }
    end

    context 'with valid params' do
      it 'creates a new Package' do
        expect(Package.all.count).to eq(2)
      end

      it 'redirects to the created package' do
        expect(response).to redirect_to(Package.last)
      end

      it 'hardcodes vendor_id_write to 001' do
        expect(Package.last.vendor_id_write).to eq('001')
      end

      it 'creates value for date_entered' do
        expect(Package.find(1).date_modified.strftime('%Y-%b-%d')).to eq(Time.zone.now.strftime('%Y-%b-%d'))
      end
    end

    context 'with invalid params' do
      it "re-renders the 'new' template" do
        post :create, params: { package: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        valid_attributes.update(url_substring: ['ieeexplore.ieee.org', ''],
                                link_text: ['IEEE Xplore Digital Library', ''],
                                provider_name: ['IEEE', ''],
                                collection_name: ['MIT Press eBooks', ''],
                                access_type: ['purchased', ''],
                                match_opts: %w[0 020 0 776_isbn 0 0 0],
                                no_ftp_search: '0')
        put :update, params: { id: 1, package: valid_attributes }
      end

      it 'updates the requested package and redirects to the package' do
        expect(response).to redirect_to(@package)
      end

      it 'updates match_opts' do
        expect(Package.find(1).match_opts).to eq('020,776_isbn')
      end

      it 'updates access_urls_plats as tab- and pipe-delimited string' do
        expect(Package.find(1).access_urls_plats)
          .to eq("ieeexplore.ieee.org\tIEEE Xplore Digital Library\tIEEE\tMIT Press eBooks\tpurchased|")
      end

      it 'updates ftp_file_prefix when eloader searches for files on ftp server checkbox is unchecked' do
        expect(Package.find(1).ftp_file_prefix).to eq('NO FTP SEARCH ***')
      end

      it 'updates date_modified' do
        expect(Package.find(1).date_modified.strftime('%Y-%b-%d')).to eq(Time.zone.now.strftime('%Y-%b-%d'))
      end
    end

    context 'with invalid params' do
      it "re-renders the 'edit' template" do
        put :update, params: { id: 1, package: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'activate/deactivate a package' do
    it 'activates a package status and redirects to home' do
      put :activate, params: { id: 1 }
      expect(Package.find(1).package_status).to eq('Active')
    end

    it 'deactivates a package status and redirects to home' do
      put :deactivate, params: { id: 1 }
      expect(Package.find(1).package_status).to eq('Inactive')
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: 1 }
    end

    it 'destroys the requested package' do
      expect(Package.count).to eq 0
    end

    it 'redirects to the package list' do
      expect(response).to redirect_to(:packages)
    end
  end
end
# rubocop:enable Metrics/BlockLength
