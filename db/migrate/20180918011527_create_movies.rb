class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.date :publish
      t.string :cover
      t.string :english_name
      t.integer :rate

      t.timestamps
    end
    add_index :movies, :name
    add_index :movies, :publish
    add_index :movies, :rate
  end
end
