# Model for EDI_LIN table
class EdiLin < ActiveRecord::Base
  self.table_name = 'edi_lin'

  def self.primary_key
    row_id
  end

  def self.vendors
    select(:vend_id).uniq
  end

  def self.make_updates(vendor, invoice, line)
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

  def self.make_nobib(nobib_id)
    row = EdiLin.where(vend_unique_id: nobib_id).pluck(row_id.to_sym).first
    nobib = EdiLin.find(row)
    nobib.update(vend_unique_id: "#{nobib_id}noBib")
  end

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
