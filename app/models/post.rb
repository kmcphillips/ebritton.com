class Post < ActiveRecord::Base
  attr_accessible :title, :body, :image

  acts_as_permalink

  mount_uploader :image, ImageUploader

  validates :title, :presence => true
  validates :body, :presence => true

  scope :sorted, order("created_at DESC")
  scope :created_on, lambda{|date| where("DATE(created_at) BETWEEN ? AND ?", date, date).sorted } 

  class << self
    
    def find_legacy(date)
      created_on(Date.strptime(date, "%Y/%m/%d"))
    end

  end
end

