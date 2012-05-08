class Project < ActiveRecord::Base
  attr_accessible :title, :body, :happened_at

  acts_as_permalink

  mount_uploader :image, ImageUploader
  
  belongs_to :media

  scope :sorted, order("created_at DESC")


end
