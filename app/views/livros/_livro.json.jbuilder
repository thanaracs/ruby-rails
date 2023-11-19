json.extract! livro, :id, :imagem_nome, :imagem_caminho, :titulo, :autores, :ano_lancamento, :nota, :editora, :opiniao, :created_at, :updated_at
json.url livro_url(livro, format: :json)
