Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :taggings do
    resources :taggings, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :taggings, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :taggings, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
