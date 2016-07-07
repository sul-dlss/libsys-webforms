# app/model/shelf_sel_search.rb
class ShelfSelSearch < ActiveRecord::Base
  self.table_name = 'shelf_sel_searches'

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
