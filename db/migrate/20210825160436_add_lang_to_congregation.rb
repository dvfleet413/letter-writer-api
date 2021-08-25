class AddLangToCongregation < ActiveRecord::Migration[6.0]
  def change
    add_column :congregations, :lang, :string
  end
end
