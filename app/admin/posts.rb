ActiveAdmin.register Post do
  filter :title
  filter :created_at

  config.comments = false

  menu :priority => 1

  controller do
    defaults :finder => :find_by_permalink
  end

  index :format => :blog, :download_links => false do
    column :title do |post|
      link_to post.title, admin_post_path(post)
    end
    column :created_at
    default_actions
  end

  show :title => :title do |post|
    attributes_table do
      row :title
      if post.imported?
        row :imported do
          imported_message
        end
      end
      row :created_at
      row :body do
        render :partial => "admin/shared/body", :object => post
      end
      row :image do
        if post.image.present?
          image_tag(post.image.url)
        else
          "None"
        end
      end
    end
  end

  form do |f|
    if f.object.imported?
      content_tag :h3, imported_message
    else
      f.inputs do
        f.input :title
        f.input :body, :input_html => {:class => "body"}, :hint => markdown_message
        f.input :image, :hint => "Appears at the top of the blog post."
      end
      
      f.buttons
    end
  end

end
