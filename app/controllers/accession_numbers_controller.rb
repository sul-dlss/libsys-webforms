# Controller to show, create, and edit accession numbers
class AccessionNumbersController < ApplicationController
  load_and_authorize_resource
  before_action :set_accession_number, only: %i[show edit update generate_number]

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
    if @accession_number.resource_type.empty?
      @accession_number.save
      redirect_to @accession_number
      flash[:notice] = 'Accession number was successfully created.'
      flash[:warning] = 'Assign a non-blank resource type to start generating numbers for it.'
    elsif @accession_number.save
      redirect_to @accession_number
      flash[:notice] = 'Accession number was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /accession_numbers/1
  def update
    if accession_number_params[:resource_type].blank?
      @accession_number.update(accession_number_params)
      redirect_to @accession_number
      flash[:notice] = 'Accession number was successfully updated.'
      flash[:warning] = 'Accession numbers with blank resource types are deprecated and cannot be used.'
    elsif @accession_number.update(accession_number_params)
      redirect_to @accession_number, notice: 'Accession number was successfully updated.'
    else
      render :edit
    end
  end

  # GET /accession_numbers/1/generate_number_form
  def generate_number_form() end

  # rubocop:disable Metrics/AbcSize
  # PATCH /accession_numbers/1/generate_number
  def generate_number
    if check_for_already_assigned_nums(@accession_number.id, @accession_number.seq_num.to_i)
      flash[:error] = 'Cannot generate accession number! The next number is already assigned.'
      redirect_to accession_number_updates_path
    else
      seq_num_incrementer = accession_number_params[:seq_num_incrementer].to_i
      seq_num_batch = set_seq_num_batch(@accession_number.seq_num.to_i, seq_num_incrementer)
      @accession_number.increment(:seq_num, accession_number_params[:seq_num_incrementer].to_i)
      @accession_number.save
      redirect_to @accession_number
      flash[:multi_line_notice] = list_accession_numbers(seq_num_batch, @accession_number.prefix)
      flash[:warning] = 'For Blu-ray, follow the accession number with BLU-RAY' if @accession_number.prefix == 'ZDVD'
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_accession_number
    @accession_number = AccessionNumber.find(params[:id])
  end

  def accession_number_params
    params.require(:accession_number).permit(:item_type, :location, :prefix, :resource_type, :seq_num_incrementer)
  end

  def check_for_already_assigned_nums(id, seq_num)
    # For catnums.id = "9" seq_num cannot exceed 10100 (ZVC 10101- is already assigned under catnums.id = "6")
    return true if id == 9 && seq_num >= 10_091
  end

  def set_seq_num_batch(seq_num, seq_num_incrementer)
    last_num = seq_num + seq_num_incrementer
    (seq_num + 1..last_num)
  end

  def list_accession_numbers(seq_num_batch, prefix)
    generated_numbers = []
    seq_num_batch.each do |num|
      generated_numbers << "Your SUL accession number: #{prefix} #{num}"
    end
    generated_numbers
  end
end
