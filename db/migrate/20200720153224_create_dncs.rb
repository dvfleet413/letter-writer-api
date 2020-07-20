class CreateDncs < ActiveRecord::Migration[6.0]
  def change
    create_table :dncs do |t|
      t.string :address
      t.belongs_to :territory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
