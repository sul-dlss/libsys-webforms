require 'rails_helper'

describe 'Authorized Users Edit Page' do
  describe 'delete authorized user button' do
    before do
      stub_current_user(create(:admin_user))
    end

    context 'when user is not an admin user for any app does not have current access to any apps' do
      before do
        create(:blank_user)
        visit 'authorized_users/edit/blank_user'
      end

      it 'shows the edit row for the user' do
        expect(page).to have_selector('input[value="Blank User"]')
      end

      it 'shows delete button' do
        expect(page).to have_selector('form[action="/authorized_users/delete/blank_user"]')
      end
    end

    context 'when user is an admin user for an app' do
      before do
        create(:admin_user)
        visit 'authorized_users/edit/admin_user'
      end

      it 'shows the edit row for the user' do
        expect(page).to have_selector('input[value="Admin User"]')
      end

      it 'does not show delete button' do
        expect(page).not_to have_selector('form[action="/authorized_users/delete/admin_user"]')
      end
    end

    context 'when user is a staff user for an app' do
      before do
        create(:staff_user)
        visit 'authorized_users/edit/staff_user'
      end

      it 'shows the edit row for the user' do
        expect(page).to have_selector('input[value="Staff User"]')
      end

      it 'does not show delete button' do
        expect(page).not_to have_selector('form[action="/authorized_users/delete/staff_user"]')
      end
    end
  end
end
