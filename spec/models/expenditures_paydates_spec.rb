require 'rails_helper'

RSpec.describe ExpendituresPaydates do
  describe 'calendar years' do
    it 'Defines a list of calendar years' do
      expect(described_class.calendar_years).to include('1996', '1997', '1998', '1999', '2000')
    end
  end

  describe 'fiscal years' do
    before do
      Date.fy_start_month = 9
      Date.use_forward_year!
      @financial_year = Time.zone.today.financial_year.to_s
    end

    it 'Defines a list of fiscal years' do
      expect(fiscal_years).to include('9899', '9798', '9697', '2015', @financial_year)
    end
  end

  describe 'paid dates' do
    it 'Defines a list of paid dates' do
      expect(described_class.pay_dates).to be_a(ActiveRecord::Relation)
    end
  end
end
