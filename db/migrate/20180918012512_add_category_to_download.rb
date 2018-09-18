class AddCategoryToDownload < ActiveRecord::Migration[5.0]
  def change
    add_column :downloads, :category, :integer
  end
end
