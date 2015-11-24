class Carrierwave
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  mount_uploader :file, FileUploader, mount_on: :file_filename
  mount_uploader :image, ImageUploader, mount_on: :image_filename
end