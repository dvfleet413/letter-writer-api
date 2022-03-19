class AddOwnershipToExternalContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :external_contacts, :ownership, :string
  end
end
