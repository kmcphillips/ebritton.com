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

  
end
