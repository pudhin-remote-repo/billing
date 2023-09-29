require 'rails_helper'

RSpec.describe BillsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    let(:bill) { create(:bill) } # Assuming you have a way to create bills

    it 'returns a success response' do
      get :show, params: { id: bill.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { bill: { customer_email: 'test@example.com', customer_paid_amount: 100.0 } } }

      it 'creates a new Bill' do
        expect {
          post :create, params: valid_params
        }.to change(Bill, :count).by(1)
      end

      it 'redirects to the created bill' do
        post :create, params: valid_params
        expect(response).to redirect_to(bill_path(Bill.last))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { bill: { customer_email: 'invalid_email', customer_paid_amount: 100.0 } } }

      it 'does not create a new Bill' do
        expect {
          post :create, params: invalid_params
        }.to_not change(Bill, :count)
      end

      it 'redirects to the bills index page with a notice' do
        post :create, params: invalid_params
        expect(response).to redirect_to(bills_path)
        expect(flash[:notice]).to eq('Invalid email format')
      end
    end

    context 'with no bill items' do
      let(:invalid_params) { { bill: { customer_email: 'test@example.com', customer_paid_amount: 100.0 } } }

      it 'does not create a new Bill' do
        expect {
          post :create, params: invalid_params
        }.to_not change(Bill, :count)
      end

      it 'redirects to the bills index page' do
        post :create, params: invalid_params
        expect(response).to redirect_to(bills_path)
      end
    end
  end
end
