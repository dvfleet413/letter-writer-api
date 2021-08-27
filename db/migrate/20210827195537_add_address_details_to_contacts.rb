class AddAddressDetailsToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :street, :string
    add_column :contacts, :city, :string
    add_column :contacts, :state, :string
    add_column :contacts, :zip, :string
  end
end
