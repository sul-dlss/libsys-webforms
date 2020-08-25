##
# Package controller for eloader
##
class PackagesController < ApplicationController
  load_and_authorize_resource

  before_action :set_package, only: %i[show edit update destroy activate deactivate]

  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.all
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
    @package = Package.find(params[:id])
  end

  # GET /packages/new
  def new
    if params.key?(:package_id)
      @test_package = TestPackage.find_by(package_id: params[:package_id])
      if @test_package
        @package = Package.new(@test_package.attributes.slice(*Package.attribute_names - ['record_id']))
      else
        flash[:error] = 'Package ID doesn\'t exists!'
        redirect_to packages_path
      end
    else
      @package = Package.new
    end
  end

  # GET /packages/1/edit
  def edit; end

  # POST /packages
  # POST /packages.json
  def create
    update_special_attributes
    # vendor_id_write isn't actually used by vnd_load_data_eload but the value
    # 001 is written to the table
    package_params[:vendor_id_write] = '001'
    @package = Package.new(package_params)
    respond_to do |format|
      if @package.save
        format.html { redirect_to @package }
        flash[:success] = 'Package was successfully created.'
        format.json { render :show, status: :created, location: @package }
      else
        format.html { render :new }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      update_special_attributes
      if @package.update(package_params)
        format.html { redirect_to @package }
        flash[:success] = 'Package was successfully updated.'
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  def activate
    @package.update(package_status: 'Active')
    redirect_to packages_path
    flash[:success] = 'Package activated.'
  end

  def deactivate
    @package.update(package_status: 'Inactive')
    redirect_to packages_path
    flash[:warning] = 'Package deactivated.'
  end

  # # DELETE /packages/1
  # # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to @package, notice: 'Package was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def run_tests() end

  def list_transfer_logs
    # get vnd_runlog entries for the procedure just kicked off and related log entries
    @logs = VndRunlog.all.where('run_date >= ? AND LOWER(procedure_name) LIKE LOWER(?)',
                                l(Time.now.getlocal, format: :oracle), 'VND%')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_package
    @package = Package.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def package_params
    params.require(:package).permit!
  end

  def update_special_attributes
    make_access_urls_plats(url_config_params) if url_config_params.values.any?
    make_match_opts if package_params[:match_opts].present?
    make_ftp_file_prefix if package_params[:no_ftp_search].present?
  end

  def url_config_params
    { url_substring: package_params[:url_substring],
      link_text: package_params[:link_text],
      provider_name: package_params[:provider_name],
      collection_name: package_params[:collection_name],
      access_type: package_params[:access_type] }
  end

  def make_access_urls_plats(url_config_params)
    url_settings = ''
    url_config_params.values.transpose.each do |x|
      url_settings << "#{x.join("\t")}|"
    end
    url_settings = url_settings.gsub(/(\t{4}\|)+/, '')
    package_params.merge!(access_urls_plats: url_settings)
  end

  def make_match_opts
    options = []
    package_params[:match_opts].each do |opt|
      opt = nil if opt.to_i.zero?
      options.push(opt)
    end
    options = options.reject(&:blank?).join(',')
    options = nil if options.empty?
    package_params.merge!(match_opts: options)
  end

  def make_ftp_file_prefix
    package_params.merge!(ftp_file_prefix: 'NO FTP SEARCH ***') if package_params[:no_ftp_search] == '0'
  end
end
