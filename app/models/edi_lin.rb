# Model for EDI_LIN table
class EdiLin < ActiveRecord::Base
  self.table_name = 'edi_lin'

  def self.primary_key
    row_id
  end

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
      ['notice', "#{edi_lin.pluck(:vend_id)[0]} invoice #{edi_lin.pluck(:doc_num)[0]}, "\
                 "line #{edi_lin.pluck(:edi_lin_num)[0]} will be processed as a NOBIB. "\
                 "#{edi_lin.vend_unique_id} assigned ckey: #{EdiSumrzBib.ckey(edi_lin.vend_unique_id)}"]
    end
  end

  # We need to skip model validations on update because we can only retrieve the correct row using a 'where' finder
  # and only 'update_all' will work on this finding method.
  # rubocop:disable Rails/SkipsModelValidations
  def self.make_nobib(nobib_id)
    row = EdiLin.where(vend_unique_id: nobib_id).pluck(primary_key.to_sym).first
    EdiLin.where(row_id => row).update_all(vend_unique_id: "#{nobib_id}noBib")
  end

  def self.update_barcode(vendor, invoice, line, subline, old_barcode, new_barcode)
    row = EdiLin.where(vend_id: vendor,
                       doc_num: invoice,
                       edi_lin_num: line,
                       edi_sublin_count: subline,
                       barcode_num: old_barcode).pluck(primary_key.to_sym).first
    EdiLin.where(row_id => row).update_all(barcode_num: new_barcode)
    ['notice', "EDI Line for #{vendor}, #{invoice}, line #{line} updated with new barcode: #{new_barcode}"]
  end
  # rubocop:enable Rails/SkipsModelValidations

  def self.vend_unique_id
    pluck(:vend_unique_id)[0].to_s
  end

  def self.ids_match?(id001, vend_id)
    id001.casecmp(vend_id).zero?
  end

  def self.row_id
    if database =~ /sqlite3/
      'id'
    else
      'rowid'
    end
  end

  def self.database
    Rails.configuration.database_configuration[Rails.env]['database']
  end
end
