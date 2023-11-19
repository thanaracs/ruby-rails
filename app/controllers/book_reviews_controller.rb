class BookReviewsController < ApplicationController
  before_action :authenticate_user!

    def index
      if params[:search]
        @livros = Livro.where("titulo LIKE ? OR autores LIKE ? OR editora LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
      else
        @livros = Livro.all
      end
    end

    def show
      @livro = Livro.find(params[:id])
      @book_review = BookReview.new
    end

    def create
      @livro = Livro.find(params[:book_review][:livro_id])
      if current_user.has_reviewed?(@livro)
        redirect_to @livro, notice: "Você já classificou este livro"
      else
        @review = BookReview.new(review_params)
        @review.user = current_user
  
        if @review.save
          redirect_to @livro, notice: "Livro classificado com sucesso"
        else
          render :new
        end
      end
    end
  
    private
  
    def review_params
      params.require(:book_review).permit(:livro_id, :rating, :opinion)
    end
  end
  