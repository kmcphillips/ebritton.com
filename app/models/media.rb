class Media < ActiveRecord::Base
  mount_uploader :file, FileUploader

  scope :secret, ->{ where(secret: true) }
  scope :playlist, ->{ where(playlist: true) }
  scope :sorted, ->{ order("created_at DESC") }
end
