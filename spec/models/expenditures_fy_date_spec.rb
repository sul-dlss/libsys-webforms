require 'rails_helper'

RSpec.describe ExpendituresFyDate do
  it 'has a valid factory' do
    expect(create(:expenditures_fy_date)).to be_valid
  end
end
