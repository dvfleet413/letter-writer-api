class CreateCongPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :cong_points do |t|
      t.belongs_to :congregation, null: false, foreign_key: true
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
