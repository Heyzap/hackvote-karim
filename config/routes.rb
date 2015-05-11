Rails.application.routes.draw do
  root 'hackdays#index'

  resources :hackdays, :except => [:new] do
    member do
      patch :close_voting
    end
  end

  resources :projects, :except => [:new, :index, :destroy] do
    member do
      patch :upvote, :downvote
    end
  end
end
