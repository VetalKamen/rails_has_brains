Rails.application.routes.draw do

  devise_for :users
  resources :items do
    get :upvote, on: :member
    get :expensive, on: :collection
  end

  get 'admin/users_count', to: "admin#users_count"

end
