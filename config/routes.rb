Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: redirect('/posts')

  scope module: :users do
    resources :posts, only: %i[new edit create update destroy] do
      resource :like, only: %i[create destroy], module: :posts
      resources :replies, only: %i[new create], module: :posts, as: :posts
    end
  end

  resources :posts, only: %i[index show] do
    resources :ancestors, only: %i[index], module: :posts
    resources :replies, only: %i[index], module: :posts
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
