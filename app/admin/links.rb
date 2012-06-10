ActiveAdmin.register Link do
  filter :title
  filter :url

  config.sort_order = "id DESC"

  actions :all, :except => :show

  index :download_links => false do
    column :title
    column :description
    column "URL", :sortable => :url do |link|
      link_to link.url, link.url
    end
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :url, :hint => "Must start with http:// or https://", :as => :url
      f.input :title
      f.input :description, :as => :text, :input_html => {:rows => 3}
    end
      
    f.buttons
  end

end
