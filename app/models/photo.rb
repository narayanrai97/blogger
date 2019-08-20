class Photo < ApplicationRecord
    # has_many :comments, dependent: :destroy_all
    has_attached_file :image, styles: { medium: "400x600#" }
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    s3_region: ENV["aws_region"]
end
