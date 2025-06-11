# Controller to handle the Accession Number Generator landing page
class AccessionNumberUpdatesController < ApplicationController
  def index
    @locations = AccessionNumber.select('location').distinct.where.not(resource_type: [nil]).order('location ASC')
    @resource_types = AccessionNumber.select('resource_type').distinct.where.not(resource_type: [nil])
                                     .order('resource_type ASC')
  end

  def by_location
    @location = AccessionNumber.where('location = ? AND resource_type IS NOT ?', location_params[:location], nil)
                               .order('resource_type')
  end

  def by_resource_type
    @resource_type = AccessionNumber.where(resource_type: resource_type_params[:resource_type]).order('location')
  end

  private

  def location_params
    params.permit(:location)
  end

  def resource_type_params
    params.permit(:resource_type)
  end
end
