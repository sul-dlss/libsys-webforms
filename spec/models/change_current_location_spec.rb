require 'rails_helper'

RSpec.describe ChangeCurrentLocation, type: :model do
  describe '#parse_uploaded_file' do
    let(:barcode_file) do
      extend ActionDispatch::TestProcess
      fixture_file_upload('files/test_file.txt', 'text/plain')
    end
    it 'returns an array from a string of ids' do
      change_item_type = ChangeCurrentLocation.new
      change_item_type.item_ids = barcode_file
      expect(change_item_type.parse_uploaded_file).to be_kind_of(Array)
    end
  end

  describe 'valid email' do
    it 'passes the email validation with valid email string' do
      change_location = ChangeCurrentLocation.new
      change_location.email = 'one@one.com two@two.ca;three@four.net, five@six.com seven@eight.it'
      change_location.valid?
      expect(change_location.errors[:email]).not_to include('is invalid')
    end
    it 'passes the email validation with empty email string' do
      change_location = ChangeCurrentLocation.new
      change_location.email = ''
      change_location.valid?
      expect(change_location.errors[:email]).not_to include('is invalid')
    end
    it 'fails the email validation with invalid email string' do
      change_location = ChangeCurrentLocation.new
      change_location.email = 'one@one.comtwo@two.ca;three@four.net, five@six seven@eight.it'
      change_location.valid?
      expect(change_location.errors[:email]).to include('is invalid')
    end
  end
end
