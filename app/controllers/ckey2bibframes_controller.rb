# Controller for the Ckey2bibframe form
class Ckey2bibframesController < ApplicationController
  def show
    params[:baseuri] ||= Settings.base_uri
    @ckey2bibframe = Ckey2bibframe.new(baseuri: params[:baseuri], ckey: params[:ckey])
  end

  def new
    @ckey2bibframe = Ckey2bibframe.new
  end

  def create
    @ckey2bibframe = Ckey2bibframe.new(ckey2bibframe_params)

    if @ckey2bibframe.valid?
      render action: 'show'
    else
      flash[:warning] = 'Check that all form fields are entered!'
      render action: 'new'
    end
  end

  private

  def ckey2bibframe_params
    params.require(:ckey2bibframe).permit(:ckey, :baseuri)
  end
end
