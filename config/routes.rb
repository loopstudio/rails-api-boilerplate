Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        passwords: 'api/v1/auth/passwords',
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions',
        token_validations: 'api/v1/auth/token_validations'
      }, skip: [:omniauth_callbacks]

      get 'users/profile', to: 'users#profile'
    end
  end
end
