class Article < ApplicationRecord
    belongs_to :author
    belongs_to :category
    
    has_many :comments, dependent: :destroy
    
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    
    validates :title, presence: true, length: {minimum: 5}
    is_impressionable
    
    has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
    validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

    # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    
    def tag_list
        self.tags.collect { |tag| tag.name }.join(", ")
    end
    
    def tag_list=(tags_string)
        tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
        new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name)}
        self.tags = new_or_found_tags
    end
    
    scope :published, -> { where(published: true) }
    
    scope :created_before, -> (time) { where("created_at < ?", time) }
    scope :created_after,  -> (time) { where("created_at > ?", time) }
end



