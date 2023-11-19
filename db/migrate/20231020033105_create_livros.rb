class CreateLivros < ActiveRecord::Migration[7.0]
  def change
    create_table :livros do |t|
      t.text :imagem_caminho
      t.string :titulo
      t.string :autores
      t.date :ano_lancamento
      t.text :idiomas
      t.integer :num_paginas
      t.integer :nota
      t.string :editora
      t.text :opiniao
      t.timestamps
    end
  end
end
