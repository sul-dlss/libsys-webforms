# app/model/shelf_sel_search.rb
class ShelfSelSearch < ActiveRecord::Base
  self.table_name = 'shelf_sel_searches'
  # TODO: make saved_cursors return more than just my own
  def self.saved_cursors(sunet_id)
    own_saved_cursor(sunet_id)
  end

  def self.own_saved_cursor(sunet_id)
    where(user_name: sunet_id).order(:search_name).pluck(:search_name, :user_name).map { |a| a.join(', ') }
  end
end
