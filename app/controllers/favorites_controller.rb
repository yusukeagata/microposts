class FavoritesController < ApplicationController
  before_action :logged_in_user, only: [:create]
  def create
    @favorite = Micropost.find(params[:micropost_id])
    current_user.favorites(@favorite)
  end

  def destroy
    @favorite = current_user.favorite_relations.find(params[:id]).micropost
    current_user.unfavorites(@favorite)
  end
  #def create
    #@favorite = current_user.favorite_relations.build(params[:id]).favorite
    #if @favorite.save
      #flash[:success] = "Favorite created!"
      #redirect_to root_url
    #else
      #render 'static_pages/home'
    #end
  #end
  

end