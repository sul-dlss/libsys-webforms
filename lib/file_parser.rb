# module to help batch upload forms parse files
module FileParser
  def parse_uploaded_file
    item_ids.read.split("\n")
  end
end
