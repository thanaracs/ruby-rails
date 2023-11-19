class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favoritos = current_user.favorited_books
  end
  
end
