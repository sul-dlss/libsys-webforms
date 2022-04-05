# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

def basic_permissions
  [BatchRecordUpdate, UniUpdatesErrors, UniUpdMhldError]
end

def user_permissions
  [BatchRecordUpdate]
end

def staff_specified_permissions
  [AccessionNumber, DigitalBookplatesBatch, Sal3BatchRequestsBatch]
end

def staff_create_permissions
  [IlliadUserExport, UserloadRerun]
end

def staff_read_permissions
  [EdiErrorReport, EdiInvoice, Package, PackageFile, Sal3BatchRequestsBc]
end

def staff_manage_permissions
  [AccessionNumberUpdate, BatchRecordUpdate, ChangeCurrentLocation, ChangeHomeLocation, ChangeItemType,
   CirculationStatisticsReport, EdiErrorReport, EdiInvLine, EdiInvoice, EdiLin, EncumbranceReport,
   EndowedFundsReport, ExpenditureReport, ExpendituresWithCircStatsReport, LobbytrackReport,
   ManagementReport, Sal3BatchRequestsBatch, ShelfSelectionReport, TransferItem, UniUpdatesBatch,
   WithdrawItem]
end

def admin_permissions
  [AccessionNumber, AuthorizedUser, DigitalBookplatesBatch, Package, TestPackage, VndRunlog]
end

def only_authorized_permissions
  perms = staff_specified_permissions \
  + staff_create_permissions \
  + staff_read_permissions \
  + staff_manage_permissions \
  + admin_permissions

  perms -= [BatchRecordUpdate]
  perms
end

RSpec.describe Ability do
  subject { ability }

  let(:ability) { described_class.new(user) }

  context 'with authenticated login only' do
    let(:user) { nil }

    basic_permissions.each do |r|
      it { is_expected.to be_able_to(:read, r.new) }
    end

    only_authorized_permissions.each do |r|
      it { is_expected.not_to be_able_to(:manage, r.new) }
    end
  end

  context 'with no abilities in authorized user table' do
    let(:user) { create(:blank_user) }

    it { is_expected.to be_able_to(:manage, BatchRecordUpdate.new) }
  end

  context 'with staff specified permissions' do
    let(:user) { create(:staff_user) }

    context 'with accession number' do
      it 'can read accession numbers' do
        expect(ability).to be_able_to(:read, AccessionNumber.new)
      end

      it 'can generate a new accession number' do
        expect(ability).to be_able_to(:generate_number, AccessionNumber.new)
      end

      it 'can generate a batch of accession numbers' do
        expect(ability).to be_able_to(:generate_number_form, AccessionNumber.new)
      end
    end

    context 'with digital bookplates batches' do
      it 'can read batches in the queue and completed' do
        expect(ability).to be_able_to(:read, DigitalBookplatesBatch.new)
      end

      it 'can create a batch' do
        expect(ability).to be_able_to(:create, DigitalBookplatesBatch.new)
      end

      it 'can destroy a batch' do
        expect(ability).to be_able_to(:destroy, DigitalBookplatesBatch.new)
      end

      it 'can create an \'add\' batch type' do
        expect(ability).to be_able_to(:add_batch, DigitalBookplatesBatch.new)
      end
    end

    context 'with Sal3 batch request batches' do
      it 'can create a batch request' do
        expect(ability).to be_able_to(:create, Sal3BatchRequestsBatch.new)
      end

      it 'can read the queue and completed batch requests' do
        expect(ability).to be_able_to(:read, Sal3BatchRequestsBatch.new)
      end

      it 'can update a batch request' do
        expect(ability).to be_able_to(:update, Sal3BatchRequestsBatch.new)
      end

      it 'can download the barcodes file for a batch' do
        expect(ability).to be_able_to(:download, Sal3BatchRequestsBatch.new)
      end
    end
  end

  context 'with staff read permissions' do
    let(:user) { create(:staff_user) }

    staff_read_permissions.each do |r|
      it { is_expected.to be_able_to(:read, r.new) }
    end
  end

  context 'with staff manage permissions' do
    let(:user) { create(:authorized_user) }

    staff_manage_permissions.each do |r|
      it { is_expected.to be_able_to(:manage, r.new) }
    end

    staff_create_permissions.each do |r|
      it { is_expected.to be_able_to(:create, r.new) }
    end
  end

  context 'with admin permissions' do
    let(:user) { create(:admin_user) }

    it 'can create new accession numbers' do
      expect(ability).to be_able_to(:manage, AccessionNumber.new)
    end

    it 'can manage authorized users' do
      expect(ability).to be_able_to(:manage, AuthorizedUser.new)
    end

    it 'can create a batch to delete digital bookplate data' do
      expect(ability).to be_able_to(:delete_batch, DigitalBookplatesBatch.new)
    end

    it 'can manage packages' do
      expect(ability).to be_able_to(:manage, Package.new)
    end

    it 'can run e-resource package test loads' do
      expect(ability).to be_able_to(:run_tests, Package.new)
    end

    it 'can list logs for e-resource package test loads' do
      expect(ability).to be_able_to(:list_transfer_logs, Package.new)
    end

    it 'can list logs from vnd_runlog' do
      expect(ability).to be_able_to(:read, VndRunlog.new)
    end
  end
end
