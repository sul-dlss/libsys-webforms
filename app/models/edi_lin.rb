# Model for EDI_LIN table
class EdiLin < ActiveRecord::Base
  self.table_name = 'edi_lin'

  def self.vendors
    select(:vend_id).uniq
  end

  def self.update_edi_lin(vendor, invoice, line)
    edi_lin = where('vend_id = ? AND doc_num = ? AND edi_lin_num = ? AND edi_sublin_count = 0', vendor, invoice, line)
    if ids_match?(EdiSumrzBib.id(edi_lin.vend_unique_id), edi_lin.vend_unique_id)
      ['error', 'Cannot set this invoice line to "noBib." This invoice line has a bib match in Symphony. '\
      'It should not need to be set to "allow noBib"']
    else
      make_nobib(edi_lin.vend_unique_id)
      EdiSumrzBib.insert(edi_lin)
      ['notice', "EDI Line updated with new ID: #{edi_lin.vend_unique_id} : "\
       "EDI_SUMRZ_BIB created with ckey: #{EdiSumrzBib.ckey(edi_lin.vend_unique_id)}"]
    end
  end

  def self.update_barcode(vendor, invoice, line, subline, old_barcode, new_barcode)
    row = EdiLin.where(vend_id: vendor,
                       doc_num: invoice,
                       edi_lin_num: line,
                       edi_sublin_count: subline,
                       barcode_num: old_barcode).pluck(barcode_id).first
    barcode = EdiLin.find(row)
    barcode.update(barcode_num: new_barcode)
    ['notice', "EDI Line for #{barcode.vend_id}, #{barcode.doc_num} updated with new barcode: #{barcode.barcode_num}"]
  end

  def self.make_nobib(nobib_id)
    nobib = EdiLin.find_by(vend_unique_id: nobib_id)
    nobib.vend_unique_id = "#{nobib_id}noBib"
    nobib.save
  end

  def self.vend_unique_id
    pluck(:vend_unique_id)[0].to_s
  end

  def self.ids_match?(id001, vend_id)
    id001.casecmp(vend_id).zero?
  end

  def self.barcode_id
    if database =~ /sqlite3/
      'id'.to_sym
    else
      'rowid'.to_sym
    end
  end

  def self.database
    Rails.configuration.database_configuration[Rails.env]['database']
  end
end
