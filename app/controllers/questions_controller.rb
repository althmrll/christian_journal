class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy answered ]

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
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        current_filter = params[:filter].presence || (@question.answer.present? ? "answered" : "unanswered")
        format.html { redirect_to questions_path(filter: current_filter), notice: "Question was successfully updated.", status: :see_other }
        format.json { render :questions_path, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
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

  # PATCH /questions/1/answered
  def answered
    # Marks as answered and redirects directly to the answered tab
    if @question.update(answer: params[:answer].presence || "Answered")
      redirect_to questions_path(filter: "answered"), notice: "Question marked as answered!"
    else
      redirect_to questions_path, alert: "Could not mark question as answered."
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question, :answer)
  end
end
