class AddCongregationToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscriptions, :congregation, null: false, foreign_key: true
  end
end
