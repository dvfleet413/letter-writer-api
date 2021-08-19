class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :stripe_id
      t.datetime :creation_date
      t.boolean :current_period_end
      t.boolean :cancel_at_period_end
      t.integer :price

      t.timestamps
    end
  end
end
