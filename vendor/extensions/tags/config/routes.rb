Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :tags do
    resources :tags, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :tags, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :tags, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
