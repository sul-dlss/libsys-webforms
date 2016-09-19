# app/model/shelf_sel_search.rb
class ShelfSelSearch < ActiveRecord::Base
  self.table_name = 'shelf_sel_searches'
  self.primary_keys = :user_name, :search_name

  def self.save_search(shelf_sel_rpt)
    params = build_search_params(shelf_sel_rpt)
    ShelfSelSearch.create(params)
  end

  # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
  def self.build_search_params(shelf_sel_rpt)
    { user_name: shelf_sel_rpt.email.split('@')[0],
      search_name: shelf_sel_rpt.subj_name,
      call_range: "#{shelf_sel_rpt.call_alpha}#{shelf_sel_rpt.call_lo}-#{shelf_sel_rpt.call_hi}",
      lib: shelf_sel_rpt.lib,
      locs: shelf_sel_rpt.loc_array.join(',')[1..-1],
      fmts: shelf_sel_rpt.fmt_array.join(',')[1..-1],
      itypes: shelf_sel_rpt.itype_array.join(',')[1..-1],
      min_yr: shelf_sel_rpt.min_yr,
      max_yr: shelf_sel_rpt.max_yr,
      min_circ: shelf_sel_rpt.min_circ,
      max_circ: shelf_sel_rpt.max_circ,
      na_i_e_shadow: shelf_sel_rpt.shadowed.to_i,
      na_i_e_url: shelf_sel_rpt.url.to_i,
      na_i_e_dups: shelf_sel_rpt.has_dups.to_i,
      na_i_e_boundw: shelf_sel_rpt.no_boundw.to_i,
      na_i_e_cloc_diff: shelf_sel_rpt.cloc_diff.to_i,
      na_i_e_digisent: shelf_sel_rpt.digisent.to_i,
      na_i_e_mhlds: shelf_sel_rpt.mhlds.to_i,
      na_i_e_multvol: shelf_sel_rpt.multvol.to_i,
      na_i_e_multcop: shelf_sel_rpt.multcop.to_i,
      lang: shelf_sel_rpt.lang,
      icat1s: shelf_sel_rpt.icat1_array.join(',')[1..-1] }
  end
  # rubocop:enable Metrics/MethodLength,Metrics/AbcSize

  def self.saved_cursors(sunet_id)
    own_saved_cursor(sunet_id) + others_saved_cursor(sunet_id)
  end

  def self.own_saved_cursor(sunet_id)
    where(user_name: sunet_id).order(:search_name).pluck(:search_name, :user_name).map { |a| a.join(', ') }
  end

  def self.others_saved_cursor(sunet_id)
    where.not(user_name: sunet_id).order(:search_name).pluck(:search_name, :user_name).map { |a| a.join(', ') }
  end

  def self.from_search_name(search_name)
    # example search_name param: 'Green Stacks A-Z, azanella'
    search_name_array = search_name.split(',').map(&:strip)
    search_name = search_name_array[0]
    user_name = search_name_array[1]
    find_by(search_name: search_name, user_name: user_name)
  end

  def call_lo
    call_range.split('-')[0]
  end

  def call_hi
    call_range.split('-')[1]
  end
end
