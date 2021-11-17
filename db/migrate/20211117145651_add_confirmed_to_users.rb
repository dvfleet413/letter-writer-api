class AddConfirmedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmed, :boolean, :null => false, :default => false
  end
end
