# Controller to handle the Accession Number Generator landing page
class AccessionNumberUpdatesController < ApplicationController
  load_and_authorize_resource

  def index
    @locations = AccessionNumber.select('location').distinct.where.not(resource_type: [nil]).order('location ASC')
    @resource_types = AccessionNumber.select('resource_type').distinct.where.not(resource_type: [nil])
                                     .order('resource_type ASC')
  end

  def by_location
    @location = AccessionNumber.all.where('location = ? AND resource_type IS NOT ?', location_params[:location], nil)
                               .order('resource_type')
  end

  def by_resource_type
    @resource_type = AccessionNumber.all.where(resource_type: resource_type_params[:resource_type]).order('location')
  end

  private

  def location_params
    params.permit(:location)
  end

  def resource_type_params
    params.permit(:resource_type)
  end
end
