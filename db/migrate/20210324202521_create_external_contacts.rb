class CreateExternalContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :external_contacts do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.belongs_to :congregation, null: false, foreign_key: true
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
