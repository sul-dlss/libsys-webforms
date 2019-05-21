###
# Controller to destroy saved searches
###
class ShelfSelSearchesController < ApplicationController
  def delete_saved_search
    ShelfSelSearch.find([params[:user_name], params[:search_name]]).delete
    render nothing: true
  end
end
