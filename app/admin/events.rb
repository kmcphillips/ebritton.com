ActiveAdmin.register Event do
  filter :title
  filter :starts_at

  config.comments = false 

  controller do
    defaults :finder => :find_by_permalink
  end

  index :format => :blog do
    column :title do |event|
      link_to event.title, admin_event_path(event)
    end
    column :starts_at
    default_actions
  end

  show :title => :title do |event|
    attributes_table do
      row :title
      if event.imported?
        row :imported do
          imported_message
        end
      end
      row :starts_at
      row :days
      row :image do
        if event.image.present?
          image_tag(event.image.url)
        else
          "None"
        end
      end
      row :body do
        # This is the work around the fact that returning a string was not html_safe
        render :partial => "admin/events/body", :object => event
      end
    end
  end

  form do |f|
    if f.object.imported? && false
      imported_message
    else
      f.inputs do
        f.input :title
        f.input :body, :input_html => {:class => "body"}, :hint => markdown_message
        f.input :starts_at
        f.input :days, :hint => "Number of days the even lasts."
        f.input :image, :hint => "Appears at the top of the event."
      end
      
      f.buttons
    end
  end

end
