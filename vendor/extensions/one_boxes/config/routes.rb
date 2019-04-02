Refinery::Core::Engine.routes.draw do

  # Admin routes
  namespace :one_boxes, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :one_boxes, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
