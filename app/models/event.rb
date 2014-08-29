class Event < ActiveRecord::Base
  acts_as_permalink

  mount_uploader :image, ImageUploader

  validates :title, :presence => true
  validates :body, :presence => true
  validates :days, :numericality => {:greater_than => 0, :allow_nil => false}
  validates :starts_at, :presence => true

  before_validation :set_ends_at

  scope :upcoming, lambda{ where("ends_at > ?", Time.now).order("starts_at DESC") }
  scope :past, lambda{ where("ends_at < ?", Time.now).order("starts_at DESC") }

  def sort_by
    starts_at
  end

  protected

  def set_ends_at
    self.ends_at = self.starts_at + self.days.days if self.starts_at && self.days
  end

end
