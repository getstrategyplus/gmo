Rails.application.routes.draw do
  root to: 'newsletters#index', as: 'outside_root'
  scope :plus do
    root to: 'newsletters#show', as: 'root'
    get ':date', to: 'newsletters#show', as: :newsletter_show
    post 'subscribe', to: 'application#subscribe', as: :subscribe
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
