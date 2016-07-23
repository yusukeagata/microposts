class AddMicropostToFavorites < ActiveRecord::Migration
  def change
    add_reference :favorites, :micropost, index: true, foreign_key: true
  end
end
