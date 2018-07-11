# Controller to handle Edi Error Report requests
class EdiErrorReportsController < ApplicationController
  load_and_authorize_resource
  has_scope :day

  def index
    @edi_error_report = apply_scopes(EdiErrorReport).all
  rescue StandardError => e
    flash[:error] = e.message
    redirect_to edi_error_reports_path
  end
end
