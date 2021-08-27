class AddAddressDetailsToExternalContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :external_contacts, :street, :string
    add_column :external_contacts, :city, :string
    add_column :external_contacts, :state, :string
    add_column :external_contacts, :zip, :string
  end
end
