ActiveAdmin.register PlaylistItem do

  config.clear_sidebar_sections!

  menu :priority => 4

  index :download_links => false do
    column :name
    column "File" do |media|
      link_to media.file.file.filename, media.becomes(Media).file_url
    end
    default_actions
  end

  actions :all, :except => [:show]

  form do |f|
    f.inputs do
      f.input :name
      f.input :file, :hint => "Must be an mp3 file."
    end

    f.buttons
  end
end
