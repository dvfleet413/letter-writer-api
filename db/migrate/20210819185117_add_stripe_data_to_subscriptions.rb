class AddStripeDataToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :product_id, :string
    add_column :subscriptions, :price_id, :string
  end
end
