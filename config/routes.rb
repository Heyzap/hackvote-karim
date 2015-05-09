Rails.application.routes.draw do
  root 'hackdays#index'

  resources :hackdays, :except => [:new] do
    patch :close_voting, :on => :member
  end

  resources :projects, :except => [:new, :index] do
    member do
      patch :upvote, :downvote
    end
  end
end
