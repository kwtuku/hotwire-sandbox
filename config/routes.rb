Rails.application.routes.draw do
  devise_for :users

  root to: redirect('/posts')
  resources :posts do
    resources :ancestors, only: %i[index], module: :posts
    resources :replies, only: %i[index new create], module: :posts, as: :posts
  end
end
