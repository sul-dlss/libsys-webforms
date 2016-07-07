require 'rails_helper'

RSpec.describe ExpendituresPaydates, type: :model do
  it 'Defines a list of calendar years' do
    expect(ExpendituresPaydates.calendar_years).to include('1996', '1997', '1998', '1999', '2000')
  end
  it 'Defines a list of calendar years' do
    expect(ExpendituresPaydates.fiscal_years).to include('9899', '9798', '9697', '2015')
  end
  it 'Defines a list of paid dates' do
    expect(ExpendituresPaydates.pay_dates).to be_kind_of(ActiveRecord::Relation)
  end
end
