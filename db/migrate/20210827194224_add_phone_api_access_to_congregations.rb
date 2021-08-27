class AddPhoneApiAccessToCongregations < ActiveRecord::Migration[6.0]
  def change
    add_column :congregations, :phone_api_access, :boolean
  end
end
