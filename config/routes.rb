MyLmp::Application.routes.draw do
	
  devise_for :users,  
	     :controllers => { :registrations => "users/registrations", 
	               	       :confirmations => "users/confirmations",
			       :sessions      => 'devise/sessions'
  			     },

				     :skip	  => [:sessions] do
			     	     get '/signin'		=> "devise/sessions#new",
			     		     :as		=> :new_user_session
			     	     post '/signin'		=> 'devise/sessions#create',
			     		     :as		=> :user_session
			     	     get '/signup'		=> "users/registrations#new",
			     		     :as		=> :new_user_registration
			     	     delete '/signout' 	=> 'devise/sessions#destroy',
			     		     :as    		=> :destroy_user_session
		     		     put "confirm_account", :to => "confirmations#confirm_account"

				     end

  devise_for :suppliers,
             :controllers => { :registrations	=> "suppliers/registrations",
        		       :sessions	=> 'devise/sessions'
  			  },

				  :skip	       => [:sessions] do
				  get 'suppliers/signin'	=> "devise/sessions#new",
					  :as			=> :new_supplier_session
				  post '/suppliers/signin'	=> 'devise/sessions#create',
					  :as			=> :supplier_session
				  get  '/suppliers/signup'	=> "suppliers/registrations#new",
					  :as			=> :new_supplier_registration
				  delete '/suppliers/signout'	=> 'devise/sessions#destroy',
					  :as			=> :destroy_supplier_session
				  get  '/suppliers/invitation'  => 'devise/invitations#new',
   					     :as		=> :new_supplier_invitation


				  end
			     	       	     
  root :to => 'pages#home'			     


  # These routes were used prior to integrating devise
  #
  # resources :sessions, :only => [:new, :create, :destroy]
  # resources :invites, :only => [:new, :create]
  # match '/signin', :to =>  'sessions#new'
  # match '/signout', :to => 'sessions#destroy'
  resources  :users
  resources :user_contacts, :only => [:new, :create, :edit, :update, :destroy]
  resources  :profile_photos, :only => [:new, :create, :edit, :update]  
  resources  :suppliers
  resources  :listings
  resources  :accounts		  
  resources  :contacts, :only => [:new, :create, :destroy]
  resources  :recommendations, :only => [:new, :create, :accept_recommendation] do
	  match "accept_recommendation", :to => 'recommendations#accept_recommendation',
		  :as => :accept_recommendation
  end
  resources  :user_alerts, :only => [:new, :create, :update, :destroy] do
      	  resources  :recommenders, :only => [:new, :create, :edit, :update]
  end    


  match '/pricing', :to => 'pages#pricing'
  match '/about', :to =>   'pages#about'
  # match '/contact', :to => 'pages#contact'
  match '/invite', :to =>  'invites#create'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
