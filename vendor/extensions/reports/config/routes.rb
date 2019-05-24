Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :reports do
    resources :reports, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :reports, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :reports, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
