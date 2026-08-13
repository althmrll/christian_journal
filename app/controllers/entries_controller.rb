class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy ]

  # GET /entries or /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1 or /entries/1.json
  def show
    @entry = Entry.find(params[:id])
    @entries = Entry.order(created_at: :desc)
  end

  # GET /entries/new
  def new
    @entry = Entry.new
    @cancel = cancel_path
  end

  # GET /entries/1/edit
  def edit
    @cancel = entry_path(@entry)
  end

  # POST /entries or /entries.json
  def create
    @entry = Entry.new(entry_params)
    @return_to = params[:return_to]
    @origin_id = params[:origin_id]

    if @entry.save
      redirect_to @entry, notice: "Entry created successfully!"
    else
      @cancel = cancel_path
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: "Entry was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @entry.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy!
    if params[:return_to] == "show"
      last_entry = Entry.order(created_at: :desc).first
      if last_entry
        redirect_to last_entry, notice: "Entry deleted."
      else
        redirect_to entries_path, notice: "Entry deleted. No remaining entries."
      end
    else
      redirect_to entries_path, notice: "Entry deleted."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.expect(entry: [ :title, :content ])
    end

    def cancel_path
      if params[:return_to] == "show" && params[:origin_id].present? && Entry.exists?(params[:origin_id])
        entry_path(params[:origin_id])
      else
        entries_path
      end
    end
end
