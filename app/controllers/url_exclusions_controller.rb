# UrlExclusions controller
class UrlExclusionsController < ApplicationController
  before_action :set_url_exclusion, only: %i[edit update destroy]

  # GET /url_exclusions
  # GET /url_exclusions.json
  def index
    @url_exclusions = UrlExclusion.all
  end

  # GET /url_exclusions/new
  def new
    @url_exclusion = UrlExclusion.new
  end

  # GET /url_exclusions/1/edit
  def edit; end

  # POST /url_exclusions
  # POST /url_exclusions.json
  def create
    @url_exclusion = UrlExclusion.new(url_exclusion_params)

    respond_to do |format|
      if @url_exclusion.save
        format.html { redirect_to url_exclusions_url, notice: 'Url exclusion was successfully created.' }
        format.json { render :show, status: :created, location: @url_exclusion }
      else
        format.html { render :new }
        format.json { render json: @url_exclusion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /url_exclusions/1
  # PATCH/PUT /url_exclusions/1.json
  def update
    respond_to do |format|
      if @url_exclusion.update(url_exclusion_params)
        format.html { redirect_to url_exclusions_url, notice: 'Url exclusion was successfully updated.' }
        format.json { render :show, status: :ok, location: @url_exclusion }
      else
        format.html { render :edit }
        format.json { render json: @url_exclusion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /url_exclusions/1
  # DELETE /url_exclusions/1.json
  def destroy
    @url_exclusion.destroy
    respond_to do |format|
      format.html { redirect_to url_exclusions_url, notice: 'Url exclusion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_url_exclusion
    @url_exclusion = UrlExclusion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def url_exclusion_params
    params.require(:url_exclusion).permit(:url_substring)
  end
end
