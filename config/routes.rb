EbrittonCom::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: "blog#index"

  resources :blog, only: [:index, :show] do
    collection do
      get :archive
    end
  end

  get "feed.:format" => "blog#feed"
  get "rss.xml" => "blog#feed", :format => "rss"

  [:bio, :contact].each do |block|
    get block.to_s => "blocks##{block}"
  end  

  get "p" => "blocks#secret"
  get "playlist" => "blocks#playlist"

  resources :links, only: [:index]
  resources :projects, only: [:index, :show]
  resources :events, only: [:index, :show]

  match "admin/preview" => "preview#index", via: [:get, :post]

  ## Legacy PHP URLs
  %w[blog events bio bloghistory works links contact].each do |page|
    get "#{page}.php" => "legacy##{page}"
  end

  # Catch all remaining PHP pages and send them somewhere
  get ":page.php" => "legacy#default"

  # Legacy file locations
  get "/media/:filename" => "legacy#media"

end

