class Project < ActiveRecord::Base
  attr_accessible :title, :body, :happened_at

  acts_as_permalink

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader
  
  scope :sorted, order("created_at DESC")


end
