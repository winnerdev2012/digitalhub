Refinery::Core::Engine.routes.draw do

  namespace :announcements do
    resources :announcements, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :announcements, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :announcements, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
