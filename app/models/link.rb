class Link < ActiveRecord::Base
  attr_accessible :url, :title, :description

  validates :url, :format => {:with => URI::regexp(%w(http https)), :message => "is not a valid website, including the protocol"}


  scope :sorted, order("created_at DESC")
end
