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
end
