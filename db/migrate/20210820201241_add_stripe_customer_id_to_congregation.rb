class AddStripeCustomerIdToCongregation < ActiveRecord::Migration[6.0]
  def change
    add_column :congregations, :stripe_customer_id, :string
  end
end
