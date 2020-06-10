class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.belongs_to :territory, null: false, foreign_key: true
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
