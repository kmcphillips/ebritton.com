class PlaylistItem < Media

  validate :must_be_an_mp3

  protected

  def must_be_an_mp3
    self.errors.add(:file, "must be an mp3") unless self.file.to_s.split(".").last.try(:downcase) == "mp3"
  end

end
