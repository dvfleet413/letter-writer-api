class AddCongreagtionToTerritories < ActiveRecord::Migration[6.0]
  def change
    add_reference :territories, :congregation, null: false, foreign_key: true
  end
end
