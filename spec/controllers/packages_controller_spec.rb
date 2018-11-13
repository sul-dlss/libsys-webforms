require 'rails_helper'

RSpec.describe PackagesController, type: :controller do
  describe 'GET #index' do
    it 'assigns all packages as @packages' do
      get :index
      expect(response).to be_successful
    end
  end
  describe 'GET #new' do
    it 'assigns a new package' do
      get :new
      expect(response).to render_template('new')
    end
  end
  describe 'GET #show' do
    it 'shows the package details' do
      @package = FactoryBot.create(:package)
      get :show, id: @package
      expect(response).to render_template('show')
    end
  end
  describe 'POST #create' do
    let(:attributes) do
      { package_name: 'name', package_status: 'Inactive', vendor_name: 'vend', data_pickup_type: 'some' }
    end
    context 'with valid params' do
      it 'creates a new Package' do
        expect { post(:create, package: attributes) }.to change(Package, :count).by(1)
      end
      it 'redirects to the created package' do
        post :create, package: attributes
        expect(response).to redirect_to(Package.last)
      end
    end
    context 'with invalid params' do
      it "re-renders the 'new' template" do
        post :create, package: { package_name: '', vendor_name: '', data_pickup_type: '' }
        expect(response).to render_template('new')
      end
    end
  end
  describe 'PUT #update' do
    let(:valid_attributes) do
      { package_name: 'different name', package_status: 'Inactive',
        vendor_name: 'different vend', data_pickup_type: 'some other' }
    end
    let(:invalid_attributes) { { package_name: '', package_status: 'Active', vendor_name: '', data_pickup_type: '' } }
    context 'with valid params' do
      it 'updates the requested package' do
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: valid_attributes
        package.reload
      end
      it 'updates match_opts' do
        valid_attributes.update(match_opts: ['0', '020', '0', '776_isbn', '0', '0', '0'])
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: valid_attributes
        package.reload
        expect(Package.find(package[:id]).match_opts).to eq('020,776_isbn')
      end
      it 'updates access_urls_plats as tab- and pipe-delimited string' do
        valid_attributes.update(url_substring: ['ieeexplore.ieee.org', ''],
                                link_text: ['IEEE Xplore Digital Library', ''],
                                provider_name: ['IEEE', ''],
                                collection_name: ['MIT Press eBooks', ''],
                                access_type: ['purchased', ''])
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: valid_attributes
        package.reload
        expect(Package.find(package[:id]).access_urls_plats).to eq("ieeexplore.ieee.org\tIEEE Xplore Digital Library\tIEEE\tMIT Press eBooks\tpurchased|")
      end
      it 'updates ftp_file_prefix when eloader searches for files on ftp server checkbox is unchecked' do
        valid_attributes.update(no_ftp_search: '0')
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: valid_attributes
        package.reload
        expect(Package.find(package[:id]).ftp_file_prefix).to eq('NO FTP SEARCH ***')
      end
      it 'redirects to the package' do
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: valid_attributes
        expect(response).to redirect_to(package)
      end
    end
    context 'with invalid params' do
      it "re-renders the 'edit' template" do
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: invalid_attributes
        expect(response).to render_template('edit')
      end
    end
  end
  describe 'activate a package' do
    let(:active) do
      { package_name: 'different name', package_status: 'Active',
        vendor_name: 'different vend', data_pickup_type: 'some other' }
    end
    it 'updates a package status and redirects to home' do
      package = FactoryBot.create(:package)
      put :activate, id: package[:id], package: active
      expect(Package.find(package[:id]).package_status).to eq('Active')
    end
  end
  describe 'deactivate a package' do
    let(:inactive) do
      { package_name: 'different name', package_status: 'Inactive',
        vendor_name: 'different vend', data_pickup_type: 'some other' }
    end
    it 'updates a package status and redirects to home' do
      package = FactoryBot.create(:package)
      put :deactivate, id: package[:id], package: inactive
      expect(Package.find(package[:id]).package_status).to eq('Inactive')
    end
  end
  describe 'DELETE #destroy' do
    before :each do
      @package = FactoryBot.create(:package)
    end
    it 'destroys the requested package' do
      expect { delete :destroy, id: @package[:id] }.to change(Package, :count).by(-1)
    end
    it 'redirects to the package list' do
      delete :destroy, id: @package[:id]
      expect(response).to redirect_to(:packages)
    end
  end
end
