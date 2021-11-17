class RemovePublisherFromAssignments < ActiveRecord::Migration[6.0]
  def change
    remove_column :assignments, :publisher
  end
end
