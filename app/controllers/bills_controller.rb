class BillsController < ApplicationController
  before_action :set_bill, only: %i[ show ]
  before_action :set_denomination_currency

  # GET /bills or /bills.json
  def index
    @bill = Bill.new
  end

  # GET /bills/1 or /bills/1.json
  def show
    @bill_items = BillItem.includes(:product).where(bill_id: @bill)
    @balance_amount = format("%.2f", @bill.customer_paid_amount - (@bill.total_amount + @bill.total_tax).round(0))
    if @balance_amount.to_i >= 1
      @denomination_hash = calculate_balance_denomination_count(@balance_amount.to_i, @denomination_currency)
    else
      @denomination_hash = {500=>0, 200=>0, 100=>0, 50=>0, 20=>0, 10=>0, 2=>0, 1=>0}
    end
  end

  def create
    if params[:bill][:bill_items_attributes]
      @customer = Customer.find_or_create_by(email: params[:bill][:customer_email])
      if @customer.valid?
        @bill = Bill.new(bill_params.except(:customer_email))
        @bill.bill_date = Date.today
        @bill.customer_id = @customer.id
        respond_to do |format|
          if @bill.save
            format.html { redirect_to bill_path(@bill), notice: "Bill was successfully created." }
            format.json { render :show, status: :created, location: @bill }
          else
            format.html { render :index, status: :unprocessable_entity }
            format.json { render json: @bill.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to bills_path, notice: "Invalid email format"
      end
    else
      redirect_to bills_path, notice: "Bill must contain one or more items"
    end

  end




  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bill
    @bill = Bill.find(params[:id])
  end
  def set_denomination_currency
    @denomination_currency = [500, 200, 100, 50, 20, 10, 2, 1]
  end

  # Only allow a list of trusted parameters through.
  def bill_params
    params.require(:bill).permit(:customer_email, :customer_paid_amount, bill_items_attributes: [:id, :product_id, :quantity, :_destroy], denominations_attributes: [:id, :value, :count])
  end

  def calculate_balance_denomination_count(balance, denomination_currency)

    # Initialize a hash to store the count for each denomination
    denomination_count = {}

    # Calculate the count for each denomination based on the balance
    denomination_currency.each do |denomination_value|
      count = (balance / denomination_value).to_i
      denomination_count[denomination_value] = count

      # Update the balance for the next iteration
      balance -= count * denomination_value
    end

    denomination_count
  end

end
