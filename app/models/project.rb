class Project < ActiveRecord::Base
  attr_accessible :title, :body, :happened_at

  scope :sorted, order("created_at DESC")


end
