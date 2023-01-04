require 'rails_helper'

RSpec.describe IlliadUserExport do
  let(:path_to_file) { Settings.symphony_illiad_user_export }

  before do
    FileUtils.mkdir_p('tmp/Dataload/ILLiadUserExport')
  end

  after do
    FileUtils.rm_rf(path_to_file)
  end

  it 'validates that sunet ids are submitted' do
    @form = described_class.new(sunet_ids: nil)
    @form.valid?
    expect(@form.errors.messages[:sunet_ids]).to include "can't be blank"
  end

  it 'writes a file of sunet_ids' do
    @form = described_class.new(sunet_ids: 'sunetone\n\rsunettwo')
    @form.send(:write_ids)
    expect(File.read(path_to_file).strip).to eq 'sunetone\n\rsunettwo'
  end
end
