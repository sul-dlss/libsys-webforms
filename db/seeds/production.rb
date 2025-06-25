require 'csv'

AccessionNumber.delete_all

table = CSV.parse(File.read("db/seeds/catnums.csv"), headers: true)
table.each do |row|
  AccessionNumber.create!(
    id:  row[0],
    item_type: row[1],
    location: row[2],
    prefix: row[3],
    seq_num: row[4],
    resource_type: row[5]
  )  
end
