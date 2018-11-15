require 'rails_helper'

RSpec.describe Package, type: :model do
  before do
    @package = FactoryBot.create(:package)
  end
  it 'has a valid factory' do
    expect(@package).to be_valid
  end
  it 'has an immutable package_id' do
    @package.update(package_id: 'id')
    expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(@package.errors.full_messages).to eq(['Package ID is marked as readonly.'])
  end
  it 'adds an error when afs_path is not present for AFS data_pickup_type' do
    @package.update(afs_path: '')
    expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(@package.errors.full_messages).to eq(['AFS directory path cannot be empty.'])
    expect(@package).to_not be_valid
  end
  it 'adds an error when FTP information is not present for FTP data_pickup_type' do
    @package.update(data_pickup_type: 'FTP')
    @package.update(ftp_server: '')
    expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(@package.errors.full_messages).to eq(['FTP server cannot be empty.'])
  end
  it 'adds an error when AFS and FTP information is not present for FTP to AFS data_pickup_type' do
    @package.update(data_pickup_type: 'FTP to AFS')
    @package.update(afs_path: '')
    @package.update(ftp_server: '')
    expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(@package.errors.full_messages).to eq(['AFS directory path cannot be empty.',
                                                 'FTP server cannot be empty.',
                                                 'FTP to AFS download directory path cannot be empty.'])
  end
  it 'adds an error when FTP to AFS download directory path is not present for FTP to AFS data_pickup_type' do
    @package.update(data_pickup_type: 'FTP to AFS')
    @package.update(put_file_loc: '')
    expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(@package.errors.full_messages).to eq(['FTP to AFS download directory path cannot be empty.'])
  end
  it 'adds an error when match_opts is empty but proc_type is newmerge or mergeonly' do
    @package.update(match_opts: nil)
    expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(@package.errors.full_messages).to eq(["#{Package.human_attribute_name('match_opts')} cannot be empty."])
  end
end
