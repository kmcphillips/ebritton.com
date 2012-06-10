class BlocksController < ApplicationController

  layout :select_layout

  def bio
    load_sidebar :projects
    @title = "Bio"
    @nav = :bio
    @bio = Block.bio
  end

  def contact
    load_sidebar :projects
    @title = "Contact"
    @bio = :contact
    @contact = Block.contact
  end

  def secret
    @media = SecretMedia.sorted
  end

  def playlist
    respond_to do |wants|
      wants.xml do
        @tracks = PlaylistItem.sorted
      end
    end
  end

  private

  def select_layout
    if action_name == "secret"
      "secret"
    else
      "application"
    end
  end

end

