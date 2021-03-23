class AddApiAccessToCongregations < ActiveRecord::Migration[6.0]
  def change
    add_column :congregations, :api_access, :boolean
  end
end
