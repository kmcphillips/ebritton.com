class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    if model.is_a?(Block)
      "uploads"
    else
      "uploads/#{mounted_as}/#{model.class.to_s.underscore}/#{model.id}"
    end
  end

  process resize_to_fit: [700, 700]

  version :thumb do
    process resize_to_fit: [160, 160]
  end

  version :column do
    process resize_to_fit: [360, 360]
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
