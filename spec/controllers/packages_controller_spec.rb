require 'rails_helper'

RSpec.describe PackagesController, type: :controller do
  describe 'GET #index' do
    it 'assigns all packages as @packages' do
      get :index
      expect(response).to be_successful
    end
  end
  describe 'GET #new' do
    it 'assigns a new package as @package' do
      @package = FactoryBot.create(:package)
      get :new
      expect(response).to render_template('new')
      expect(@package).to be_a(Package)
    end
  end
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Package' do
        expect do
          post :create, package: { package_name: 'name', package_status: 'Inactive',
                                   vendor_name: 'vend', data_pickup_type: 'some' }
        end.to change(Package, :count).by(1)
      end
      it 'assigns a newly created package as @package' do
        post :create, package: { package_name: 'name', package_status: 'Inactive',
                                 vendor_name: 'vend', data_pickup_type: 'some' }
        expect(assigns(:package)).to be_a(Package)
        expect(assigns(:package)).to be_persisted
      end
      it 'redirects to the created package' do
        post :create, package: { package_name: 'name', package_status: 'Inactive',
                                 vendor_name: 'vend', data_pickup_type: 'some' }
        expect(response).to redirect_to(Package.last)
      end
    end
    context 'with invalid params' do
      it 'assigns a newly created but unsaved package as @package' do
        post :create, package: { package_name: '', vendor_name: '', data_pickup_type: '' }
        expect(assigns(:package)).to be_a(Package)
      end
      it "re-renders the 'new' template" do
        post :create, package: { package_name: '', vendor_name: '', data_pickup_type: '' }
        expect(response).to render_template('new')
      end
    end
  end
  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested package' do
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: { package_name: 'different name',
                                                  package_status: 'Inactive',
                                                  vendor_name: 'different vend',
                                                  data_pickup_type: 'some other' }
        package.reload
      end
      it 'assigns the requested package as @package' do
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: { package_name: 'different name',
                                                  package_status: 'Inactive',
                                                  vendor_name: 'different vend',
                                                  data_pickup_type: 'some other' }
        expect(assigns(:package)).to eq(package)
      end
      it 'redirects to the package' do
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: { package_name: 'different name',
                                                  package_status: 'Inactive',
                                                  vendor_name: 'different vend',
                                                  data_pickup_type: 'some other' }
        expect(response).to redirect_to(package)
      end
    end
    context 'with invalid params' do
      it 'assigns the package as @package' do
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: { package_name: '',
                                                  package_status: 'Active',
                                                  vendor_name: '',
                                                  data_pickup_type: '' }
        expect(assigns(:package)).to eq(package)
      end
      it "re-renders the 'edit' template" do
        package = FactoryBot.create(:package)
        put :update, id: package[:id], package: { package_name: '',
                                                  package_status: 'Active',
                                                  vendor_name: '',
                                                  data_pickup_type: '' }
        expect(response).to render_template('edit')
      end
    end
  end
  describe 'activate a package' do
    it 'updates a package status and redirects to home' do
      package = FactoryBot.create(:package)
      patch :activate, id: package[:id], package: { package_name: 'different name',
                                                    package_status: 'Active',
                                                    vendor_name: 'different vend',
                                                    data_pickup_type: 'some other' }
      expect(Package.find(package[:id]).package_status).to eq('Active')
    end
  end
  describe 'activate a package' do
    it 'updates a package status and redirects to home' do
      package = FactoryBot.create(:package)
      patch :deactivate, id: package[:id], package: { package_name: 'different name',
                                                      package_status: 'Inactive',
                                                      vendor_name: 'different vend',
                                                      data_pickup_type: 'some other' }
      expect(Package.find(package[:id]).package_status).to eq('Inactive')
    end
  end
  describe 'DELETE #destroy' do
    it 'destroys the requested package' do
      package = FactoryBot.create(:package)
      expect do
        delete :destroy, id: package[:id]
      end.to change(Package, :count).by(-1)
    end

    it 'redirects to the package list' do
      package = FactoryBot.create(:package)
      delete :destroy, id: package[:id]
      expect(response).to redirect_to(:packages)
    end
  end
end
