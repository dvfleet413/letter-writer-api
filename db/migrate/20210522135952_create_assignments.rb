class CreateAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :assignments do |t|
      t.belongs_to :territory, null: false, foreign_key: true
      t.string :publisher
      t.date :checked_out
      t.date :checked_in

      t.timestamps
    end
  end
end
