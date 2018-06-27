require 'rails_helper'

RSpec.describe EdiInvoice, type: :model do
  let(:vendors) { %w(YANKEE COUTTS CASALI AMALIV HARRAS) }
  it 'defines a set of unique vendors' do
    expect(EdiInvoice.edi_vend_id).to include(*vendors)
  end
  it 'defines the vendor filter for the table scope' do
    expect(EdiInvoice.vendor_filter).to include(*vendors.push('ALL'))
  end
end
