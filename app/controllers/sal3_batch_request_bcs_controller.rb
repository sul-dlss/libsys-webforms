# Controller to handle the request to view the barcodes for Sal3 batch requests
class Sal3BatchRequestBcsController < ApplicationController
  def show
    @sal3_batch_requests_batch = Sal3BatchRequestsBatch.find(params[:id])
    @sal3_batch_request_bcs = Sal3BatchRequestBcs.barcodes(params[:id])
  end
end
