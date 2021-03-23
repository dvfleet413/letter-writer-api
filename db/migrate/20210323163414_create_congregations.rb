class CreateCongregations < ActiveRecord::Migration[6.0]
  def change
    create_table :congregations do |t|
      t.string :name

      t.timestamps
    end
  end
end
