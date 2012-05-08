class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  storage :file

  def store_dir
    if model.is_a?(Block)
      "uploads"
    else
      "uploads/#{mounted_as}/#{model.class.to_s.underscore}/#{model.id}"
    end
  end

  process :resize_to_fit => [700, 700]

  version :thumb do
    process :resize_to_fit => [160, 160]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    if model.is_a?(Block)
      "#{model.label}.jpg"
    else
      original_filename
    end
  end

end
