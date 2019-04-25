Refinery::Core::Engine.routes.draw do

  # Admin routes
  namespace :weigh_in_prompts, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :weigh_in_prompts, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end
end
