class AddDateToDncs < ActiveRecord::Migration[6.0]
  def change
    add_column :dncs, :date, :date
  end
end
