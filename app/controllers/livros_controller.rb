class LivrosController < ApplicationController
  before_action :set_livro, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /livros or /livros.json
  def index
    @livros = Livro.all
    @livros_classificados = Livro.includes(:book_reviews).where.not(book_reviews: { rating: nil })    
    
    @livros = Livro.joins(:book_reviews)

  end
  
  # GET /livros/1 or /livros/1.json
  def show
  end

  # GET /livros/new
  def new
    @livro = Livro.new
  end

  # GET /livros/1/edit
  def edit
  end

  # POST /livros or /livros.json
  def create
    @livro = Livro.new(livro_params)

    respond_to do |format|
      if @livro.save
        format.html { redirect_to registered_book_path, notice: "Livro was successfully created." }
        format.json { render :show, status: :created, location: @livro }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @livro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /livros/1 or /livros/1.json
  def update
    respond_to do |format|
      if @livro.update(livro_params)
        format.html { redirect_to livro_url(@livro), notice: "Livro was successfully updated." }
        format.json { render :show, status: :ok, location: @livro }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @livro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /livros/1 or /livros/1.json
  def destroy
    @livro.destroy!

    respond_to do |format|
      format.html { redirect_to livros_url, notice: "Livro was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def avaliar
    @livro = Livro.find(params[:id])
    @book_review = @livro.book_reviews.new
  end

  def save_avaliacao
    @livro = Livro.find(params[:id])
    @book_review = @livro.book_reviews.new(book_review_params)
  
    if @book_review.save
      redirect_to livro_avaliacoes_path(@livro)
    else
      render :avaliar
    end
  end

  def avaliacoes
    @livro = Livro.find(params[:id])
    @avaliacoes = @livro.book_reviews
  end

  def todos_livros
    if params[:search]
      @livros = Livro.where("titulo LIKE ? OR autores LIKE ? OR editora LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @livros = Livro.all
    end
  end

  def favoritar
    livro = Livro.find(params[:id])
    current_user.favorites.create(livro: livro)
    redirect_to todos_livros_path, notice: 'Livro favoritado com sucesso.'
  end

  def desfavoritar
    livro = Livro.find(params[:id]) 
    current_user.favorites.find_by(livro: livro).destroy
    redirect_to todos_livros_path, notice: 'Livro removido dos favoritos.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_livro
      @livro = Livro.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def livro_params
      params.require(:livro).permit(:imagem_nome, :imagem_caminho, :titulo, :autores, :ano_lancamento, :nota, :editora, :opiniao)
    end
end
