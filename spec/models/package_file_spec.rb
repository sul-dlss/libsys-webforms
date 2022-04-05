require 'rails_helper'

RSpec.describe PackageFile, type: :model do
  before do
    @package_file = create(:package_file)
  end

  it 'has a valid factory' do
    expect(@package_file).to be_valid
  end
end
