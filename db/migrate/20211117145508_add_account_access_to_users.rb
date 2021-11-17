class AddAccountAccessToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :account_access, :boolean
  end
end
