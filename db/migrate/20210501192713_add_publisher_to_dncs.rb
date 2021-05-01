class AddPublisherToDncs < ActiveRecord::Migration[6.0]
  def change
    add_column :dncs, :publisher, :string
  end
end
