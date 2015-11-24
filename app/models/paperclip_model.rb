class PaperclipModel
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Paperclip

  #### IMAGE
  has_mongoid_attached_file :image,
    # :path           => "#{Rails.root}/public/uploads/paperclip_image/:attachment/:id/:style.:extension",
    # :storage        => :s3,
    # :url            => ':s3_alias_url',
    # :s3_host_alias  => 'something.cloudfront.net',
    # :s3_credentials => File.join(Rails.root, 'config', 's3.yml'),
    :styles => {
      :original => ['1920x1680>', :jpg], # thumbnail will only be modified if it is currently larger requested dimensions
      :small    => ['50x50#',   :jpg], # thumbnail will be centrally cropped, ensuring 100x100 dimensions & save to jpg
      :medium   => ['250x250',    :jpg], # thumbnail will be resized to requested dimensions
      :large    => ['500x500>',   :jpg]  # thumbnail will only be modified if it is currently larger requested dimensions
    },
    :convert_options => { :all => '-background white -flatten +matte -quality 75 -strip', small: '-rotate 90' }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  validates_attachment_presence :image


  #### FILE
  has_mongoid_attached_file :file
  validates_attachment_presence :file
end