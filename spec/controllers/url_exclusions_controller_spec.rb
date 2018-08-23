require 'rails_helper'

RSpec.describe UrlExclusionsController, type: :controller do
  describe 'GET #new' do
    it 'assigns a new url_exclusion as @url_exclusion' do
      @url_exclusion = FactoryBot.create(:url_exclusion)
      get :new
      expect(response).to render_template('new')
      expect(@url_exclusion).to be_a(UrlExclusion)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new UrlExclusion' do
        expect do
          post :create, url_exclusion: { url_substring: 'some.url.sub/string' }
        end.to change(UrlExclusion, :count).by(1)
      end

      it 'assigns a newly created url_exclusion as @url_exclusion' do
        post :create, url_exclusion: { url_substring: 'some.url.sub/string' }
        expect(assigns(:url_exclusion)).to be_a(UrlExclusion)
        expect(assigns(:url_exclusion)).to be_persisted
      end

      it 'redirects to the created url_exclusion' do
        post :create, url_exclusion: { url_substring: 'some.url.sub/string' }
        expect(response).to redirect_to(UrlExclusion)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved url_exclusion as @url_exclusion' do
        post :create, url_exclusion: { url_substring: '' }
        expect(assigns(:url_exclusion)).to be_a_new(UrlExclusion)
      end

      it "re-renders the 'new' template" do
        post :create, url_exclusion: { url_substring: '' }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested url_exclusion' do
        url_exclusion = FactoryBot.create(:url_exclusion)
        put :update, id: url_exclusion[:id], url_exclusion: { url_substring: 'some.new.url/exclusion!' }
        url_exclusion.reload
        # skip('Add assertions for updated state')
      end

      it 'assigns the requested url_exclusion as @url_exclusion' do
        url_exclusion = FactoryBot.create(:url_exclusion)
        put :update, id: url_exclusion[:id], url_exclusion: { url_substring: 'some.test.url/exclusion' }
        expect(assigns(:url_exclusion)).to eq(url_exclusion)
      end

      it 'redirects to the url_exclusion' do
        url_exclusion = FactoryBot.create(:url_exclusion)
        put :update, id: url_exclusion[:id], url_exclusion: { url_substring: 'some.test.url/exclusion' }
        expect(response).to redirect_to(url_exclusions_url)
      end
    end

    context 'with invalid params' do
      it 'assigns the url_exclusion as @url_exclusion' do
        url_exclusion = FactoryBot.create(:url_exclusion)
        put :update, id: url_exclusion[:id], url_exclusion: { url_substring: '' }
        expect(assigns(:url_exclusion)).to eq(url_exclusion)
      end

      it "re-renders the 'edit' template" do
        url_exclusion = FactoryBot.create(:url_exclusion)
        put :update, id: url_exclusion[:id], url_exclusion: { url_substring: '' }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested url_exclusion' do
      url_exclusion = FactoryBot.create(:url_exclusion)
      expect do
        delete :destroy, id: url_exclusion[:id]
      end.to change(UrlExclusion, :count).by(-1)
    end

    it 'redirects to the url_exclusions list' do
      url_exclusion = FactoryBot.create(:url_exclusion)
      delete :destroy, id: url_exclusion[:id]
      expect(response).to redirect_to(url_exclusions_url)
    end
  end
end
