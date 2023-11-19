Rails.application.routes.draw do
  root "livros#index"

  resources :livros
  resources :book_reviews, path: 'classificacao', only: [:create, :index, :show, :edit, :update, :destroy]
  resources :home
  resources :livros do
    member do
      get 'avaliar'
      post 'save_avaliacao'
      get 'desfavoritar', to: 'livros#desfavoritar'
      get 'favoritar', to: 'livros#favoritar'
    end
  end

  devise_for :users#, controllers: { registrations: 'users' }

  get 'custom_logout', to: 'custom_sessions#destroy'
  get 'todos_livros', to: 'livros#todos_livros'
  get 'registered_book', to: 'livros#registered_book'
  get 'meus_favoritos', to: 'favorites#index', as: 'meus_favoritos'

end
