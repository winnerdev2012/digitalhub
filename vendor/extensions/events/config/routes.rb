Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :events do
    resources :events, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :events, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :events, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
