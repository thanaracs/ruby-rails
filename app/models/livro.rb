class Livro < ApplicationRecord
    has_many :book_reviews
    has_many :favorites
    has_many :favorited_by, through: :favorites, source: :user
    validates :ano_lancamento, :titulo, :autores, :editora, presence: { message: "não pode ser deixado em branco" }

    livro = Livro.find(1)
    avaliacoes = livro.book_reviews

    def calcular_media_notas
        return 0 if book_reviews.empty?
    
        total_notas = book_reviews.sum(:rating)
        total_notas.to_f / book_reviews.count
      end
end
  