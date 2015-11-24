# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/image/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  
  # Create different versions of your uploaded files:
  version :original do
    process :resize_to_limit => [1920, 1680]
  end
  
  version :small do
    process :resize_to_fill => [50, 50, :north]
  end

  version :medium, from_version: :large do
    process :resize_to_limit => [250, 250]
  end

  version :large do
    process :resize_and_pad => [500, 500] # Resize the image to fit within the specified dimensions while retaining the original aspect ratio
    process :radial_blur => 10
  end

  # version :special do
  #   process :mogrify => [{
  #     :resolution => '108x369',
  #     :rotate => '90'
  #   }]
  # end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  private
    def radial_blur(amount)
    manipulate! do |img|
      img.radial_blur(amount)
      img = yield(img) if block_given?
      img
    end
  end

end
