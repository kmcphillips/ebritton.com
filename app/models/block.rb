class Block < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates :label, :presence => true

  def to_param
    self.label
  end

  class << self
    [:bio, :contact].each do |label|
      define_method label do
        find_by_label! label.to_s
      end
    end
  end
end
