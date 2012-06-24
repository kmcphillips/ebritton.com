ActiveAdmin.register Block, :as => "Text" do

  config.clear_sidebar_sections!

  actions :all, :except => [:new, :destroy]

  config.comments = false

  menu :priority => 3

  controller do
    defaults :finder => :find_by_label
  end

  index :download_links => false do
    column :section do |block|
      block.label.humanize
    end
    default_actions
  end

  show :title => lambda{ |b| b.label.humanize } do |block|
    attributes_table do
      row :image do
        if block.image.present?
          image_tag(block.image.url)
        else
          "None"
        end
      end
      row :body do
        render :partial => "admin/shared/body", :object => block
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :label, :label => "Section", :input_html => { :disabled => true }
      f.input :body, :input_html => {:class => "body"}, :hint => markdown_message
      f.input :image, :hint => "Appears at the top of this section."
    end

    f.buttons
  end

end
