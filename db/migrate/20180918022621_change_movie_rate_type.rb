class ChangeMovieRateType < ActiveRecord::Migration[5.0]
  def change
    change_column :movies, :rate, :string
  end
end
