# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ExpendituresFyDate.destroy_all
dates = [
  ['9697', '04-OCT-1996', '08-AUG-1997'],
  ['9798', '12-SEP-1997', '28-AUG-1998'],
  ['9899', '11-SEP-1998', '27-AUG-1999'],
  ['2000', '10-SEP-1999', '01-SEP-2000'],
  ['2001', '08-SEP-2000', '31-AUG-2001'],
  ['2002', '07-SEP-2001', '30-AUG-2002'],
  ['2003', '06-SEP-2002', '29-AUG-2003'],
  ['2004', '05-SEP-2003', '27-AUG-2004'],
  ['2005', '03-SEP-2004', '26-AUG-2005'],
  ['2006', '02-SEP-2005', '30-AUG-2006'],
  ['2007', '08-SEP-2006', '30-AUG-2007'],
  ['2008', '07-SEP-2007', '28-AUG-2008'],
  ['2009', '05-SEP-2008', '27-AUG-2009'],
  ['2010', '04-SEP-2009', '26-AUG-2010'],
  ['2011', '03-SEP-2010', '25-AUG-2011'],
  ['2012', '02-SEP-2011', '24-AUG-2012'],
  ['2013', '31-AUG-2012', '23-AUG-2013'],
  ['2014', '30-AUG-2013', '11-OCT-2013'],
  ['2015', '04-DEC-2014', '29-JAN-2015'],
  ['2016', '04-DEC-2015', '29-JAN-2016'],
  ['2017', '04-DEC-2016', '29-JAN-2017']
]
dates.each do |fy, min, max|
  ExpendituresFyDate.create(fy: fy, min_paydate: min, max_paydate: max)
end
