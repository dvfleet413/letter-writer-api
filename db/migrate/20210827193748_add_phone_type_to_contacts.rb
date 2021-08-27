class AddPhoneTypeToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :phone_type, :string
  end
end
