class Project < ActiveRecord::Base
  attr_accessible :title, :body, :happened_at, :written, :file_title

  acts_as_permalink

  validates :title, :presence => true
  validates :body, :presence => true

  validate :file_with_title

  mount_uploader :image, ImageUploader
  mount_uploader :file, FileUploader
  
  scope :sorted, order("created_at DESC")
  scope :written, where(:written => true)
  scope :other, where(:written => false)


  protected

  def file_with_title
    if file.present? && !file_title.present?
      self.errors.add(:file_title, "must be set if a file is attached")
    end

    if !file.present? && file_title.present?
      self.errors.add(:file_title, "must be left blank if no file is being attached")
    end
  end
end
