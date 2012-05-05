class Post < ActiveRecord::Base
  acts_as_permalink

  validates :title, :presence => true
  validates :body, :presence => true

  attr_accessible :title, :body
end
