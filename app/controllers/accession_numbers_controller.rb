# Controller to show, create, and edit accession numbers
class AccessionNumbersController < ApplicationController
  load_and_authorize_resource
  before_action :set_accession_number, only: %i[show edit update]

  def index
    @accession_numbers = AccessionNumber.all.order(:resource_type, :location, :prefix)
  end

  # GET /accession_numbers/1
  # GET /accession_numbers/1.json
  def show() end

  # GET /accession_numbers/new
  def new
    @accession_number = AccessionNumber.new
  end

  # GET /accession_numbers/1/edit
  def edit() end

  # POST /accession_numbers
  # POST /accession_numbers.json
  def create
    @accession_number = AccessionNumber.new(accession_number_params)
    @accession_number.seq_num = '0'

    respond_to do |format|
      if @accession_number.save
        format.html { redirect_to @accession_number, notice: 'Accession number was successfully created.' }
        format.json { render :show, status: :created, location: @accession_number }
      else
        format.html { render :new }
        format.json { render json: @accession_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accession_numbers/1
  def update
    if @accession_number.update(accession_number_params)
      redirect_to @accession_number, notice: 'Accession number was successfully updated.'
    else
      render :edit
    end
  end

  def generate_number
    @generate_number = AccessionNumber.find_by(id: params[:id])
    if check_for_already_assigned_nums(@generate_number.id, @generate_number.seq_num)
      flash[:error] = 'Cannot generate accession number! The next number is already assigned.'
      redirect_to accession_number_updates_path
    else
      @generate_number.increment(:seq_num)
      @generate_number.save
      redirect_to @generate_number
      flash[:notice] = "Your SUL accession number: #{@generate_number.prefix} #{@generate_number.seq_num}"
      if @generate_number.prefix == 'ZDVD'
        flash[:alert] = 'For Blu-ray, follow the accession number with BLU-RAY'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_accession_number
    @accession_number = AccessionNumber.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def accession_number_params
    params.require(:accession_number).permit(:item_type, :location, :prefix, :resource_type)
  end

  def check_for_already_assigned_nums(id, seq_num)
    # For catnums.id = "9" seq_num cannot exceed 10100 (ZVC 10101- is already assigned under catnums.id = "6")
    return true if id == 9 && seq_num == 10_100
  end
end
