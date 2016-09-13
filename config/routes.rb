# frozen_string_literal: true
Rails.application.routes.draw do
  resources :servers

  root 'servers#index'

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
