# Controller to handle the request to view the barcodes for Sal3 batch requests
class Sal3BatchRequestsBcsController < ApplicationController
  authorize_resource

  def show
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.find(params[:id])
    @sal3_batch_requests_bcs = Sal3BatchRequestsBc.barcodes(params[:id])
  end
end
