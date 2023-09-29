json.extract! bill, :id, :customer_id, :bill_date, :total_amount, :created_at, :updated_at
json.url bill_url(bill, format: :json)
