class Post < ActiveRecord::Base
  attr_accessible :title, :body, :image

  acts_as_permalink

  mount_uploader :image, ImageUploader

  validates :title, :presence => true
  validates :body, :presence => true

end
