Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root 'pages#home'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_up: 'signup' }, controllers: { registrations: 'registrations' }
  get 'logout', to: 'pages#logout', as: 'logout'

  resources :bookings, only: [:new, :create]
  get 'book', to: 'bookings#index', as: 'book'

  resources :addons, only: [:index, :create]

  resources :checkout, only: [:index]
  resources :dashboard, only: [:index], path: 'reservations'
  resources :account, only: %i[index update] do
    get :stop_impersonating, on: :collection
  end
  resources :payments, only: [:create] do
    get 'confirm', on: :collection
  end
  resources :blog_posts, path: 'blog', param: :slug

  # static pages
  pages = %w[
    changelog thanks privacy terms
  ]

  pages.each do |page|
    get "/#{page}", to: "pages##{page}", as: page.gsub('-', '_').to_s
  end

  # admin panels
  authenticated :user, lambda(&:admin?) do
    # insert sidekiq etc
    mount Split::Dashboard, at: 'admin/split'
  end
end
