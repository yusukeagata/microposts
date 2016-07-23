class AddUserToFavorites < ActiveRecord::Migration
  def change
    add_reference :favorites, :user, index: true, foreign_key: true
  end
end
