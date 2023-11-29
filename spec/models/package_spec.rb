require 'rails_helper'

RSpec.describe Package do
  before do
    @package = create(:package)
  end

  it 'has a valid factory' do
    expect(@package).to be_valid
  end

  describe 'package id is immutable' do
    before do
      @package.update(package_id: 'id')
    end

    it 'raises an error' do
      expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'provides an error message' do
      expect(@package.errors.full_messages).to eq(['Package ID is marked as readonly.'])
    end
  end

  describe 'afs_path is not present for AFS data_pickup_type' do
    before do
      @package.update(afs_path: '')
    end

    it 'raises an error' do
      expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'validated the package' do
      expect(@package).not_to be_valid
    end

    it 'provides an error message' do
      expect(@package.errors.full_messages).to eq(['AFS directory path cannot be empty.'])
    end
  end

  describe 'when FTP information is not present for FTP data_pickup_type' do
    before do
      @package.update(data_pickup_type: 'FTP')
      @package.update(ftp_server: '')
    end

    it 'raises an error' do
      expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'adds an error message' do
      expect(@package.errors.full_messages).to eq(['FTP server cannot be empty.'])
    end
  end

  describe 'when AFS and FTP information is not present for FTP to AFS data_pickup_type' do
    before do
      @package.update(data_pickup_type: 'FTP to AFS')
      @package.update(afs_path: '')
      @package.update(ftp_server: '')
    end

    it 'raises an error' do
      expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'adds an error message' do
      expect(@package.errors.full_messages).to eq(['AFS directory path cannot be empty.',
                                                   'FTP server cannot be empty.',
                                                   'FTP to AFS download directory path cannot be empty.'])
    end
  end

  describe 'when FTP to AFS download directory path is not present for FTP to AFS data_pickup_type' do
    before do
      @package.update(data_pickup_type: 'FTP to AFS')
      @package.update(put_file_loc: '')
    end

    it 'raises an error' do
      expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'adds an error message' do
      expect(@package.errors.full_messages).to eq(['FTP to AFS download directory path cannot be empty.'])
    end
  end

  describe 'when match_opts is empty but proc_type is newmerge or mergeonly' do
    before do
      @package.update(match_opts: nil)
    end

    it 'raises an error' do
      expect { @package.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'adds an error message' do
      expect(@package.errors.full_messages)
        .to eq(["#{described_class.human_attribute_name('match_opts')} cannot be empty."])
    end
  end

  describe 'when oracle date formats are used' do
    before do
      @package.update(package_status: 'Inactive')
    end

    xit 'date entered has a value' do
      expect(@package.date_entered.strftime('%T'))
        .to eq Time.zone.parse(I18n.l(Time.now.getlocal, format: :oracle)).strftime('%T')
    end

    it 'date modified is updated' do
      expect(@package.date_modified.strftime('%T'))
        .to eq Time.zone.parse(I18n.l(Time.now.getlocal, format: :oracle)).strftime('%T')
    end
  end
end
