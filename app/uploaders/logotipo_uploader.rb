class LogotipoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [70, 70]
  end

  version :slider do
    process resize_to_fit: [nil, 200]
  end

  version :square do
    process resize_to_limit: [110, 110]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
