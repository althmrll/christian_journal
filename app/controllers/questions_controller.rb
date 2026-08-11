class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]

  # GET /questions or /questions.json
  def index
    @questions = case params[:filter]
    when "answered"
        Question.answered.order(created_at: :desc)
    when "all"
      Question.all.order(created_at: :desc)
    else
      Question.unanswered.order(created_at: :desc) # Default view
    end
  end

  # GET /questions/1 or /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_path(filter: params[:filter]), notice: "Question was successfully created." }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @question.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def answer
   @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to questions_path(filter: params[:filter].presence || "answered"), notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update
   respond_to do |format|
      if @question.update(entry_path)
        format.html { redirect_to questions_path(filter: params[:filter]), notice: "Entry was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @entry.errors, status: :unprocessable_content }
      end
    end
  end
  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy!

    respond_to do |format|
      format.html { redirect_to questions_path(filter: params[:filter]), notice: "Question was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def answered
    @question = Question.find(params[:id])
    @question.answer(answer: "Answered")
    redirect_to questions_path(filter: "answered"), notice: "Question marked as answered!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params.expect(:id))
    end

    def question_params
      params.require(:question).permit(:question, :answer)
    end
end
