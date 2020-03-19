# Model for EdiSumrzBib
class EdiSumrzBib < ApplicationRecord
  self.table_name = 'edi_sumrz_bib'

  def self.insert(edi_lin)
    edi_sumrz_bib = EdiSumrzBib.new
    edi_sumrz_bib.vend_code = edi_lin.pluck(:vend_id)[0].to_s
    edi_sumrz_bib.id001 = edi_lin.pluck(:vend_unique_id)[0].to_s
    edi_sumrz_bib.edi_ckey = fake_ckey
    edi_sumrz_bib.load_date = I18n.l(Time.now.getlocal, format: :oracle)
    edi_sumrz_bib.active_record = nil
    edi_sumrz_bib.save
  end

  def self.id(vend_unique_id)
    select(:id001).where('lower(id001) = ?', vend_unique_id.downcase).pluck(:id001)[0].to_s
  end

  def self.fake_ckey
    ckey = minimum('edi_ckey') - 1
    ckey.negative? ? ckey : -1
  end

  def self.ckey(vend_unique_id)
    where(id001: vend_unique_id).pluck(:edi_ckey)[0].to_i
  end
end
