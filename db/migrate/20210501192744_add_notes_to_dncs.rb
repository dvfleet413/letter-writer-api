class AddNotesToDncs < ActiveRecord::Migration[6.0]
  def change
    add_column :dncs, :notes, :string
  end
end
