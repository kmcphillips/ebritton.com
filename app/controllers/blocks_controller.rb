class BlocksController < ApplicationController

  def bio
    @bio = Block.bio
  end

  def contact
    @contact = Block.contact
  end

  def p
    @media = Media.secret.sorted
  end

end

