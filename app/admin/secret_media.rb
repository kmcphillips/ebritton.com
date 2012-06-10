ActiveAdmin.register SecretMedia do
  filter :name
  filter :description

  index :download_links => false do
    column :name
    column :description
    column "File" do |media|
      link_to media.file.file.filename, media.becomes(Media).file_url
    end
    default_actions
  end

  actions :all, :except => [:show]

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :file
    end

    f.buttons
  end

end
