class PrayersController < ApplicationController
  before_action :set_prayer, only: %i[ show edit update destroy ]

  # GET /prayers or /prayers.json
  def index
    case params[:filter]
    when "answered"
        @prayers = Prayer.answered
    when "unanswered"
        @prayers = Prayer.unanswered
    else
        @prayers = Prayer.all
    end
  end

  # GET /prayers/1 or /prayers/1.json
  def show
  end

  # GET /prayers/new
  def new
    @prayer = Prayer.new
  end

  # GET /prayers/1/edit
  def edit
  end

  # POST /prayers or /prayers.json
  def create
    @prayer = Prayer.new(prayer_params)

    respond_to do |format|
      if @prayer.save
        format.html { redirect_to @prayer, notice: "Prayer was successfully created." }
        format.json { render :show, status: :created, location: @prayer }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @prayer.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /prayers/1 or /prayers/1.json
  def update
    respond_to do |format|
      if @prayer.update(prayer_params)
        format.html { redirect_to @prayer, notice: "Prayer was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @prayer }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @prayer.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /prayers/1 or /prayers/1.json
  def destroy
    @prayer.destroy!

    respond_to do |format|
      format.html { redirect_to prayers_path, notice: "Prayer was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def answered
      @prayer = Prayer.find(params[:id])
      @prayer.update(answered: true)
      redirect_to prayers_path(filter: "unanswered"), notice: "Prayer marked as answered!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prayer
      @prayer = Prayer.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def prayer_params
      params.expect(prayer: [ :prayer, :specification ])
    end
end
