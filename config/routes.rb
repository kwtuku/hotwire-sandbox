Rails.application.routes.draw do
  root to: redirect('/posts')
  resources :posts do
    resources :replies, only: %i[index new create], module: :posts, as: :posts
  end
end
