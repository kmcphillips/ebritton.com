ActiveAdmin.register Project do
  filter :title
  filter :file_title
  filter :created_at

  config.comments = false

  menu :priority => 3

  controller do
    defaults :finder => :find_by_permalink
  end

  index :download_links => false  do
    column :title do |project|
      link_to project.title, admin_project_path(project)
    end
    column :written, :sortable => :written do |project|
      project.written? ? "Yes" : "No"
    end
    column :file do |project|
      project.file.present? ? (project.file_title || "Yes") : "None"
    end
    default_actions
  end

  show :title => :title do |project|
    attributes_table do
      row :title
      if project.imported?
        row :imported do
          imported_message
        end
      end
      row :happened_at
      row :body do
        render :partial => "admin/shared/body", :object => project
      end
      row :file do
        if project.file.present?
          link_to project.file_title, project.file.url
        else
          "None"
        end
      end
      row :image do
        if project.image.present?
          image_tag(project.image.url)
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
        f.input :happened_at
        f.input :image, :hint => "Image to appear in the description."
        f.input :written, :hint => "Classify as a written project?", :as => :radio
      end

      f.inputs do
        f.input :file, :hint => "File download attached to project."
        f.input :file_title, :hint => "Description of the above file"
      end
      
      f.buttons
    end
  end
end
