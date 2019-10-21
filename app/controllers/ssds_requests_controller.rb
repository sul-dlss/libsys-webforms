# Controller for SSDS request form
class SsdsRequestsController < ApplicationController
  def index
    @ssds_request = SsdsRequest.new(ssds_request_params)
  end

  def new
    @ssds_request = SsdsRequest.new(new_ssds_request_params)
  end

  def create
    @ssds_request = SsdsRequest.new(ssds_request_params)
    WebformsMailer.ssds_request(@ssds_request).deliver_now
    flash[:notice] = 'SSRC will be notified of your request'
    render 'index', ssds_request_params
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def ssds_request_params
    params.require(:ssds_request).permit(:affiliation, :call_no_in, :dataset_type, :department, :name,
                                         :notes, :phone, :sponsor, :sunet, :title_in, :unicorn_id_in)
  end

  def new_ssds_request_params
    params.permit(:call_no_in, :title_in, :unicorn_id_in)
  end
end
