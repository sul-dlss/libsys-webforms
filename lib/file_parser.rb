# module to help batch upload forms parse files
module FileParser
  def parse_uploaded_file
    item_ids.read.split("\n")
  end

  def parse_bc_file
    bc_file_obj.read.split("\n")
  end
end
