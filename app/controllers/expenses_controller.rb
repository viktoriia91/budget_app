class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]

  def index
    if params[:year].present?
      @selected_year = params[:year].to_i
    else
      # Set a default selected year, for example, the current year
      @selected_year = Date.current.year
    end

    if params[:month]
      @selected_month = Date::MONTHNAMES.index(params[:month])
      @expenses = Expense.where('extract(month from date) = ? AND extract(year from date) = ?', @selected_month, params[:year])
      start_date = Date.new(params[:year].to_i, @selected_month, 1)
      end_date = start_date.end_of_month
      @days_in_month = (start_date..end_date).map(&:day).to_a

      @values_per_day = @days_in_month.map do |day|
        @expenses.where('extract(day from date) = ?', day).sum(:amount)
      end
    else
      @expenses = Expense.where('extract(year from date) = ?', @selected_year)
    end

      @months = Date::MONTHNAMES.compact

      @years = Expense.pluck(:date).map(&:year).uniq.sort.reverse

      @expenses_by_year_and_month = @expenses.group_by { |expense| [expense.date.year, expense.date.month] }

      @monthly_sums = []

      # Calculate monthly sums for each year and month
      @expenses_by_year_and_month.each do |year_month, expenses|
        total_amount = expenses.sum(&:amount)
        @monthly_sums << total_amount
      end

      # Group expenses by day
      @expenses_by_day = @expenses.order(date: :desc).group_by { |expense| expense.date.strftime("%A, %d %B") }
  end

  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expenses_url, notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy!

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:name, :date, :amount, :description, :category_id)
    end
end
