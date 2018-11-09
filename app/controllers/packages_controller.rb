##
# Package controller for eloader-pkg-admin app
##
class PackagesController < ApplicationController
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
    @package = Package.new
  end

  # GET /packages/1/edit
  def edit; end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)
    respond_to do |format|
      if @package.save
        set_access_urls_plats(url_config_params)
        set_match_opts(package_params[:match_opts])
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
      if @package.update(package_params)
        set_access_urls_plats(url_config_params)
        set_match_opts(package_params[:match_opts])
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_package
    @package = Package.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def package_params
    params.require(:package).permit!
  end

  def url_config_params
    { url_substring: params[:url_substring],
      link_text: params[:link_text],
      provider_name: params[:provider_name],
      collection_name: params[:collection_name],
      access_type: params[:access_type]
    }
  end

  def set_access_urls_plats(url_config_params)
    url_settings=''
    url_config_params.values.transpose.each do |x|
      url_settings << x.join("\t") + '|'
    end
    url_settings=url_settings.gsub(/(\t{4}\|)+/, '')
    @package.update(access_urls_plats: url_settings)
  end

  def set_match_opts(match_opts)
    options=[]
    match_opts.each do |opt|
      opt = nil if opt.to_i.zero?
      options.push(opt)
    end
    options = options.reject(&:blank?).join(',')
    options = nil if options.empty?
    @package.update(match_opts: options)
  end
end
