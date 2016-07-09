class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :favorite, index: true,

      t.timestamps null: false
    end
  end
end
