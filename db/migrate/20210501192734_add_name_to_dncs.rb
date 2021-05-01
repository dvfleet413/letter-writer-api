class AddNameToDncs < ActiveRecord::Migration[6.0]
  def change
    add_column :dncs, :name, :string
  end
end
