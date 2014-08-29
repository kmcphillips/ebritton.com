class FileUploader < CarrierWave::Uploader::Base

  def store_dir
    "uploads/#{model.class.base_class.to_s.underscore}/#{model.id}"
  end

end
