Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :stories do
    resources :stories, :path => ''
  end

  # Admin routes
  namespace :stories, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :stories, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
