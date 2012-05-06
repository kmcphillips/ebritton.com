class Event < ActiveRecord::Base
  acts_as_permalink

  validates :title, :presence => true
  validates :body, :presence => true
  validates :days, :numericality => {:greater_than => 0, :allow_nil => false}
  validates :starts_at, :presence => true

  attr_accessible :title, :body, :starts_at, :days

  before_validation :set_ends_at

  

  protected

  def set_ends_at
    self.ends_at = self.starts_at + self.days.days if self.starts_at && self.days
  end

end
