class Tag < ApplicationRecord
    
    has_many :taggings, dependent: :delete_all
    has_many :articles, through: :taggings
    
    validates :name, presence: true
    
    def to_s
        name
    end
end
