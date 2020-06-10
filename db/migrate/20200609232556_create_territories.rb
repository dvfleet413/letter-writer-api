class CreateTerritories < ActiveRecord::Migration[6.0]
  def change
    create_table :territories do |t|
      t.string :name

      t.timestamps
    end
  end
end
