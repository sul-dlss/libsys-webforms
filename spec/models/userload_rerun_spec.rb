require 'rails_helper'

RSpec.describe UserloadRerun, type: :model do
  before do
    FileUtils.mkdir_p('tmp/Dataload/UserloadRerun')
  end

  it 'validates that a rerun date is submitted' do
    @form = described_class.new(rerun_date: nil)
    @form.valid?
    expect(@form.errors.messages[:rerun_date]).to include "can't be blank"
  end

  it 'writes a file with a rerun_date' do
    @form = described_class.new(rerun_date: '2019-01-01')
    @form.send(:write_date)
    expect(File).to exist(Settings.symphony_userload_rerun)
  end
end
