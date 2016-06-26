class FavoritesController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @favorite = current_user.favorites.build(favorite_params)
    if @favorite.save
      flash[:success] = "Favorite created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
