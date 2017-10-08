Rails.application.routes.draw do
  root to: 'newsletters#show'
  get ':date', to: 'newsletters#show', as: :newsletter_show
  post 'subscribe', to: 'application#subscribe', as: :subscribe
end
