Rails.application.routes.draw do
  scope defaults: {format: :json} do
    resources :users, only: [:index, :show, :create, :update] do
      post :login, on: :collection
    end
    resources :games, only: [:index, :show]
    resources :game_ownerships, only: [:index, :create, :update, :destroy]
    resources :friendships, only: [:index, :destroy]
    resources :friendship_invites, only: [:index, :create, :destroy] do
      post :accept, on: :member
    end
    resources :teams, only: [:index, :show, :create]
    resources :team_memberships, only: [:index, :create, :update, :destroy]
    resources :conversation_participants, only: [:index]
    resources :conversations, only: [:create, :show]
    resources :messages, only: [:index]
    resources :team_membership_invites, only: [:index, :create, :destroy] do
      post :accept, on: :member
    end
    resources :team_membership_requests, only: [:index, :create, :destroy] do
      post :accept, on: :member
    end
    resources :notifications, only: [:index] do
      post :check, on: :collection
    end
  end
end
