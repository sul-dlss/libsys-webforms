require 'rails_helper'

RSpec.describe EdiErrorReport, type: :model do
  it 'defines the kind of date query according to the database configuration' do
    expect(described_class.date_query).to eq('DATE(run) = ?')
  end
end
