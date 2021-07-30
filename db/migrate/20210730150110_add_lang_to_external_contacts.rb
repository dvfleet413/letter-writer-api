class AddLangToExternalContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :external_contacts, :lang, :string
  end
end
