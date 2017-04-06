class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::ImageOptimizer

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :optimize
    process resize_to_fit: [100, 100]
  end

  version :large do
    process :optimize
    process resize_to_limit: [740, 350]
  end

  version :article do
    process :optimize
    process :crop
    process resize_to_fill: [740, 350]
  end

  def crop
    if model.crop_x.present?
      resize_to_limit(740, 350)
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i

        crop_params="#{w}x#{h}+#{x}+#{y}"
        img.crop(crop_params)
        img.strip
      end
    end
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
