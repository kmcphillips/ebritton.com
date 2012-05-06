class Block < ActiveRecord::Base
  attr_accessible :image, :body

  mount_uploader :image, ImageUploader

  validates :label, :presence => true



  class << self
    [:bio, :contact].each do |label|
      define_method label do
        find_by_label! label.to_s
      end
    end
  end
end
