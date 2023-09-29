
require 'rails_helper'

RSpec.describe Bill, type: :model do
  describe 'Validation' do
    context 'customer email validation' do
      it 'email validation' do
        customer = Customer.create(email: "pudhin2@gmail.com")
        expect(customer).to be_valid
      end
      it 'email validation' do
        customer = Customer.create(email: "pudhin")
        expect(customer).to_not be_valid
      end
      it 'email validation' do
        customer = Customer.create(email: nil)
        expect(customer).to_not be_valid
      end
    end

    context 'Bill validation' do
      let(:customer) { Customer.create(email: "pudhin@gmail.com") }
      # it 'bill validation' do
      #   bill = Bill.create(customer: customer, customer_paid_amount: 100)
      #   expect(bill).to be_valid
      # end

      it 'bill validation fails when customer_id is missing' do
        bill = Bill.create(customer: nil, customer_paid_amount: 100)
        expect(bill).to_not be_valid
      end

      it 'bill validation fails when customer_paid_amount is missing' do
        bill = Bill.create(customer: customer, customer_paid_amount: nil)
        expect(bill).to_not be_valid
      end

    end

  end
end
