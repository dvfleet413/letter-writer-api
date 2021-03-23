class AddCongreagtionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :congregation, null: false, foreign_key: true
  end
end
