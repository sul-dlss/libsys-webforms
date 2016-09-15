require 'rails_helper'

RSpec.describe CirculationStatisticsReportLog, type: :model do
  let(:barcode_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('files/test_file.txt', 'text/plain')
  end
  it 'has a valid factory' do
    expect(FactoryGirl.create(:circulation_statistics_report_log)).to be_valid
  end
  describe '#process_range_type_params' do
    it 'constructs barcode type params' do
      report = FactoryGirl.build(:circulation_statistics_report, range_type: 'barcodes', barcodes: barcode_file)
      log_params = CirculationStatisticsReportLog.process_range_type_params(report)
      expect(log_params).to eq('call_range' => 'Any call (Selection is barcode list test_file.txt)',
                               'input_path' => '/s/SUL/Dataload/Uploads/CircStats/test_test_file.txt',
                               'libs_locs' => 'Any lib-loc')
    end

    it 'constructs lc range type params where call_hi is blank' do
      report = FactoryGirl.build(:circulation_statistics_report)
      log_params = CirculationStatisticsReportLog.process_range_type_params(report)
      expect(log_params).to eq('call_range' => 'K',
                               'libs_locs' => 'ARS/RECORDINGS,ART/ARTLCKM/ARTLCKS,GREEN/BENDER,SAL3')
    end

    it 'constructs lc range type params where call_lo includes #' do
      report = FactoryGirl.build(:circulation_statistics_report, call_lo: 'L#')
      log_params = CirculationStatisticsReportLog.process_range_type_params(report)
      expect(log_params).to eq('call_range' => 'L0-9999',
                               'libs_locs' => 'ARS/RECORDINGS,ART/ARTLCKM/ARTLCKS,GREEN/BENDER,SAL3')
    end

    it 'constructs lc range type params where call_hi is not blank' do
      report = FactoryGirl.build(:circulation_statistics_report, call_hi: 'LZ')
      log_params = CirculationStatisticsReportLog.process_range_type_params(report)
      expect(log_params).to eq('call_range' => 'K-LZ',
                               'libs_locs' => 'ARS/RECORDINGS,ART/ARTLCKM/ARTLCKS,GREEN/BENDER,SAL3')
    end

    it 'constructs classic range type params where call_alpha is blank' do
      report = FactoryGirl.build(:circulation_statistics_report, range_type: 'classic',
                                                                 call_lo: 1,
                                                                 call_hi: 2)
      log_params = CirculationStatisticsReportLog.process_range_type_params(report)
      expect(log_params).to eq('call_range' => '1-2',
                               'libs_locs' => 'ARS/RECORDINGS,ART/ARTLCKM/ARTLCKS,GREEN/BENDER,SAL3')
    end

    it 'constructs classic range type params where call_alpha is not blank' do
      report = FactoryGirl.build(:circulation_statistics_report, range_type: 'classic',
                                                                 call_alpha: 'L',
                                                                 call_lo: 1,
                                                                 call_hi: 2)
      log_params = CirculationStatisticsReportLog.process_range_type_params(report)
      expect(log_params).to eq('call_range' => 'L1-2',
                               'libs_locs' => 'ARS/RECORDINGS,ART/ARTLCKM/ARTLCKS,GREEN/BENDER,SAL3')
    end

    it 'constructs other range type params when call_hi is blank' do
      report = FactoryGirl.build(:circulation_statistics_report, range_type: 'other', call_lo: '')
      log_params = CirculationStatisticsReportLog.process_range_type_params(report)
      expect(log_params).to eq('call_range' => 'NOT LC/DEWEY',
                               'libs_locs' => 'ARS/RECORDINGS,ART/ARTLCKM/ARTLCKS,GREEN/BENDER,SAL3')
    end

    it 'constructs other range type params when call_hi is not blank' do
      report = FactoryGirl.build(:circulation_statistics_report, range_type: 'other', call_lo: '', call_hi: '123')
      log_params = CirculationStatisticsReportLog.process_range_type_params(report)
      expect(log_params).to eq('call_range' => 'NOT LC/DEWEY: 123',
                               'libs_locs' => 'ARS/RECORDINGS,ART/ARTLCKM/ARTLCKS,GREEN/BENDER,SAL3')
    end
  end

  describe '#build_output_type' do
    it 'returns a value based on the barcode file basename' do
      report = FactoryGirl.build(:circulation_statistics_report, range_type: 'barcodes', barcodes: barcode_file)
      output_hash = CirculationStatisticsReportLog.build_output_type(report)
      expect(output_hash[:output_name]).to include('test_file')
    end

    it "returns a value based on 'circ_rpt'" do
      report = FactoryGirl.build(:circulation_statistics_report, range_type: 'lc')
      output_hash = CirculationStatisticsReportLog.build_output_type(report)
      expect(output_hash[:output_name]).to include('circ_rpt')
    end
  end
  describe '#save_stats' do
    it 'gets circ stats params' do
      report = FactoryGirl.build(:circulation_statistics_report, range_type: 'barcodes', barcodes: barcode_file)
      output_hash = CirculationStatisticsReportLog.build_output_type(report)
      path = report.barcodes.tempfile.path
      expect(output_hash[:output_name]).to include('test_file')
      expect(report.barcodes).to be_a(Rack::Test::UploadedFile)
      expect(path).to include('test_file')
    end
  end
end
