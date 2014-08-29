class Link < ActiveRecord::Base
  validates :url, :format => {:with => URI::regexp(%w(http https)), :message => "is not a valid website, including the protocol"}

  scope :sorted, ->{ order("created_at ASC") }

end

