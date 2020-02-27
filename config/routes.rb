Rails.application.routes.draw do
  post '/hooks', to: 'webhooks#receive', as: :receive_webhooks
end
