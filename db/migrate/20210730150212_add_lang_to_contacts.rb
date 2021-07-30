class AddLangToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :lang, :string
  end
end
