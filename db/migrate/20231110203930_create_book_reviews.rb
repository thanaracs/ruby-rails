class CreateBookReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :book_reviews do |t|
      t.references :livro, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating
      t.text :opinion

      t.timestamps
    end
  end
end
