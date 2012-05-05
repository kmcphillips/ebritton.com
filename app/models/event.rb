class Event < ActiveRecord::Base
  acts_as_permalink

  validates :title, :presence => true
  validates :body, :presence => true
  
end
